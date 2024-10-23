#!/bin/bash

+() {
echo "$@"
}

S() {
sleep 5;
clear; "$@"
}

X() {
"$@" > /dev/null 2>&1;
}

clear;





if + "INICIANDO FORMATACAO EM 10 SEGUNDOS,
ESTEJA CIENTE DO QUE ESTA FAZENDO,
POIS TODOS OS DADOS SERAO APAGADOS
PARA QUE A INSTALACAO SEJA BEM SUCEDIDA..."; then
sleep 10; clear
fi;





+ "ADICIONANDO ESPELHO BRASILEIRO"
if + "Server=https://mirror.ufscar.br/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist; then
+ "ESPELHO BRASILEIRO ADICIONADO COM SUCESSO"
else
+ "ERRO AO ADICIONAR O ESPELHO BRASILEIRO"
fi;

S

+ "SOBSCREVENDO ARQUIVO pacman.conf"
if + "[options]
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
Include=/etc/pacman.d/mirrorlist" > /etc/pacman.conf; then
+ "ARQUIVO pacman.conf SOBSCRITO COM SUCESSO"
else
+ "ERRO AO SOBSCREVER ARQUIVO pacman.conf"
fi;

S

+ "SINCRONIZANDO REPOSITORIOS DO PACMAN"
if X pacman -Sy --noconfirm --quiet; then
+ "REPOSITORIOS DO PACMAN SINCRONIZADOS COM SUCESSO"
else
+ "ERRO AO SINCRONIZAR REPOSITORIOS DO PACMAN"
fi;

S

if X fdisk /dev/nvme0n1; then <<EOF > /dev/null 2>&1
o
w
EOF

fdisk /dev/nvme0n1 <<EOF > /dev/null 2>&1
n
p
1

+2G
t
4
w
EOF

fdisk /dev/nvme0n1 <<EOF > /dev/null 2>&1
n
p
2

+30G
w
EOF

fdisk /dev/nvme0n1 <<EOF > /dev/null 2>&1
n
p
3


w
EOF

X partprobe
X mkfs.fat -F32 /dev/nvme0n1p1
X mkfs.ext4 -F /dev/nvme0n1p2
X mkfs.ext4 -F /dev/nvme0n1p3
X mount /dev/nvme0n1p2 /mnt
X mkdir /mnt/boot
X mkdir /mnt/boot/EFI
X mkdir /mnt/home
X mount /dev/nvme0n1p1 /mnt/boot/EFI
X mount /dev/nvme0n1p3 /mnt/home

else

fdisk /dev/sda <<EOF > /dev/null 2>&1
o
w
EOF

fdisk /dev/sda <<EOF > /dev/null 2>&1
n
p
1

+2G
t
4
w
EOF

fdisk /dev/sda <<EOF > /dev/null 2>&1
n
p
2

+30G
w
EOF

fdisk /dev/sda <<EOF > /dev/null 2>&1
n
p
3


w
EOF

X partprobe
X mkfs.fat -F32 /dev/sda1
X mkfs.ext4 -F /dev/sda2
X mkfs.ext4 -F /dev/sda3
X mount /dev/sda2 /mnt
X mkdir /mnt/boot
X mkdir /mnt/boot/EFI
X mkdir /mnt/home
X mount /dev/sda1 /mnt/boot/EFI
X mount /dev/sda3 /mnt/home
fi;

S

X pacstrap /mnt --noconfirm --quiet \
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
efibootmgr

S

genfstab -U -p /mnt > /mnt/etc/fstab;

S

arch-chroot /mnt bash -c '

+() {
echo "$@"
}

S() {
sleep 5;
clear; "$@"
}

X() {
"$@" > /dev/null 2>&1;
}

clear;


S

+ 4RCH > /etc/hostname;

S

+ -e "4RCH\n4RCH" | passwd root;

S

useradd -m -g users -G wheel 4RCH;

S

+ -e "4RCH\n4RCH" | passwd 4RCH;

S

+ "pt_BR.UTF-8 UTF-8" > /etc/locale.gen;

S

+ "LANG=pt_BR.UTF-8" > /etc/locale.conf;

S

X locale-gen;

S

X hwclock --systohc;

S

+ "Server=https://mirror.ufscar.br/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist;

S

+ "alias i=\"yay -S --noconfirm --quiet\"
alias d=\"sudo pacman -Rsc\"
sudo rm -rf /home/4RCH/.bash_history /home/4RCH/.cache /var/log /tmp;
sudo pacman -Syyu --noconfirm --quiet;
sudo pacman -Scc --noconfirm --quiet;
clear;
fastfetch
git clone https://aur.archlinux.org/yay.git && \\
sudo chmod 777 yay && \\
cd yay && \\
makepkg -si --noconfirm && \\
cd .. && \\
sudo rm -rf yay && \\
yay -S --noconfirm nano --save --answerdiff None --answerclean None --removemake && \\
yay -S --noconfirm --quiet pi-hole-server && \\
sudo systemctl enable pihole-FTL && \\
sudo systemctl start pihole-FTL && \\
pihole -g && \\
echo \"4RCH\" | su -c \"echo \\\"https://blocklistproject.github.io/Lists/abuse.txt
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
https://blocklistproject.github.io/Lists/alt-version/tracking-nl.txt\\\" >> /etc/pihole/adlists.list\" && \\
pihole -g -r recreate && \\
yay -S --noconfirm --quiet openssh && \\
sudo systemctl enable sshd && \\
sudo systemctl start sshd && \\
sudo sed -i \"8,\\\$d\" /home/4RCH/.bashrc" > /home/4RCH/.bashrc;

S

+ "[options]
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

S

X pacman -Sy --noconfirm --quiet;

S

if lspci | grep -i amd; then
pacman -Sy --noconfirm amd-ucode
fi;

S

if lspci | grep -i intel; then
pacman -Sy --noconfirm intel-ucode
fi;

S

if lspci | grep -i nvidia; then
pacman -Sy --noconfirm nvidia nvidia-dkms
fi;

S

if lspci | grep -i virtualbox; then
pacman -Sy --noconfirm \
virtualbox-guest-utils \
virtualbox-guest-modules-arch
fi;

S

X systemctl enable NetworkManager;

S

X systemctl disable \
NetworkManager-wait-online \
systemd-networkd \
systemd-timesyncd;

S

X mkinitcpio -P;

S

+ "GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=\"4RCH\"
GRUB_CMDLINE_LINUX_DEFAULT=\"quiet mitigations=off\"
GRUB_CMDLINE_LINUX=\"\"
GRUB_PRELOAD_MODULES=\"part_gpt part_msdos\"
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true" > /etc/default/grub;

S

X grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=4RCH --recheck;

S

X grub-mkconfig -o /boot/grub/grub.cfg;

S

+ "4RCH ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers;

S

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

S

sed -i "/^UUID=.* \/boot .*$/! s/rw/rw,noatime,discard,/" /etc/fstab;

S

+ "127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
127.0.0.1 4RCH.localdomain 4RCH" > /etc/hosts;

S

rm -rf /boot/initramfs-linux-fallback.img';

S

X sync;

S

reboot -f;
