#!/usr/bin/env bash

theme="left"
dir="$HOME/.config/rofi/emoji"
# cat "$dir/emoji" | rofi -dmenu -i -theme $dir/"$theme".rasi

chosen=$(sed 's/U+.*//' ~/.config/rofi/emoji/emoji.md |
    rofi -dmenu -p " Search emoji> " -i -theme $dir/"$theme".rasi |
    sed "s/ .*//")

# chosen=$(cut -d' ' -f1 ~/.config/rofi/emoji/emoji.md |
#     rofi -dmenu -p " Search emoji> " -i -theme $dir/"$theme".rasi |
#     sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	xdotool type "$chosen"
else
	printf "$chosen" | xclip -selection clipboard
	# notify-send "'$chosen' copied to clipboard." &
fi
