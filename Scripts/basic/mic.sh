#!/bin/bash

# Get active audio source index
CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -f3 -d" ")

# List lines in pactl after the source name match and pick mute status

OUT=$(pactl list sources | grep -A 10 "$CURRENT_SOURCE")
CHECK="Mute: yes"
DIR="$HOME/Scripts/basic/icons"

if [[ "$OUT" == *"$CHECK"* ]]; then
    # echo "MUTE"
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    notify-send "Mic Unmute   " \
        -h string:synchronous:mic \
        -i $DIR/mic.svg
else
    # echo "NOT MUTE"
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    notify-send "Mic mute " \
        -h string:synchronous:mic \
        -i $DIR/mic_off.svg
fi
