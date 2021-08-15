#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar according to the wm you are using
t=$(xrandr -q | grep -c " connected ")

if [ "$t" = "2" ]; then
    # two monitors setup
    if [ "$DESKTOP_SESSION" = "i3" ]; then
        # launch two bars
        echo "Launching two Polybar for i3 dual monitor."
        if [ "$1" == "-compact" ]; then
            polybar -q main -c "$DIR"/config_i3_campact.ini &
            polybar -q main2 -c "$DIR"/config_i3_2_compact.ini &
        else
            polybar -q main -c "$DIR"/config_i3.ini &
            polybar -q main2 -c "$DIR"/config_i3_2.ini &
        fi
    # add config for other wm
    fi
else
    # one monitor setup
    if [ "$DESKTOP_SESSION" = "i3" ]; then
        echo "Launching Polybar for i3."
        if [ "$1" == "-compact" ]; then
            polybar -q main -c "$DIR"/config_i3_compact.ini &
        else
            polybar -q main -c "$DIR"/config_i3.ini &
        fi
    fi
    # add config for other wm
fi
