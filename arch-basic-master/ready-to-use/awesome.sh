#!/bin/bash

sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

sudo pacman -S xorg xorg-xinit awesome lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings vlc discord nitrogen picom rofi dmenu alacritty pcmanfm libreoffice-fresh numlockx anki gimp notepadqq lxappearance mlocate gvfs udisks2 xterm polkit lxsession noto-fonts-emoji hunspell-en_us hunspell-es_any hunspell-es_hn hunspell-es_mx hunspell-es_es firefox papirus-icon-theme exa bat fish nomacs flameshot

chsh -s /bin/fish

sudo systemctl enable lightdm

git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -

paru -S --noconfirm visual-studio-code-bin google-chrome ttf-ms-fonts zoom spotify dropbox notion-app timeshift freedownloadmanager

sudo updatedb
