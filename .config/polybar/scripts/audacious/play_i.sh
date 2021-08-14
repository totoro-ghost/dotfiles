#!/usr/bin/env bash

if pgrep -x "audacious" >/dev/null; then
    STATUS=$(audtool playback-status)
    if [ "$STATUS" = "playing" ]; then
        echo ""
    elif [ "$STATUS" = "paused" ]; then
        echo ""
    elif [ "$STATUS" = "stopped" ]; then
        echo ""
    fi
else
    echo ""
fi