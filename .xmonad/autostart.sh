#!/bin/sh

# Cursor active at boot
xsetroot -cursor_name left_ptr &

# Polkit agent
#lxsession &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Notification Daemon
dunst &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &

# Enable power management
#xfce4-power-manager &

# Restore wallpaper and start compositor
nitrogen --restore &
picom --config $HOME/.xmonad/picom.conf &

# Set keyboard layout
setxkbmap us -variant altgr-intl &

# Turn ON numlock key
numlockx on &

sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 " ++ colorTrayer ++ " --height 22 &
volumeicon &
#dropbox &
#discord --start-minimized &
