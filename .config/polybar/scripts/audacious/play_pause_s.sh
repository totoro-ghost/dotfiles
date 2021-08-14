#!/usr/bin/env bash

if pgrep -x "audacious" >/dev/null; then
    vol=$(audtool --get-volume)
    if [ "$(audtool playback-status)" = "playing" ]; then
        echo " $vol%"
    elif [ "$(audtool playback-status)" = "paused" ]; then
        echo "ﱙ NP"
    fi
else
    echo "ﱙ NA"
fi

