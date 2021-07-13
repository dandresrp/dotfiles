#!/bin/bash

sudo pacman -S --noconfirm reflector
sudo reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Syy

sudo pacman -S --noconfirm xorg xorg-xinit lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings vlc discord nitrogen picom rofi dmenu alacritty pcmanfm git libreoffice-fresh numlockx anki flameshot gimp gwenview notepadqq nomacs nvidia-settings lxappearance mlocate gvfs udisks2 arc-gtk-theme xterm polkit lxsession vifm

sudo systemctl enable lightdm

git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -

paru -S --noconfirm visual-studio-code-bin google-chrome ttf-ms-fonts foxitreader zoom spotify dropbox mailspring notion-app notes

sudo updatedb
