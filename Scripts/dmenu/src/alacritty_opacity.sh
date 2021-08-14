#!/bin/bash

Str=$(grep -i ^background_opacity ~/.config/alacritty/alacritty.yml)
echo "$Str"
Str=${Str:20:5}
echo "$Str"

case $1 in
"-dec")
    echo "Increasing opacity"
    num=$(awk "BEGIN {print $Str-0.1; exit}")
    if (($(echo "$num < 0" | bc -l))); then
        num=0.0
    fi
    ;;
"-inc")
    num=$(awk "BEGIN {print $Str+0.10; exit}")
    if (($(echo "$num > 1" | bc -l))); then
        num=1.0
    fi
    ;;
*)
    echo "wrong option"
    ;;
esac

echo $num #debug

sed -i "/^background_opacity:.*/c\background_opacity: $num" ~/.config/alacritty/alacritty.yml
touch ~/.config/alacritty/alacritty.yml
