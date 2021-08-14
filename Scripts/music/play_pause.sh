#!/usr/bin/env bash

if pgrep -x "cmus" >/dev/null; then
	if [[ $(cmus-remote -Q | grep status | awk '{print $2}') == "playing" ]]; then
		cmus-remote --pause
	elif [[ $(cmus-remote -Q | grep status | awk '{print $2}') == "paused" ]]; then
		cmus-remote --play
	fi
fi

if pgrep -x "audacious" >/dev/null; then
	audacious -t
fi

if pgrep -x "vlc" >/dev/null; then
    dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 \
        org.mpris.MediaPlayer2.Player.PlayPause
fi

exit
