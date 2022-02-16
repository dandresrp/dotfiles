#!/usr/bin/env bash

function run {
	if ! pgrep -f $1 ;
	then
	  $@&
	fi
}

xfsettingsd &
picom --config $HOME/.config/awesome/picom.conf &
nitrogen --restore &
volumeicon &
dropbox &