# 创建LFS系统
------------------------------------------------
#### *[[上一页](002-prepare-tmp-system.md)] [[下一页](004-configure-lfs-system.md)]*
------------------------------------------------
### Preparing Virtual Kernel File Systems
```bash
mkdir -pv $LFS/{dev,proc,sys,run}
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3
mount -v --bind /dev $LFS/dev
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
```
### 进入chroot环境
```bash
chroot "$LFS" /tools/bin/env -i \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h
```
### 创建目录
```bash
mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp
mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -v  /usr/libexec
mkdir -pv /usr/{,local/}share/man/man{1..8}

case $(uname -m) in
 x86_64) mkdir -v /lib64 ;;
esac

mkdir -v /var/{log,mail,spool}
ln -sv /run /var/run
ln -sv /run/lock /var/lock
mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local}
```
### Creating Essential Files and Symlinks
```bash
ln -sv /tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty} /bin
ln -sv /tools/bin/{env,install,perl} /usr/bin
ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
ln -sv /tools/lib/libstdc++.{a,so{,.6}} /usr/lib
for lib in blkid lzma mount uuid
do
    ln -sv /tools/lib/lib$lib.so* /usr/lib
done
ln -svf /tools/include/blkid    /usr/include
ln -svf /tools/include/libmount /usr/include
ln -svf /tools/include/uuid     /usr/include
install -vdm755 /usr/lib/pkgconfig
for pc in blkid mount uuid
do
    sed 's@tools@usr@g' /tools/lib/pkgconfig/${pc}.pc \
        > /usr/lib/pkgconfig/${pc}.pc
done
ln -sv bash /bin/sh

ln -sv /proc/self/mounts /etc/mtab
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
systemd-journal:x:23:
input:x:24:
mail:x:34:
nogroup:x:99:
users:x:999:
EOF
exec /tools/bin/bash --login +h
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp
```
### 编译安装软件
#### 1.[Linux-4.18.5 API Headers](lfs-system/001-linux-header.md)—— <0.1 SBU
#### 2.[Man-pages-4.16](lfs-system/002-man.md)—— <0.1 SBU
#### 3.[Glibc-2.28](lfs-system/003-glibc.md)—— 24 SBU
#### 4.[调整工具链](lfs-system/004-adjust-tool.md)
#### 5.[Zlib-1.2.11](lfs-system/005-zlib.md)—— <0.1 SBU
#### 6.[File-5.34](lfs-system/006-file.md)—— 0.1 SBU
#### 7.[Readline-7.0](lfs-system/007-readline.md)—— 0.1 SBU
#### 8.[M4-1.4.18](lfs-system/008-m4.md)—— 0.4 SBU
#### 9.[Bc-1.07.1](lfs-system/009-bc.md)—— 0.1 SBU
#### 10.[Binutils-2.31.1](lfs-system/010-binutils.md)—— 6.6 SBU
#### 11.[GMP-6.1.2](lfs-system/011-gmp.md)—— 1.3 SBU
#### 12.[MPFR-4.0.1](lfs-system/012-mpfr.md)—— 1.1 SBU
#### 13.[MPC-1.1.0](lfs-system/013-mpc.md)—— 0.3 SBU
#### 14.[Shadow-4.6](lfs-system/014-shadow.md)—— 0.2 SBU
#### 15.[GCC-8.2.0](lfs-system/015-gcc.md)—— 92 SBU
#### 16.[Bzip2-1.0.6](lfs-system/016-bzip2.md)—— <0.1 SBU
#### 17.[Pkg-config-0.29.2](lfs-system/017-pkgconfig.md)—— 0.4 SBU
#### 18.[Ncurses-6.1](lfs-system/018-ncurses.md)—— 0.4 SBU
#### 19.[](lfs-system/)
#### 20.[](lfs-system/)
#### 21.[](lfs-system/)




------------------------------------------------
#### *[[上一页](002-prepare-tmp-system.md)] [[下一页](004-configure-lfs-system.md)]*
------------------------------------------------
