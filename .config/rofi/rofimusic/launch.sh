#!/bin/bash

# THEME=$HOME/.config/rofi/shortcuts/themes/onedark.rasi
THEME="$HOME/.config/rofi/rofi-themes/User Themes/onedark.rasi"

SONG_DIR="/media/antihero/Data/Songs"

# prompt on dmenu, use your own or install feather.ttf
PROMPT_STR="Song"

if [ ! -d $SONG_DIR ]; then
	#echo "does not exists"
	echo "Drive not mounted. / Folder dosen't exists" |
		rofi -theme "$THEME" -dmenu -p "ERROR :-("
	exit 1
fi

var1=$(find $SONG_DIR -type f |
	sed "s+$SONG_DIR++" |
	rofi -theme "$THEME" -dmenu -i -p "$PROMPT_STR " -i -sorting-method fzf )

# now you can open the song with player of your choice
if [ -n "$var1" ]; then
	audacious -E "$SONG_DIR/$var1"
fi
