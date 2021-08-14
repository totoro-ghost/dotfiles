#!/bin/sh
#
# Use: Coies selected emoji to clipboard.
# Dependencies: dmenu, xdotool, notify-send(optional)

# configuration
dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf")

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
# font_size=$(awk '$1=="font_size" {print $2}' "$dconf")
font_size=20

# Get user selection via dmenu from emoji file.
chosen=$(cut -d ';' -f1 ~/Scripts/dmenu/src/emoji | dmenu -i \
	-l 15 -nb "$nselect_bg" \
	-nf "$nselect_fg" \
	-sb "$select_bg" \
	-sf "$select_fg" \
	-fn "$font"-"$font_size" |
	sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	xdotool type "$chosen"
else
	printf "$chosen" | xclip -selection clipboard
	notify-send "'$chosen' copied to clipboard." &
fi
