#!/bin/bash

DIR="$HOME/Scripts/basic/icons"

case "$1" in
"-screen")
    TMP=$(date '+%Y-%m-%d-%H%M%S')
    maim ~/Pictures/Screenshots/scrot-full-"$TMP".png
    if [ $? -eq 0 ]; then
        # NAME="$HOME/Pictures/Screenshots/scrot-window-"$(date '+%Y-%m-%d-%H%M%S')".png"
        notify-send "Screenshot:" "Entire screeen" \
            -i $HOME/Pictures/Screenshots/scrot-full-"$TMP".png
    else
        notify-send "Screenshot:" "Failed...\nError Code: $?" -i $DIR/camera.svg
    fi
    ;;
"-select")
    TMP=$(date '+%Y-%m-%d-%H%M%S')
    maim -s ~/Pictures/Screenshots/scrot-region-"$TMP".png
    if [ $? -eq 0 ]; then
        notify-send "Screenshot:" "Selection saved" \
            -i $HOME/Pictures/Screenshots/scrot-region-$TMP.png
    else
        notify-send "Screenshot:" "Failed...\nError Code: $?" -i $DIR/camera.svg
    fi
    ;;
"-select_copy")
    maim -s | xclip -selection clipboard -t image/png
    if [ $? -eq 0 ]; then
        notify-send "Screenshot:" "Selection copied" -i $DIR/camera.svg
    else
        notify-send "Screenshot:" "Failed...\nError Code: $?" -i $DIR/camera.svg
    fi
    ;;
esac

# bindsym Print exec --no-startup-id maim ~/Pictures/Screenshots/scrot-full-"$(date '+%Y-%m-%d-%H%M%S')".png
# bindsym $mod+Shift+Print --release exec --no-startup-id "scrot --silent --select '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f && rm $f'"; exec notify-send "Select to copy to clipboard"
# bindsym $mod+Print --release exec --no-startup-id "scrot --select --silent --exec 'mv $f ~/Pictures/Screenshots/'"; exec notify-send "Select area to screenshot."
