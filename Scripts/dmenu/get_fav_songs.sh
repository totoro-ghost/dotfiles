#!/bin/bash
#
# Use: 
# Dependencies: dmenu

dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf" )

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")

if [ ! -d "/media/antihero/Data/Songs" ]; then
    #echo "does not exists"
    echo "Drive not mounted." | dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size"
    exit 1
fi

find "/media/antihero/Data/Songs/" -type f |
    dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" >>/media/antihero/Data/Songs/fav.txt

# xargs -I{} audacious -E "{}"
# xargs -I{} echo "{}"
# sed 's/^.//' |\
