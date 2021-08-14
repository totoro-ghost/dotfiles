#!/bin/bash

if pgrep -x "gnome-calendar" >/dev/null; then
    pkill gnome-calendar
else 
    gnome-calendar
fi
