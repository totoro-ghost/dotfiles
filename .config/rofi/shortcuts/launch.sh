#!/bin/bash

THEME=$HOME/.config/rofi/shortcuts/themes/onedark.rasi
THEME1=$HOME/.config/rofi/shortcuts/themes/slate.rasi
SOURCES=$HOME/.config/rofi/shortcuts/src

# add more programs
declare -a options=(
    "nvim"
    "i3"
    "zathura"
    "feh"
    "scrcpy"
)

WINID=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW)/ {print $NF}' | xargs printf "%#010x\n")

WM_CLASS=$(xprop -id $WINID | awk '/WM_CLASS/ {print $NF}')
WM_CLASS_=${WM_CLASS//\"/}

WM_NAME=$(xprop -id $WINID | awk -vFPAT='("[^"]+")' '/WM_NAME\(STRING)/ {print $NF}')
WM_NAME_=${WM_NAME//\"/}

TERM_PID=$(xprop -id $WINID | awk '/_NET_WM_PID/ {print $NF}')

echo "WINDID: $WINID"
echo "WM_CLASS: $WM_CLASS : $WM_CLASS_"
echo "WM_NAME: $WM_NAME : $WM_NAME : $WM_NAME_"
echo "TERM_PID: $TERM_PID"

choice=""

if [ "$WM_CLASS_" == "Alacritty" ]; then
    if pstree -a -p $TERM_PID | grep -q "nvim"; then
        choice="nvim"
    fi
elif [ "$WM_CLASS_" == "zathura" ] || [ "$WM_CLASS_" == "Zathura" ]; then
    choice="zathura"
elif [ "$WM_CLASS_" == "scrcpy" ] || [ "$WM_CLASS_" == "scrcpy" ]; then
    choice="scrcpy"
elif [ "$WM_CLASS_" == "feh" ] || [ "$WM_CLASS_" == "Feh" ]; then
    choice="feh"
fi

if [ -z "$choice" ]; then
    choice=$(printf '%s\n' "${options[@]}" |
        rofi -theme "$THEME1" -dmenu -i -p "")
fi

if [ "$choice" == "i3" ]; then
    if [ ! -f "$HOME/.config/i3/config" ]; then
        exit
    fi
    grep ^bindsym "$HOME/.config/i3/config" |
        sed 's/\s/\t\t\t/2' |
        sed 's/bindsym //' |
        sed 's/ --no-startup-id //' |
        sed 's/$mod//' |
        sed 's/exec//' |
        sed 's/--release //' |
        sed 's/+/ + /' |
        rofi -theme "$THEME" -dmenu -p "i3" -i

elif [ "$choice" == "zathura" ]; then
    cat <"$SOURCES"/zathura | rofi -markup-rows -theme "$THEME" -dmenu -i -p "zathura"

elif [ "$choice" == "feh" ]; then
    cat <"$SOURCES"/feh | rofi -theme "$THEME" -dmenu -i -p "feh"

elif [ "$choice" == "nvim" ]; then
    cat <"$SOURCES"/nvim | rofi -theme "$THEME" -dmenu -i -p "nvim"

elif [ "$choice" == "scrcpy" ]; then
    cat <"$SOURCES"/scrcpy | rofi -markup-rows -theme "$THEME" -dmenu -i -p "scrcpy"
fi
