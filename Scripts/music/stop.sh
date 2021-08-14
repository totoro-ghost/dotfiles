#!/bin/bash

if pgrep -x "cmus" >/dev/null; then
    cmus-remote --stop
fi

if pgrep -x "audacious" >/dev/null; then
    audacious -s
fi

if pgrep -x "vlc" >/dev/null; then
    dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 \
        org.mpris.MediaPlayer2.Player.Stop
fi

exit
