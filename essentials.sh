#!/bin/bash

sudo pacman -S --noconfirm  --needed reflector
sudo reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Syy

sudo pacman -S --noconfirm --needed xorg xorg-xinit lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings vlc discord nitrogen picom rofi dmenu alacritty pcmanfm git libreoffice-fresh numlockx anki flameshot gimp gwenview notepadqq nomacs nvidia-settings lxappearance mlocate gvfs udisks2 arc-gtk-theme xterm polkit lxsession vifm thunderbird noto-fonts-emoji materia-gtk-theme

sudo systemctl enable lightdm

git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -

paru -S --noconfirm visual-studio-code-bin google-chrome ttf-ms-fonts ttf-google-fonts-git ttf-mac-fonts ttf-vista-fonts font-manager nerd-fonts-complete powerline-fonts-git acroread-fonts foxitreader zoom spotify dropbox notion-app tela-icon-theme

sudo updatedb
