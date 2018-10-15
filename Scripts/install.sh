#!/bin/bash
clear
echo "
**********************************************
*               install start                *
**********************************************
"
PACKAGE=/home/live/package
# find the disk
DISK=$(fdisk -l 2>/dev/null | grep "^Disk /dev/[shv]d[a-z]" | cut -c6-13 | head -1)
if [ "$DISK" = "" ]; then
  echo "Disk not founded"
  exit 0
else
  echo "Disk is $DISK"
fi

SWAP=$(cat /proc/swaps | grep "$DISK" | awk '{print $1}')
for s in $SWAP; do
  swapoff $s
done

# format disk
echo "Format disk $DISK"
dd if=/dev/zero of=$DISK bs=512 count=1 > /dev/null 2>&1

# partition
echo \
"d
1
d
2
d
3
d
4
w
" | fdisk $DISK > /dev/null 2>&1

echo \
"n
p
1

+100M
n
p
2

+2G
n
p
3


w
" | fdisk $DISK > /dev/null 2>&1
sync

BOOT_NUM=1
SWAP_NUM=2
ROOT_NUM=3
DISK_SWAP=${DISK}${SWAP_NUM}
DISK_BOOT=${DISK}${BOOT_NUM}
DISK_ROOT=${DISK}${ROOT_NUM}

# init swap partition
mkswap $DISK_SWAP
# swapon $DISK_SWAP

# init root partition
mkfs -t ext4 $DISK_ROOT > /dev/null 2>&1
mkdir -p /mnt/lfs
mount $DISK_ROOT /mnt/lfs
cd /mnt/lfs
tar zxf $PACKAGE/rootfs.tar.gz
echo "Install Root finished"

# init boot partition
mkfs -t ext2 $DISK_BOOT > /dev/null 2>&1
mkdir -p /mnt/lfs/boot
mount $DISK_BOOT /mnt/lfs/boot
cd /mnt/lfs/boot
rm -rf lost+found
tar zxf $PACKAGE/boot.tar.gz
echo "Install Boot finished"

grub-install --root-directory=/mnt/lfs ${DISK}

# init fstab
echo \
"${DISK_ROOT} / ext4 defaults 1 1
${DISK_BOOT} /boot ext2 defaults 1 1
${DISK_SWAP} swap swap pri=1 0 0
proc /proc proc nosuid,noexec,nodev 0 0
sysfs /sys sysfs nosuid,noexec,nodev 0 0
devpts /dev/pts devpts gid=5,mode=620 0 0
tmpfs /run tmpfs defaults 0 0
devtmpfs /dev devtmpfs mode=0755,nosuid 0 0
" > /mnt/lfs/etc/fstab

# init grub.cfg
echo \
"set default=0
set timeout=5
set root=(hd0,${BOOT_NUM})
menuentry \"GNU/Linux, Linux 4.18.5-lfs-8.3 \" {
  linux /Linux 4.18.5-lfs-8.3 root=${DISK_ROOT} ro
}
" > /mnt/lfs/boot/grub/grub.cfg
# reset MAC address
rm -f /mnt/lfs/etc/udev/rules.d/70-*

cd /
umount /mnt/lfs/boot
umount /mnt/lfs

echo "
**********************************************
*               install finish               *
**********************************************

The System Will Reboot...
"

sleep 2
echo 1 > /proc/sys/kernel/sysrq
echo b > /proc/sysrq-trigger
