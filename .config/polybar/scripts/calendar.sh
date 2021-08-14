#!/bin/bash

CAL=$(cal | sed 's|_||g' | sed "s|$(date +%e)|<i><b><u>$(date +%e)</u></b></i>|" | sed 's/[ \t]*$//')

# send wrong icon so dunst don't display icon
dunstify -a "Calendar" "Calendar" "$CAL" -i "wrong icon" -t 4000
