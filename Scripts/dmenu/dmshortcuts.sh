#!/bin/bash
#
# Use: Show a cheat sheet for shortcuts of programs.
# Dependencies: dmenu

dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf")

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")

font_size="16"

# add more programs
declare -a options=(
    "i3"
    "zathura"
    "feh"
)

choice=$(printf '%s\n' "${options[@]}" |
    sed 's/^/ /' |
    dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p '     ')

SOURCES=$HOME/Scripts/dmenu/src/shortcuts

if [ "$choice" == " i3" ]; then
    if [ ! -f "$HOME/.config/i3/config" ]; then
        exit
    fi
    grep ^bindsym "$HOME/.config/i3/config" |
        sed 's/bindsym //' |
        sed 's/ --no-startup-id //' |
        sed 's/$mod//' |
        sed 's/exec/ /' |
        sed 's/+/  /' |
        sed 's/^/ /' |
        dmenu \
            -i \
            -l 20 -nb "$nselect_bg" \
            -nf "$nselect_fg" \
            -sb "$select_bg" \
            -sf "$select_fg" \
            -fn "$font"-"$font_size" \
            -p "   "

elif [ "$choice" == " zathura" ]; then
    cat <"$SOURCES"/zathura | sed 's/^/ /' | sed 's/->/ /' |
        dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p '     '

elif [ "$choice" == " feh" ]; then
    cat <"$SOURCES"/feh | sed 's/^/ /' | sed 's/=>/ /' |
        dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p '     '
fi
