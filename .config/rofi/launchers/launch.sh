#!/usr/bin/env bash

theme="default"
dir="$HOME/.config/rofi/launchers"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
# rofi -no-lazy-grab \
#     -show drun \
#     -modi drun \
#     -disable-history \
#     -drun-display-format "{name} {generic} {exec} {categories} {keywords}" \
#     -drun-match-fields name\
#     -sort

