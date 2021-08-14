#!/bin/bash

DIR="$HOME/.config/rofi/menu"

ANS=$("$DIR"/menu.sh | rofi -dmenu -theme "$DIR"/left)

# if [[ -n $ANS ]];then
    # notify-send "$ANS"
    # exit
# fi
# if [[ "$ANS" == "  Fortune" ]];then
#     i=$(fortune)
#     rofi -dmenu -theme "$DIR"/message -e "hidfds \n sdsdsd"
# fi