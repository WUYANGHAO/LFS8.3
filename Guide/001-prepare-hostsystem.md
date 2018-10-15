# 准备宿主系统
### 1、下载Ubuntu系统
<a href="https://www.ubuntu.com/download/desktop">Ubuntu官网</a>
### 2、下载VirtualBox软件
<a href="https://www.virtualbox.org/">VirtualBox官网</a>
### 3、挂载ubuntu系统ISO镜像，打开“试用模式”
### 4、更新软件源
```bash
apt-get update
apt-get upgrade
```
### 5、检查并安装必备软件
*检查(获取[version-check.sh](../Scripts/version-check.sh))*
```bash
bash version-check.sh
```
*安装（以ubuntu18.04.1为例）*
```bash
apt-get install bison gawk g++ make texinfo
```
*调整dash为bash(选择NO)*
```bash
dpkg-reconfigure dash
```
### 6、创建分区系统（sda为例）
```bash
fdisk /dev/sda
n
p
1

+100M
a
1
n
p
2

+2G
t
82
n
p
3


w
```
### 7、格式化分区
```bash
mkfs.ext2 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
swapon -v /dev/sda2
```
### 8、创建lfs系统目录并挂载分区
```bash
export LFS=/mnt/lfs
mkdir -pv $LFS
mount /dev/sda3 $LFS
mkdir -pv $LFS/boot
mount /dev/sda1 $LFS/boot
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
```
### 9、下载校验软件包

