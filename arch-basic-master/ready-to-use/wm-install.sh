#!/bin/bash

sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

### Essential Packages every standalone window manager needs
sudo pacman -S xorg xorg-xinit lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings nitrogen picom rofi dmenu alacritty pcmanfm numlockx lxappearance mlocate gvfs udisks2 xterm polkit lxsession exa bat fish neofetch pavucontrol howl nomacs gnome-disk-utility htop

### Window Manager - Choose one to install
#sudo pacman -S qtile
#sudo pacman -S xmonad xmonad-contrib
#sudo pacman -S awesome
#sudo pacman -S openbox obconf lxappearance-obconf lxinput lxrandr tint2

### Extra packages
sudo pacman -S firefox vlc discord libreoffice-fresh anki gimp hunspell-en_us hunspell-es_any hunspell-es_hn hunspell-es_mx hunspell-es_es

### Fonts
sudo pacman -S noto-fonts-emoji ttf-ubuntu-font-family ttf-dejavu ttf-liberation

### Themes and Icons
sudo pacman -S papirus-icon-theme
sudo pacman -S arc-gtk-theme
sudo pacman -S materia-gtk-theme

### Install starship prompt
#sh -c "$(curl -fsSL https://starship.rs/install.sh)"

cd ~
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si --noconfirm

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -

paru -S --noconfirm visual-studio-code-bin google-chrome ttf-ms-fonts zoom spotify dropbox notion-app timeshift freedownloadmanager

sudo systemctl enable lightdm

sudo updatedb
