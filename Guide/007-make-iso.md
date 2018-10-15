# 制作可安装镜像

### 1.打包LFS系统文件
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
*安装debootstrap程序*
```bash
apt-get install debootstrap
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
