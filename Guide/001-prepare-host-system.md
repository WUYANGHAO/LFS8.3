# 准备宿主系统
-----------------------------------------------------------
*[[上一页](/README.md)] [[下一页](002-prepare-tmp-system.md)]*
-----------------------------------------------------------
### 1、下载Ubuntu系统
下载[Ubuntu系统](https://www.ubuntu.com/download/desktop)
### 2、下载VirtualBox软件
下载[VirtualBox](https://www.virtualbox.org/)
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
### 9、下载并校验软件包
*获取[lfs8.3源代码包](http://mirror.jaleco.com/lfs/pub/lfs/lfs-packages/lfs-packages-8.3.tar)*
```bash
tar xvf lfs-packages-8.3.tar -C $LFS/sources
mv $LFS/sources/8.3/* $LFS/sources/

pushd $LFS/sources
md5sum -c md5sums
popd
```
### 10、创建编译工具链目录
```bash
mkdir -v $LFS/tools
ln -sv $LFS/tools /
```
### 11、添加编译用户配置（root权限太高，可能会损坏宿主机）
```bash
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
```
*修改lfs用户密码*
```bash
passwd lfs
```
```bash
chown -v lfs $LFS/tools
chown -v lfs $LFS/sources
```
*切换到lfs用户，配置用户环境变量*
```bash
su - lfs

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF

source ~/.bash_profile
```
-----------------------------------------------------------
*[[上一页](/README.md)] [[下一页](002-prepare-tmp-system.md)]*
