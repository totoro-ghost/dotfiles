#!/bin/bash

# varibales to display

CURDIR="$HOME/.config/rofi/menu"

USERNAME=$(whoami)

VOLUME=$(pactl list sinks |
    grep '^[[:space:]]Volume:' |
    head -n $(($SINK + 1)) |
    tail -n 1 |
    sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

TIME=$(date '+%I:%M %p')

BATTERY=$(acpi |
    awk '{print $4}'|
    sed 's\,\\')

BRIGHTNESS=$("$HOME"/Scripts/brightness.sh -get)

WEEK=$(date '+%A')

MIC=$($CURDIR/mic.sh --status)

# printing actual output

echo -e "  Fortune"
echo ""
echo ""
echo ""
echo -e "  $USERNAME       "
echo -e "  $TIME"
echo -e "  $WEEK"
echo -e "  $BATTERY"
echo -e "  $VOLUME"
echo -e "$MIC"
echo ""
echo -e "  lubuntu-20.01"


