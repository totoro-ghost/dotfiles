#!/bin/bash

CUR_BRI=$(cat /sys/class/backlight/intel_backlight/brightness)
MAX_BRI=$(cat /sys/class/backlight/intel_backlight/max_brightness)

# calculating 5 percent of max-brightness
((STEP = MAX_BRI * 5 / 100))

case $1 in
-inc)
    ((NEW_BRI = CUR_BRI + STEP))
    if ((NEW_BRI < MAX_BRI)); then
        echo $NEW_BRI | tee /sys/class/backlight/intel_backlight/brightness
    else
        echo $MAX_BRI | tee /sys/class/backlight/intel_backlight/brightness
    fi
    ;;
-dec)
    # calculating MIN_BRI
    ((MIN_BRI = MAX_BRI * 10 / 100))
    ((NEW_BRI = CUR_BRI - STEP))
    if ((NEW_BRI > MIN_BRI)); then
        echo $NEW_BRI | tee /sys/class/backlight/intel_backlight/brightness
    else
        echo $MIN_BRI | tee /sys/class/backlight/intel_backlight/brightness
    fi
    ;;
*)
    echo "Invalid arguments."
    ;;
esac

# enable ipc control to change brightness
polybar-msg hook brightness 1 
sleep 0.1