#!/bin/bash
#
# Use: Shows saved bookmarks for Firefox Browser
# Dependencies: dmenu and ./src/bookmarks.py

# configuration
dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf")

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")

python3 "$HOME"/Scripts/dmenu/src/bookmarks.py |
    sed 's/^unfiled //' |
    sed 's/^menu //' |
    dmenu \
        -i \
        -l 20 -nb "$nselect_bg" \
        -nf "$nselect_fg" \
        -sb "$select_bg" \
        -sf "$select_fg" \
        -fn "$font"-"$font_size" \
        -p "   " |
    sed -n -e 's/^.*\[\[URL\]\]//p' |
    xargs -I {} firefox --new-tab {}
