#!/bin/bash

if pgrep -x "cmus" >/dev/null; then
    cmus-remote --next
fi

if pgrep -x "audacious" >/dev/null; then
    audacious -f
fi

if pgrep -x "vlc" >/dev/null; then
    dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 \
        org.mpris.MediaPlayer2.Player.Next
fi

exit
