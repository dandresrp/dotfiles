#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

#cursor active at boot
xsetroot -cursor_name left_ptr &

#starting utility applications at boot time
run xfce4-power-manager &
numlockx on &
picom --config $HOME/.config/awesome/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#starting user applications at boot time
~/.fehbg &
udiskie &
setxkbmap us -variant altgr-intl &
run pcmanfm -d &
run dropbox &
