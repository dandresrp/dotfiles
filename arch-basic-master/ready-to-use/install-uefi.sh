#!/bin/bash

pacman -S grub efibootmgr dosfstools mtools os-prober

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S base-devel pacman-contrib git reflector nano dialog rsync linux-headers networkmanager xdg-user-dirs amd-ucode nvidia nvidia-settings ntfs-3g alsa-utils alsa-plugins pipewire pipewire-alsa pipewire-pulse pipewire-jack xdg-utils bash-completion openssh firewalld terminus-font

systemctl enable NetworkManager
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
