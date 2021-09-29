#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#cursor active at boot
xsetroot -cursor_name left_ptr &

#starting utility applications at boot time
run xfce4-power-manager &
numlockx on &
picom --config $HOME/.xmonad/picom.conf &
/usr/bin/lxpolkit &
lxsession &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
#/usr/bin/dunst &

#starting user applications at boot time
~/.fehbg &
#nitrogen --restore &
udiskie &
setxkbmap us -variant altgr-intl &
#run thunar --daemon &
run pcmanfm -d &
run dropbox &
