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
DIR="$HOME/Scripts/basic/cat"
STEP=5

case "$1" in
-inc)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi
    ((NEWVOL = $VOL + $STEP))
    if [ $NEWVOL -lt 130 ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +$STEP%
        if [ $NEWVOL -gt 100 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Increase \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/audio-volume-overamplified-symbolic.svg \
                -r 100
        elif [ $NEWVOL -gt 70 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Increase \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/audio-volume-high-symbolic.svg \
                -r 100
        elif [ $NEWVOL -gt 40 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Increase \nVolume: " \
                -h int:value:$NEWVOL \
                -i $HOME/Scripts/basic/cat/audio-volume-medium-symbolic.svg \
                -r 100
        else
            dunstify -a "Volume" \
                "Volume" \
                "Increase \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/audio-volume-muted-symbolic.svg \
                -r 100
        fi
    else
        pactl set-sink-volume @DEFAULT_SINK@ 130%
        dunstify -a "Volume" \
            "Volume" \
            "Increase \nVolume: " \
            -h int:value:130 \
            -i $DIR/audio-volume-overamplified-symbolic.svg \
            -r 100
    fi
    ;;
-dec)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
    fi
    ((NEWVOL = $VOL - $STEP))
    if [ $NEWVOL -gt -1 ]; then
        pactl set-sink-volume @DEFAULT_SINK@ -$STEP%
        if [ $NEWVOL -gt 100 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Decrease \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/audio-volume-overamplified-symbolic.svg \
                -r 100
        elif [ $NEWVOL -gt 70 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Decrease \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/audio-volume-high-symbolic.svg \
                -r 100
        elif [ $NEWVOL -gt 40 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Decrease \nVolume: " \
                -h int:value:$NEWVOL \
                -i $HOME/Scripts/basic/cat/audio-volume-medium-symbolic.svg \
                -r 100
        else
            dunstify -a "Volume" \
                "Volume" \
                "Decrease \nVolume: " \
                -h int:value:$NEWVOL \
                -i $DIR/audio-volume-muted-symbolic.svg \
                -r 100
        fi
    else
        pactl set-sink-volume @DEFAULT_SINK@ 0%
        dunstify -a "Volume" \
            "Volume" \
            "Decrease \nVolume: " \
            -h int:value:0 \
            -i $DIR/audio-volume-muted-symbolic.svg \
            -r 100
    fi
    ;;
-mute)
    if [ "$MUTE" = "yes" ]; then
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if [ $VOL -gt 100 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Current \nVolume: " \
                -h int:value:$VOL \
                -i $DIR/audio-volume-overamplified-symbolic.svg \
                -r 100
        elif [ $VOL -gt 70 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Current \nVolume: " \
                -h int:value:$VOL \
                -i $DIR/audio-volume-high-symbolic.svg \
                -r 100
        elif [ $VOL -gt 40 ]; then
            dunstify -a "Volume" \
                "Volume" \
                "Current \nVolume: " \
                -h int:value:$VOL \
                -i $HOME/Scripts/basic/cat/audio-volume-medium-symbolic.svg \
                -r 100
        else
            dunstify -a "Volume" \
                "Volume" \
                "Current \nVolume: " \
                -h int:value:$VOL \
                -i $DIR/audio-volume-muted-symbolic.svg \
                -r 100
        fi
    else
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        dunstify -a "Volume" \
            "Volume" \
            "Mute \nVolume" \
            -r 100 \
            -i $DIR/audio-volume-mute.png
    fi
    ;;
*)
    exit 1
    ;;
esac
