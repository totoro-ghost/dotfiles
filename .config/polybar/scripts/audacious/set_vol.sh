#!/bin/bash

if pgrep -x "audacious" >/dev/null; then
    cur_vol=$(audtool --get-volume)
    s=10
    if [ "$1" = "-inc" ]; then
        ((new_vol = cur_vol + s))
        if [[ $new_vol -le 100 && $new_vol -ge 0 ]]; then
            # echo "new volume is  $new_vol"
            audtool --set-volume $new_vol
        fi
    elif [ "$1" = "-dec" ]; then
        ((new_vol = cur_vol - s))
        if [[ $new_vol -le 100 && $new_vol -ge 0 ]]; then
            # echo "new volume is  $new_vol"
            audtool --set-volume $new_vol
        fi
    fi
fi