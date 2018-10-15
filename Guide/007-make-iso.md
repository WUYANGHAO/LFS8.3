# 制作可安装镜像

### 1.打包LFS系统文件
*在Ubuntu试用系统中*
```bash
tar zcvf ~/rootfs.tar.gz $LFS/* --exclude boot
tar zcvf ~/boot.tar.gz $LFS/boot/*
```
### 2.创建chroot系统
*创建工作目录*
```bash
export WORK=/opt/work
```
*安装debootstrap程序*
```bash
apt-get install debootstrap
```
