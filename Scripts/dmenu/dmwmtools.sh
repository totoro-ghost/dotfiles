#!/bin/bash
#
# Use: For basic tasks you want.
# Dependencies: dmenu

# configuration
dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf")

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")

font_size=20

declare -a options=(
    "dunst - restart"
    "dunst - toggle visibility"
    "picom - kill"
    "picom - restart"
)

choice=$(printf '%s\n' "${options[@]}" |
    dmenu -i -l 20 \
        -c\
        -nb "$nselect_bg" \
        -nf "$nselect_fg" \
        -sb "$select_bg" \
        -sf "$select_fg" \
        -fn "$font"-"$font_size" \
        -p 'Select option> ')

case $choice in
'dunst - restart')
    if pgrep -x "dunst" >/dev/null; then
        pkill dunst
        dunst
    else
        dunst
    fi
    ;;
"dunst - toggle visibility")
    if pgrep -x "dunst" >/dev/null; then
        dunstctl set-paused toggle
    else
        dunst
    fi
    ;;
"picom - kill")
    pkill picom
    ;;
"picom - restart")
    killall -qw picom
    picom -b
    ;;
*)
    exit 1
    ;;
esac
