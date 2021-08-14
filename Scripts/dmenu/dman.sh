#!/bin/bash
#
# Use: Search for a manpage or get a random one.
# Dependencies: dmenu, xargs

# configuration
dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf")

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")

# Defining the terminal emulator to use.
DMTERM="alacritty -e"

# An array of options to choose.
declare -a options=(
	"Search manpages"
	"Random manpage"
	"Quit"
)

# Piping the above array into dmenu.
# We use "printf '%s\n'" to format the array one item to a line.
choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p 'Manpages:')

# What to do when/if we choose one of the options.
case "$choice" in
'Search manpages')
	man -k . | awk '{$3="-"; print $0}' |
		dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p 'Search for:' |
		awk '{print $2, $1}' | tr -d '()' | xargs $DMTERM man
	;;
'Random manpage')
	man -k . | awk '{print $1}' | shuf -n 1 |
		dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p 'Random manpage:' | xargs $DMTERM man
	;;
'Quit')
	echo "Program terminated." && exit 1
	;;
*)
	exit 1
	;;
esac
