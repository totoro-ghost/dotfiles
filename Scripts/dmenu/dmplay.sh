#!/bin/bash
#
# Use: Select the local directory of songs, and then play songs by searching them directly from dmenu.
# Dependencies: dmenu and a music player

# configuration
dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf")

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")

font_size=16

x=$(awk '$1=="x" {print $2}' "$dconf")
y=$(awk '$1=="y" {print $2}' "$dconf")
z=900

x=$((x - z / 2))
y=$((y - 300))

SONG_DIR="/media/antihero/Data/Songs"

# prompt on dmenu, use your own or install feather.ttf
PROMPT_STR="ﱘ"

if [ ! -d $SONG_DIR ]; then
	#echo "does not exists"
	echo "Drive not mounted. / Folder dosen't exists" |
		dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p "ERROR :-("
	exit 1
fi

var1=$(find $SONG_DIR -type f -name "*.mp3" -o -name "*.webm" -o -name "*.m3u" -o -name "*.ogg" -o -name "*.opus" -o -name "*.m4a" |
	shuf |
	sed "s+$SONG_DIR++" |
	dmenu -i -l 20 \
		-x $x\
		-y $y\
		-z $z\
		-bw 1\
		-nb "$nselect_bg" \
		-nf "$nselect_fg" \
		-sb "$select_bg" \
		-sf "$select_fg" \
		-fn "$font"-"$font_size" \
		-p "$PROMPT_STR ")

# now you can open the song with player of your choice
if [ -n "$var1" ]; then
	# audacious -E "$SONG_DIR/$var1"
	# mpv "$SONG_DIR/$var1" --no-resume-playback --x11-name="music"
	vlc "$SONG_DIR/$var1"
fi
