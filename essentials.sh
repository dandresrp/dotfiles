#!/bin/bash

sudo pacman -S --noconfirm  --needed reflector
sudo reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Syy

sudo pacman -S --noconfirm --needed xorg xorg-xinit lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings vlc discord nitrogen picom rofi dmenu alacritty pcmanfm git libreoffice-fresh numlockx anki flameshot gimp gwenview notepadqq nomacs nvidia-settings lxappearance mlocate gvfs udisks2 xterm polkit lxsession vifm thunderbird noto-fonts-emoji materia-gtk-theme openssh hunspell-en_us hunspell-es_any hunspell-es_hn hunspell-es_mx hunspell-es_es languagetool

sudo systemctl enable lightdm
sudo systemctl enable sshd

git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -

paru -S --noconfirm visual-studio-code-bin google-chrome ttf-ms-fonts ttf-mac-fonts nerd-fonts-complete powerline-fonts-git acroread-fonts zoom spotify dropbox notion-app tela-icon-theme

sudo updatedb
