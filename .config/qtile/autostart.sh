#!/bin/sh

# Cursor active at boot
xsetroot -cursor_name left_ptr &

# Polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Notification Daemon
exec dunst &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &

# Enable power management
xfce4-power-manager &

nitrogen --restore &
picom --config $HOME/.config/qtile/picom.conf &
volumeicon &

## Set keyboard layout
setxkbmap us -variant altgr-intl &

## Turn ON numlock key
numlockx on &