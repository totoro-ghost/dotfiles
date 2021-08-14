#!/bin/bash
#
# Use: Search various search engines.
# Dependencies: dmenu and a web browser

# configuration
dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf")

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")
font_size=14

# Defining our web browser.
DMBROWSER="firefox"

# An array of search engines.  You can edit this list to add/remove
# search engines. The format must be: "engine_name - url".
# The url format must allow for the search keywords at the end of the url.
# For example: https://www.amazon.com/s?k=XXXX searches Amazon for 'XXXX'.

declare -a options=(
"amazon - https://www.amazon.com/s?k="
"archwiki - https://wiki.archlinux.org/index.php?search="
"bbcnews - https://www.bbc.co.uk/search?q="
"duckduckgo - https://duckduckgo.com/?q="
"ebay - https://www.ebay.com/sch/i.html?&_nkw="
"github - https://github.com/search?q="
"gitlab - https://gitlab.com/search?search="
"google - https://www.google.com/search?q="
"googleimages - https://www.google.com/search?hl=en&tbm=isch&q="
"imdb - https://www.imdb.com/find?q="
"reddit - https://www.reddit.com/search/?q="
"stack - https://stackoverflow.com/search?q="
"translate - https://translate.google.com/?sl=auto&tl=en&text="
"wiby - https://wiby.me/?q="
"wikipedia - https://en.wikipedia.org/wiki/"
"wiktionary - https://en.wiktionary.org/wiki/"
"youtube - https://www.youtube.com/results?search_query="
"quit"
)

options1=()
for i in "${options[@]}"
do
    options1+=("$(echo "$i"| awk '{print $1}')")
done

# function to check if an element is inside an array
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

# Picking a search engine.
enginelist=$(printf '%s\n' "${options[@]}" | dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p 'Choose search engine:') || exit
engineurl=$(echo "$enginelist" | awk '{print $NF}')
engine=$(echo "$enginelist" | awk '{print $1}')

echo "$engine $engineurl" 
echo "${options1[@]}"

containsElement "$engine" "${options1[@]}"
res=$?

if [[ $res == "1" ]]; then
    # default choice if element is not in the list use google to search it 
    # or you can set it to exit 
    firefox "https://www.google.com/search?q=$enginelist"
else
    # else ask for what you want to search
    query=$(echo "Enter keyword to search." | dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p "Searching $engine:") || exit
    $DMBROWSER "$engineurl""$query"
fi 
