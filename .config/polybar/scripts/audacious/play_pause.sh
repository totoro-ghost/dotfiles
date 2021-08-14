#!/usr/bin/env bash

if pgrep -x "audacious" >/dev/null; then
	audacious -t
fi

polybar-msg hook music 1 && polybar-msg hook music_t 1