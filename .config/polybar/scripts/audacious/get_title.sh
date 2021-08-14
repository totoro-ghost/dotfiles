#!/bin/sh

if pgrep -x "audacious" >/dev/null; then
    echo "%{F#50FA7B}%{F-} $(audtool --current-song-tuple-data title | sed 's/./.../20' | head -c 22)"
else
    echo " "
fi