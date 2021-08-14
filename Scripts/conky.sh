#!/bin/bash

if pgrep -x conky >/dev/null; then
    i3-msg [class="Conky"] scratchpad show
else 
    conky -c ~/.config/conky/tc100.lua
fi