#!/bin/bash

## usage :
##  tabs.sh -save #save tabs to file
##  tabs.sh -open #open the tabs in the firefox

CURDIR="$HOME/Scripts/firefox"
DESTDIR="$HOME/Downloads/.cache"

case $1 in
"-save")
    FILENAME="$(date +%H_%d_%m)"
    if pgrep -x "firefox" >/dev/null; then
        echo "Saving... to $DESTDIR/$FILENAME"
        $CURDIR/get_tabs.py >$DESTDIR/$FILENAME
    fi
    ;;
"-open")
    FILENAME="$(ls $DESTDIR -1 -t | head -n 1)"
    echo "Opening tabs..."
    FILE="$DESTDIR/$FILENAME"
    # cat $DESTDIR/$FILENAME
    while read -r line; do
        echo "Opening $line ..."
        firefox --new-tab "$line" 2>/dev/null &
        sleep 1
    done <"$FILE"
    # done <"$DESTDIR/$FILENAME"
    ;;
*)
    echo "Invalid flags.."
    ;;
esac
