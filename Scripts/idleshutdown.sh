#!/bin/bash

idletime=$((1000 * 60 * 60 * 2)) # 2 hours in milliseconds
fivemin=$((1000 * 60 * 5)) # 5 min in milliseconds

while true; do
    idle=$(xprintidle)
    echo $idle
    if (($idle > $idletime)); then
        #sudo shutdown -P now
        dbus-send --system --print-reply \
            --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true
    fi
    sleep 1
done
