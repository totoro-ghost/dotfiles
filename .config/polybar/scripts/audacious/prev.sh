#!/bin/bash
if pgrep -x "audacious" >/dev/null; then
    audacious -r
fi

polybar-msg hook music 1 && polybar-msg hook music_t 1