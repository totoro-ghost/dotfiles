#!/bin/sh

getdefaultsinkname() {
    pacmd stat | awk -F": " '/^Default sink name: /{print $2}'
}

getdefaultsinkvol() {
    pacmd list-sinks |
        awk '/^\s+name: /{indefault = $2 == "<'"$(getdefaultsinkname)"'>"}
            /^\s+volume: / && indefault {print $5; exit}' |
        sed 's/%//'

}

setdefaulsinkvol() {
    pactl set-sink-volume "$(getdefaultsinkname)" $1
}

case $1 in
    -inc)
        if [ "$(getdefaultsinkvol)" -lt 100 ]; then
            pactl set-sink-volume @DEFAULT_SINK@ +1%
        fi
    ;;
    -dec)
        pactl set-sink-volume @DEFAULT_SINK@ -1%
    ;;
    *)
        exit 1
    ;;
esac