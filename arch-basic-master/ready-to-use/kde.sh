#!/bin/bash

sudo reflector --country 'United States' --age 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

sudo pacman -S --noconfirm xorg sddm plasma kde-applications firefox vlc discord papirus-icon-theme libreoffice-fresh anki gimp mlocate noto-fonts-emoji hunspell-en_us hunspell-es_any hunspell-es_hn hunspell-es_mx hunspell-es_es exa bat fish packagekit-qt5

git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -

paru -S --noconfirm google-chrome visual-studio-code-bin ttf-ms-fonts zoom spotify dropbox notion-app

sudo systemctl enable sddm

sudo updatedb
