#!/bin/bash

getdefaultsinkname() {
    pacmd stat | awk -F": " '/^Default sink name: /{print $2}'
}

getdefaultsinkvol() {
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'"$(getdefaultsinkname)"'>"}
            /^\s+volume: / && indefault {print $5; exit}' |
        sed 's/%//'
}

getmutestat() {
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'"$(getdefaultsinkname)"'>"}
            /^\s+muted: / && indefault {print $2; exit}'
}

setdefaulsinkvol() {
    pactl set-sink-volume "$(getdefaultsinkname)" $1
}

if ! pulseaudio --check; then
    echo "Puseaudio Inactive"
    exit
fi

MUTE=$(getmutestat)
VOL=$(getdefaultsinkvol)
DIR="$HOME/Scripts/basic/icons"

case "$1" in
-inc)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi
    if [ $VOL -lt 130 ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +1%
        ((NEWVOL = $VOL + 1))
        if [ $VOL -gt 70 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Increase \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/volume_up.svg \
                -r 100
        elif [ $VOL -gt 40 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Increase \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/volume_down.svg \
                -r 100
        else
            dunstify -a "Volume" \
                "Volume" \
                "Increase \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/volume_mute.svg \
                -r 100
        fi
    fi
    ;;
-dec)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi
    pactl set-sink-volume @DEFAULT_SINK@ -1%
    ((NEWVOL = $VOL + 1))
    if [ $VOL -gt 70 ]; then
        dunstify -a "Volume" \
                "Volume" \
                "Decrease \nVolume: " \
                -h int:value:$NEWVOL \
                -r 100 \
            -i $DIR/volume_up.svg
    elif [ $VOL -gt 40 ]; then
        dunstify -a "Volume" \
                "Volume" \
                "Decrease \nVolume: " \
                -h int:value:$NEWVOL \
                -r 100 \
            -i $DIR/volume_down.svg
    else
        dunstify -a "Volume" \
                "Volume" \
                "Decrease \nVolume: " \
                -h int:value:$NEWVOL \
                -r 100 \
            -i $DIR/volume_mute.svg
    fi
    ;;
-mute)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if [ $VOL -gt 70 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Unmute \nVolume" \
                -h int:value:$VOL \
                -r 100 \
                -i $DIR/volume_up.svg
        elif [ $VOL -gt 40 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Unmute \nVolume" \
                -h int:value:$VOL \
                -p 100 \
                -i $DIR/volume_down.svg
        else
            dunstify -a "Volume" \
                "Volume" \
                "Unmute \nVolume" \
                -h int:value:$VOL \
                -r 100 \
                -i $DIR/volume_mute.svg
        fi
    else 
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        dunstify -a "Volume" \
                "Volume" \
                "Mute \nVolume" \
                -r 100 \
                -i $DIR/volume_off.svg
    fi
    ;;
*)
    exit 1
    ;;
esac
