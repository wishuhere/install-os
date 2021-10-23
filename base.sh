#!/bin/bash
ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "hermit" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 hermit.localdomain hermit" >> /etc/hosts
timedatectl set-ntp true
echo root:password | chpasswd

#base package
pacman -Suy lxappearance networkmanager bluez sudo alsa-utils bluez-utils blueman git hping gcc iptables-nft net-tools network-manager-applet openssh pulseaudio pulseaudio-alsa pulseaudio-bluetooth ttf-jetbrains-mono unrar unzip wget inetutils

bootctl --esp-path=/efi --boot-path=/boot install
bootctl --esp-path=/efi --boot-path=/boot update

echo "default	archlinux.conf" >> /efi/loader/loader.conf
echo "timeout 4" >> /efi/loader/loader.conf
echo "editor yes" >> /efi/loader/loader.conf
echo "console-mode max" >> /efi/loader/loader.conf

echo "title		Arch Linux">>/boot/loader/entries/archlinux.conf
echo "linux		/vmlinuz-linux">>/boot/loader/entries/archlinux.conf
echo "initrd		/intel-ucode.img">>/boot/loader/entries/archlinux.conf
echo "initrd		/initramfs-linux.img">>/boot/loader/entries/archlinux.conf
echo "options		root="LABEL=ROOT" rw pcie_asmp=off nowatchdog pci=nomsi pci=noaer">>/boot/loader/entries/archlinux.conf

echo "title             Arch Linux LTS">>/boot/loader/entries/archlinux-lts.conf
echo "linux             /vmlinuz-linux-lts">>/boot/loader/entries/archlinux-lts.conf
echo "initrd            /intel-ucode.img">>/boot/loader/entries/archlinux-lts.conf
echo "initrd            /initramfs-linux-lts.img">>/boot/loader/entries/archlinux-lts.conf
echo "options           root="LABEL=ROOT" rw pcie_asmp=off nowatchdog pci=nomsi pci=noaer">>/boot/loader/entries/archlinux-lts.conf

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable systemd-homed.service

useradd -m hermit
echo hermit:password | chpasswd
usermod -aG hermit

echo "hermit ALL=(ALL) ALL" >> /etc/sudoers.d/hermit


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

