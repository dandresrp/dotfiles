#!/bin/bash

### Install these packages
sudo pacman -S virt-manager qemu qemu-arch-extra ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat

### Enable services
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

### Copy br10.xml to Documents folder
sudo virsh net-define ~/Documents/br10.xml
firewall-cmd --permanent --direct --passthrough ipv4 -I FORWARD -i bridge0 -j ACCEPT
firewall-cmd --permanent --direct --passthrough ipv4 -I FORWARD -o bridge0 -j ACCEPT
firewall-cmd --reload
sudo virsh net-start br10
sudo virsh net-autostart br10
