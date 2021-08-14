#!/bin/bash
#
# Description: Choose type of screenshot to take with maim.
# Dependencies: dmenu, maim, tee, xdotool, xclip

# configuration
dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf")

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")

# Specifying a directory to save our screenshots.
# Make sure the directory exists.
SCROTDIR="$HOME/Pictures/Screenshots"

# An array of options to choose.
# Note that options for monitor 1, 2 and 3 work only if you have
# 3 monitors (of course) that are set to 1920x1080 resolution.
declare -a options=(
	"Fullscreen"
	"Active window"
	"Selected region"
	"Fullscreen (copy only)"
	"Active window (copy only)"
	"Selected region (copy only)"
	"Fullscreen (screenshot plus copy)"
	"Active window (screenshot plus copy)"
	"Selected region (screenshot plus copy)"
	"Monitor 1"
	"Monitor 2"
	"Monitor 3"
	"Monitor 1 (copy only)"
	"Monitor 2 (copy only)"
	"Monitor 3 (copy only)"
	"Monitor 1 (screenshot plus copy)"
	"Monitor 2 (screenshot plus copy)"
	"Monitor 3 (screenshot plus copy)"
)

# Piping the above array into dmenu.
# We use "printf '%s\n'" to format the array one item to a line.
choice=$(printf '%s\n' "${options[@]}" |
	dmenu -i -l 20 \
		-nb "$nselect_bg" \
		-nf "$nselect_fg" \
		-sb "$select_bg" \
		-sf "$select_fg" \
		-fn "$font"-"$font_size" \
		-p 'Take screenshot of:')

sleep 1;

# What to do when/if we choose one of the options.
case "$choice" in
'Fullscreen')
	maim "$SCROTDIR"/scrot-full-"$(date '+%Y-%m-%d-%H%M%S')".png
	;;
'Active window')
	maim -i "$(xdotool getactivewindow)" "$SCROTDIR"/scrot-window-"$(date '+%Y-%m-%d-%H%M%S')".png
	;;
'Selected region')
	maim -s "$SCROTDIR"/scrot-region-"$(date '+%Y-%m-%d-%H%M%S')".png
	;;
'Fullscreen (copy only)')
	maim |
		xclip -selection clipboard -t image/png
	;;
'Active window (copy only)')
	maim -i "$(xdotool getactivewindow)" |
		xclip -selection clipboard -t image/png
	;;
'Selected region (copy only)')
	maim -s |
		xclip -selection clipboard -t image/png
	;;
'Fullscreen (screenshot plus copy)')
	maim |
		tee "$SCROTDIR"/scrot-full-"$(date '+%Y-%m-%d-%H%M%S')".png |
		xclip -selection clipboard -t image/png
	;;
'Active window (screenshot plus copy)')
	maim -i "$(xdotool getactivewindow)" |
		tee "$SCROTDIR"/scrot-window-"$(date '+%Y-%m-%d-%H%M%S')".png |
		xclip -selection clipboard -t image/png
	;;
'Selected region (screenshot plus copy)')
	maim -s |
		tee "$SCROTDIR"/scrot-region-"$(date '+%Y-%m-%d-%H%M%S')".png |
		xclip -selection clipboard -t image/png
	;;
'Monitor 1')
	maim -g 1920x1080+0+0 "$SCROTDIR"/scrot-mon1-"$(date '+%Y-%m-%d-%H%M%S')".png
	;;
'Monitor 2')
	maim -g 1920x1080+1920+0 "$SCROTDIR"/scrot-mon2-"$(date '+%Y-%m-%d-%H%M%S')".png
	;;
'Monitor 3')
	maim -g 1920x1080+3840+0 "$SCROTDIR"/scrot-mon3-"$(date '+%Y-%m-%d-%H%M%S')".png
	;;
'Monitor 1 (copy only)')
	maim -g 1920x1080+0+0 |
		xclip -selection clipboard -t image/png
	;;
'Monitor 2 (copy only)')
	maim -g 1920x1080+1920+0 |
		xclip -selection clipboard -t image/png
	;;
'Monitor 3 (copy only)')
	maim -g 1920x1080+3840+0 |
		xclip -selection clipboard -t image/png
	;;
'Monitor 1 (screenshot plus copy)')
	maim -g 1920x1080+0+0 |
		tee "$SCROTDIR"/scrot-mon1-"$(date '+%Y-%m-%d-%H%M%S')".png |
		xclip -selection clipboard -t image/png
	;;
'Monitor 2 (screenshot plus copy)')
	maim -g 1920x1080+1920+0 |
		tee "$SCROTDIR"/scrot-mon2-"$(date '+%Y-%m-%d-%H%M%S')".png |
		xclip -selection clipboard -t image/png
	;;
'Monitor 3 (screenshot plus copy)')
	maim -g 1920x1080+3840+0 |
		tee "$SCROTDIR"/scrot-mon3-"$(date '+%Y-%m-%d-%H%M%S')".png |
		xclip -selection clipboard -t image/png
	;;
*)
	exit 1
	;;
esac
