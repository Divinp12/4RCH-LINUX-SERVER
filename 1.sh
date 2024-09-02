#!/bin/bash





echo "Server=https://mirror.ufscar.br/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist;





sleep 5;





echo "[options]
Architecture=auto
CheckSpace
ParallelDownloads=1
SigLevel=Required DatabaseOptional
LocalFileSigLevel=Optional
[core]
Include=/etc/pacman.d/mirrorlist
[extra]
Include=/etc/pacman.d/mirrorlist
[multilib]
Include=/etc/pacman.d/mirrorlist
[community]
Include=/etc/pacman.d/mirrorlist" > /etc/pacman.conf;





sleep 5;





pacman -Syyu --noconfirm --quiet;





sleep 5;





if fdisk /dev/nvme0n1; then <<EOF
o
w
EOF
fdisk /dev/nvme0n1 <<EOF
n
p
1

+2G
t
4
w
EOF
fdisk /dev/nvme0n1 <<EOF
n
p
2

+30G
w
EOF
fdisk /dev/nvme0n1 <<EOF
n
p
3


w
EOF
partprobe;
mkfs.fat -F32 /dev/nvme0n1p1;
mkfs.ext4 -F /dev/nvme0n1p2;
mkfs.ext4 -F /dev/nvme0n1p3;
mount /dev/nvme0n1p2 /mnt;
mkdir /mnt/boot;
mkdir /mnt/boot/EFI;
mkdir /mnt/home;
mount /dev/nvme0n1p1 /mnt/boot/EFI;
mount /dev/nvme0n1p3 /mnt/home;
else
fdisk /dev/sda <<EOF
o
w
EOF
fdisk /dev/sda <<EOF
n
p
1

+2G
t
4
w
EOF
fdisk /dev/sda <<EOF
n
p
2

+30G
w
EOF
fdisk /dev/sda <<EOF
n
p
3


w
EOF
partprobe;
mkfs.fat -F32 /dev/sda1;
mkfs.ext4 -F /dev/sda2;
mkfs.ext4 -F /dev/sda3;
mount /dev/sda2 /mnt;
mkdir /mnt/boot;
mkdir /mnt/boot/EFI;
mkdir /mnt/home;
mount /dev/sda1 /mnt/boot/EFI;
mount /dev/sda3 /mnt/home;
fi;





sleep 5;





pacstrap /mnt --noconfirm \
base \
base-devel \
linux \
linux-firmware \
linux-headers \
networkmanager \
sudo \
git \
fastfetch \
grub-efi-x86_64 \
efibootmgr;





sleep 5;





genfstab -U -p /mnt > /mnt/etc/fstab;





sleep 5;





mv 4RC*/2.sh /mnt;





sleep 5;





chmod 777 /mnt/2.sh;





sleep 5;





arch-chroot /mnt ./2.sh;





sleep 5;





sync;





sleep 5;





reboot -f;
