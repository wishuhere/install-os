#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

echo "MAIN PACKAGES"

sleep 5

sudo pacman -Suy xorg light-locker lightdm bspwm sxhkd firefox picom dmenu arandr pavucontrol noto-fonts noto-fonts-emoji ttf-font-awesome dmenu pacman-contrib zsh yad xorg-xinit xss-lock xf86-video-intel veracrypt unzip usbutils unrar telegram-desktop remmina redshift proxychains-ng rofi pcmanfm-qt p7zip noto-fonts-extra noto-fonts-cjk neofetch lightdm-gtk-greeter kitty freerdp flameshot bluez-utils autoconf automake xdg-user-dirs

sudo systemctl enable lightdm

mkdir -p .config/{bspwm,sxhkd}

install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc

printf "\e[1;32mCHANGE NECESSARY FILES BEFORE REBOOT\e[0m"

