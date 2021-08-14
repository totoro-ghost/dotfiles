#!/bin/bash

MAX_BRI=$(cat /sys/class/backlight/intel_backlight/max_brightness)
CUR_BRI=$(cat /sys/class/backlight/intel_backlight/brightness)

# calculating MIN_BRI
(( MIN_BRI = MAX_BRI * 10 / 100 ))

# calculating 5 percent of max-brightness
(( STEP = MAX_BRI * 5 / 100 ))

# calculating current percentage
(( CUR_PER = CUR_BRI * 100 / MAX_BRI ))

# echo $MAX_BRI $CUR_BRI $STEP

case $1 in
  -inc)
    (( NEW_BRI = CUR_BRI + STEP ))
    # echo $NEW_BRI
    if (( NEW_BRI < MAX_BRI )); then
        # echo "set.."
        echo $NEW_BRI | tee /sys/class/backlight/intel_backlight/brightness
    else
        # echo "not set.."
        echo $MAX_BRI | tee /sys/class/backlight/intel_backlight/brightness
    fi
    ;;
  -dec)
    (( NEW_BRI = CUR_BRI - STEP ))
    echo $NEW_BRI
    if (( NEW_BRI > MIN_BRI )); then
        # echo "set.."
        echo $NEW_BRI | tee /sys/class/backlight/intel_backlight/brightness
    else
        # echo "not set.."
        echo $MIN_BRI | tee /sys/class/backlight/intel_backlight/brightness
    fi
    ;;
  -get)
    echo $CUR_PER
    ;;
  *)
    echo "Invalid arguments."
    ;;
esac
