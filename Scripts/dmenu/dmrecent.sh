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

font_size=16

# prompt on dmenu, use your own or install feather.ttf
PROMPT_STR="Recent Files::"
R_DIR="$HOME/.local/share/RecentDocuments/"

if [ ! -d $R_DIR ]; then
    #echo "does not exists"
    echo "Folder dosen't exists :-(" |
        dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p "ERROR :-("
    exit 1
fi

var1=$(find $R_DIR -type f -name "*.desktop" |
    sed "s+$R_DIR++" | sed 's|.desktop||' |
    dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p "$PROMPT_STR")

# now you can open the song with player of your choice
if [ -n "$var1" ]; then
    # audacious -E "$R_DIR/$var1"
    # echo $var1
    var2=$(grep "^URL\[\$e\]=file://" "$R_DIR/$var1.desktop" | sed 's|URL\[\$e\]=file://||')
    var3=$(grep "^URL\[\$e\]=file:\$HOME" "$R_DIR/$var1.desktop" | sed 's|URL\[\$e\]=file:\$HOME/||')
    # echo $var2
    if [ -n "$var2" ]; then
        xdg-open "$var2"
    elif [ -n "$var3" ]; then
        # echo $HOME/$var3
        xdg-open "$HOME/$var3"
    else
        exit 1
    fi
    # echo $error | dmenu
fi
