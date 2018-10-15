# 制作可安装镜像

### 1.打包LFS文件系统和内核文件
*在Ubuntu试用系统中*
```bash
tar zcvf ~/rootfs.tar.gz $LFS/* --exclude boot
tar zcvf ~/boot.tar.gz $LFS/boot/*
```
### 2.创建chroot系统(基于Ubuntu14.04.5）
*创建工作目录*
```bash
export WORK=/opt/work
```
*安装必备程序*
```bash
apt-get install debootstrap
apt-get install syslinux squashfs-tools genisoimage
```
*下载chroot镜像源*
```bash
mkdir -pv $WORK/chroot
cd $WORK
debootstrap --arch=amd64 trusty chroot http://mirrors.tuna.tsinghua.edu.cn/ubuntu/
```
*chroot环境准备*
```bash
mount --bind /dev $WORK/chroot/dev
cp /etc/hosts $WORK/chroot/etc/hosts
cp /etc/resolv.conf $WORK/chroot/etc/resolv.conf
cp /etc/apt/sources.list $WORK/chroot/etc/apt/sources.list
apt-key exportall > $WORK/chroot/key
```
*为chroot环境安装必备软件*
```bash
chroot $WORK/chroot
mount none -t proc /proc
mount none -t sysfs /sys
mount none -t devpts /dev/pts
export HOME=/root
export LC_ALL=C
apt-get add key
rm -f key
apt-get update
apt-get install --yes dbus
dbus-uuidgen > /var/lib/dbus/machine-id
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl
apt-get --yes upgrade
apt-get install --yes ubuntu-standard casper lupin-casper
apt-get install --yes discover laptop-detect os-prober
apt-get install --yes linux-generic
apt-get install --yes vim
apt-get purge --yes linux-header-3.13.0-96
apt-get autoremove
rm /var/lib/dbus/machine-id
rm /sbin/initctl
dpkg-divert --rename --remove /sbin/initctl
rm -rf /var/lib/apt/lists/mirrors.*
rm -rf /usr/share/man/*
rm -rf /usr/share/doc/*
apt-get clean
rm -rf /tmp/*
rm /etc/resolv.conf
umount -lf /proc
umount -lf /sys
umount -lf /dev/pts
exit

umount $WORK/chroot/dev
```
### 3.ISO镜像设置
*创建镜像目录结构*
```bash
cd $WORK
mkdir -p image/{casper,isolinux,install}
```
*拷贝内核和initrd文件到镜像目录*
cp $WORK/chroot/boot/vmlinuz-3.13.**-**-generic $WORK/image/casper/vmlinuz
cp $WORK/chroot/boot/initrd.img-3.13.**-**-generic $WORK/image/casper/initrd.gz
```
*复制Ubuntu系统的isolinux引导程序到镜像目录*
```bash
cp /usr/lib/syslinux/isolinux.bin image/isolinux/
cp /boot/memtest86+.bin image/install/memtest
```
*设置启动提示信息*
```bash
cat >> image/isolinux/boot.msg << "EOF"
************************************************************************

This is a Live CD.

For the default live system, enter "live". To run memtest86+, enter "memtest"

************************************************************************
EOF
```
*Boot-loader配置文件*
```bash
cat > image/isolinux/isolinux.cfg << "EOF"
default vesamenu.c32
prompt 0
timeout 100
display boot.msg
menu title Welcome to Ubuntu LiveCD!
menu color border 0 #ffffffff #00000000
menu color sel 7 #ffffffff #ff000000
menu color title 0 #ffffffff #00000000
menu color tabmsg 0 #ffffffff #00000000
menu color unsel 0 #ffffffff #00000000
menu color hotsel 0 #ff000000 #ffffffff
menu color hotkey 7 #ffffffff #ff000000
menu color scrollbar 0 #ffffffff #00000000

label lfs
  menu label ^Install LFS system
  menu default
  kernel /casper/vmlinuz
  append boot=casper install-lfs initrd=/casper/initrd.gz quiet --
label live
  menu label ^Start  LiveCD
  kernel /casper/vmlinuz
  append boot=casper initrd=/casper/initrd.gz quiet --
label local
  menu label ^Boot From First Hard Disk
  localboot 0x80
  append -
EOF
```
*可以从Ubuntu的ISO镜像获取vesamenu.c32文件，拷贝到镜像目录*
```bash
cp vesamenu.c32 image/isolinux/
```
### 4.创建清单文件
```bash
chroot chroot dpkg-query -W --showformat='${Package} ${Version}\n' | tee image/casper/filesystem.manifest
cp -v image/casper/filesystem.manifest image/casper/filesystem.manifest-desktop
REMOVE='ubiquity ubiquity-frontend-gtk ubiquity-frontend-kde casper lupin-casper live-initramfs user-setup discover1 xresprobe os-prober libdebian-installer4'
for i in $REMOVE
do
  sed -i "/${i}/d" image/casper/filesystem.manifest-desktop
done
```
### 5.压缩chroot文件系统
```bash
mksquashfs $WORK/chroot image/casper/filesystem.squashfs -e boot
printf $(du -sx --block-size=1 chroot | cut -f1) > image/casper/filesystem.size
```
### 6.定义描述文件
```
cat > image/README.diskdefines << "EOF"
#define DISKNAME  LiveCD
#define TYPE  binary
#define TYPEbinary  1
#define ARCH  amd64
#define ARCHamd64  1
#define DISKNUM  1
#define DISKNUM1  1
#define TOTALNUM  0
#define TOTALNUM0  1
EOF
```
### 7.定义额外信息
```bash
touch image/ubuntu

mkdir image/.disk
cd image/.disk
touch base_installable
echo "full_cd/single" > cd_type
echo "LiveCD" > info
cd ../..
```
### 8.封装LFS系统
*准备安装脚本*
获取[安装脚本](scripts/install.sh)
*拷贝安装脚本、LFS文件系统、内核文件到镜像目录*
```bash
cd $WORK
mkdir -pv image/packages/package

cp -a ~/install.sh image/packages/
cp -a ~/rootfs.tar.gz image/packages/package/
cp -a ~/boot.tar.gz image/packages/package/
```
*解压LiveCD initrd文件*
```bash
cp -a image/casper/initrd.gz ./
gunzip initrd.gz

mkdir build
cd build

cpio -div < ../initrd
rm -f ../initrd
```
*修改init执行流程中的一个脚本程序，添加上我们自己的初始化过程*
```bash
cat >> scripts/casper-bottom/ORDER << "EOF"
/scripts/casper-bottom/99custom_init
[ -e /conf/param.conf ] && . /conf/param.conf
EOF

cat > scripts/casper-bottom/99custom_init << "EOF"
#!/bin/sh

RCFILE=/root/cdrom/packages/rc.local

if grep -q install-lfs /proc/cmdline; then
    if [ -f $RCFILE ]; then
        cp -af $RCFILE /root/etc/
    fi
fi
EOF
chmod a+x scripts/casper-bottom/99custom_init
```
*重新压缩initrd.gz文件*
```bash
find .|cpio -o -H newc|gzip -9 > ../image/casper/initrd.gz
cd ..
```
*添加安装LFS初始化操作*
```bash
cat > image/packages/rc.local << "EOF"
cp -af /cdrom/packages/* /home/live/
cat /cdrom/packages/.profile >> /home/live/.profile
exit 0
EOF
chmod a+x image/packages/rc.local

cat > image/packages/.profile << "EOF"
if [ -f ~/install.sh ]; then
    sudo sh ~/install.sh
fi
EOF
```
*计算MD5*
```bash
pushd image
find . -type f -print0 | xargs -0 md5sum | grep -v "\./md5sum.txt" > md5sum.txt
popd
```
*生成ISO镜像*
pushd image
mkisofs -r -V "LFS-x86_64" -cache-inodes -J -l -b isolinux/isolinux.bin \
    -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table \
    -o ../LFS-x86_64.iso .
popd
```
### 9.在VirtualBox试安装一下做好的镜像
