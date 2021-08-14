#!/bin/bash

DIR="$HOME/Scripts/basic/cat"

MAX_BRI=$(cat /sys/class/backlight/intel_backlight/max_brightness)
CUR_BRI=$(cat /sys/class/backlight/intel_backlight/brightness)

# calculating MIN_BRI
((MIN_BRI = MAX_BRI / 10))

# calculating 5 percent of max-brightness
((STEP = MAX_BRI * 5 / 100))

# calculating current percentage
((CUR_PER = CUR_BRI * 100 / MAX_BRI))

# echo $MAX_BRI $CUR_BRI $STEP

case $1 in
-inc)
    ((NEW_BRI = CUR_BRI + STEP))
    ((NEW_PER = NEW_BRI * 100 / MAX_BRI))
    # echo $NEW_BRI
    if ((NEW_BRI < MAX_BRI)); then
        # echo "set.."
        echo $NEW_BRI | tee /sys/class/backlight/intel_backlight/brightness
        if ((NEW_PER > 80)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Increase \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_7.png
        elif ((NEW_PER > 70)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Increase \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_6.png
        elif ((NEW_PER > 60)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Increase \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_5.png
        elif ((NEW_PER > 50)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Increase \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_4.png
        elif ((NEW_PER > 40)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Increase \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_3.png
        elif ((NEW_PER > 20)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Increase \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_2.png
        else
            dunstify -a "Brightness" \
                "Brightness" \
                "Increase \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_1.png
        fi
    else
        # echo "not set.."
        echo $MAX_BRI | tee /sys/class/backlight/intel_backlight/brightness
        dunstify -a "Brightness" \
                "Brightness" \
                "Increase \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_7.png
    fi
    ;;
-dec)
    ((NEW_BRI = CUR_BRI - STEP))
    ((NEW_PER = NEW_BRI * 100 / MAX_BRI))
    # echo $NEW_BRI
    if ((NEW_BRI > MIN_BRI)); then
        # echo "set.."
        echo $NEW_BRI | tee /sys/class/backlight/intel_backlight/brightness
        if ((NEW_PER > 80)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Decrease \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_7.png
        elif ((NEW_PER > 70)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Decrease \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_6.png
        elif ((NEW_PER > 60)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Decrease \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_5.png
        elif ((NEW_PER > 50)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Decrease \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_4.png
        elif ((NEW_PER > 40)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Decrease \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_3.png
        elif ((NEW_PER > 20)); then
            dunstify -a "Brightness" \
                "Brightness" \
                "Decrease \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_2.png
        else
            dunstify -a "Brightness" \
                "Brightness" \
                "Decrease \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_1.png
        fi
    else
        # echo "not set.."
        echo $MIN_BRI | tee /sys/class/backlight/intel_backlight/brightness
        dunstify -a "Brightness" \
                "Brightness" \
                "Decrease \nBrightness: " \
                -h int:value:$NEW_PER \
                -r 100 \
                -i $DIR/brightness_1.png
    fi
    ;;
-get)
    echo $CUR_PER
    ;;
*)
    echo "Invalid arguments."
    ;;
esac

# polybar ipc control
polybar-msg hook brightness 1 