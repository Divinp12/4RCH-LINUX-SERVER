#!/bin/bash





echo 4RCH > /etc/hostname;





sleep 5;





yes 4RCH | passwd root;





sleep 5;






useradd -m -g users -G wheel 4RCH;





sleep 5;





yes 4RCH | passwd 4RCH;




sleep 5;





echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen;





sleep 5;





echo "LANG=pt_BR.UTF-8" > /etc/locale.conf;





sleep 5;





locale-gen;





sleep 5;





hwclock --systohc;





sleep 5;





echo "Server=https://mirror.ufscar.br/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist;





sleep 5;





echo "alias i='yay -S --noconfirm --quiet'
alias d='sudo pacman -Rsc'
sudo rm -rf /home/4RCH/.bash_history /home/4RCH/.cache /var/log /tmp/\*.\*;
sudo pacman -Syyu --noconfirm --quiet;
sudo pacman -Scc --noconfirm --quiet;
clear;
fastfetch
git clone https://aur.archlinux.org/yay.git;
sudo chmod 777 yay;
cd yay;
makepkg -si --noconfirm;
cd ..;
sudo rm -rf yay;
yay -S --noconfirm nano --save --answerdiff None --answerclean None --removemake;
yay -S --noconfirm pi-hole-server;
yay -S --noconfirm openssh;
sudo systemctl enable sshd;
sudo systemctl start sshd;
sudo systemctl enable pihole-FTL;
sudo systemctl start pihole-FTL;
sudo mv /home/4RCH/adlists.list /etc/pihole;
pihole -g -r recreate;
sed -i '\$d' /home/4RCH/.bashrc;
sed -i '/git clone https:\/\/aur.archlinux.org\/yay.git/,$d' /home/4RCH/.bashrc" > /home/4RCH/.bashrc;





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
if lspci | grep -i amd; then
pacman -Sy --noconfirm amd-ucode
fi;





sleep 5;





if lspci | grep -i intel; then
pacman -Sy --noconfirm intel-ucode
fi;





sleep 5;





if lspci | grep -i nvidia; then
pacman -Sy --noconfirm nvidia nvidia-dkms
fi;





sleep 5;





if lspci | grep -i virtualbox; then
pacman -Sy --noconfirm \
virtualbox-guest-utils \
virtualbox-guest-modules-arch;
systemctl enable vboxservice;
fi;





sleep 5;





systemctl enable NetworkManager





sleep 5;





systemctl disable \
NetworkManager-wait-online \
systemd-networkd \
systemd-timesyncd;





sleep 5;





mkinitcpio -P;





sleep 5;





echo "GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=\"4RCH\"
GRUB_CMDLINE_LINUX_DEFAULT=\"quiet mitigations=off\"
GRUB_CMDLINE_LINUX=\"\"
GRUB_PRELOAD_MODULES=\"part_gpt part_msdos\"
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true" > /etc/default/grub;





sleep 5;





grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=4RCH --recheck;





sleep 5;





grub-mkconfig -o /boot/grub/grub.cfg;





sleep 5;





echo "4RCH ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers;





sleep 5;





sed -i "/^\s*#/d; /^\s*$/d" \
/home/4RCH/.bash_profile \
/home/4RCH/.bash_logout \
/etc/sudoers \
/etc/sudo.conf \
/etc/host.conf \
/etc/healthd.conf \
/etc/mkinitcpio.conf \
/etc/libva.conf \
/etc/vconsole.conf \
/etc/fuse.conf \
/etc/ts.conf \
/etc/fstab;





sleep 5;





echo "https://blocklistproject.github.io/Lists/abuse.txt
https://blocklistproject.github.io/Lists/alt-version/abuse-nl.txt
https://blocklistproject.github.io/Lists/ads.txt
https://blocklistproject.github.io/Lists/alt-version/ads-nl.txt
https://blocklistproject.github.io/Lists/crypto.txt
https://blocklistproject.github.io/Lists/alt-version/crypto-nl.txt
https://blocklistproject.github.io/Lists/drugs.txt
https://blocklistproject.github.io/Lists/alt-version/drugs-nl.txt
https://blocklistproject.github.io/Lists/everything.txt
https://blocklistproject.github.io/Lists/alt-version/everything-nl.txt
https://blocklistproject.github.io/Lists/facebook.txt
https://blocklistproject.github.io/Lists/alt-version/facebook-nl.txt
https://blocklistproject.github.io/Lists/fraud.txt
https://blocklistproject.github.io/Lists/alt-version/fraud-nl.txt
https://blocklistproject.github.io/Lists/gambling.txt
https://blocklistproject.github.io/Lists/alt-version/gambling-nl.txt
https://blocklistproject.github.io/Lists/malware.txt
https://blocklistproject.github.io/Lists/alt-version/malware-nl.txt
https://blocklistproject.github.io/Lists/phishing.txt
https://blocklistproject.github.io/Lists/alt-version/phishing-nl.txt
https://blocklistproject.github.io/Lists/piracy.txt
https://blocklistproject.github.io/Lists/alt-version/piracy-nl.txt
https://blocklistproject.github.io/Lists/porn.txt
https://blocklistproject.github.io/Lists/alt-version/porn-nl.txt
https://blocklistproject.github.io/Lists/ransomware.txt
https://blocklistproject.github.io/Lists/alt-version/ransomware-nl.txt
https://blocklistproject.github.io/Lists/redirect.txt
https://blocklistproject.github.io/Lists/alt-version/redirect-nl.txt
https://blocklistproject.github.io/Lists/scam.txt
https://blocklistproject.github.io/Lists/alt-version/scam-nl.txt
https://blocklistproject.github.io/Lists/tiktok.txt
https://blocklistproject.github.io/Lists/alt-version/tiktok-nl.txt
https://blocklistproject.github.io/Lists/torrent.txt
https://blocklistproject.github.io/Lists/alt-version/torrent-nl.txt
https://blocklistproject.github.io/Lists/tracking.txt
https://blocklistproject.github.io/Lists/alt-version/tracking-nl.txt" > /home/4RCH/adlists.list;





sleep 5;





sed -i "/^UUID=.* \/boot .*$/! s/rw/rw,noatime,discard,/" /etc/fstab;





sleep 5;





echo "127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
127.0.0.1 4RCH.localdomain 4RCH" > /etc/hosts;





sleep 5;





rm -rf /boot/initramfs-linux-fallback.img 2.sh;
