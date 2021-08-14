#!/bin/sh

t=$(xrandr -q | grep -c " connected ")
if [ "$t" = "2" ]; then
	echo "Setting multiple monitor setup."
	xrandr --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate normal --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal
fi