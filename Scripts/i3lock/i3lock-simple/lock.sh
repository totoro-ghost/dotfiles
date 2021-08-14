#!/usr/bin/env bash

#---------------
# i3lock-color
#---------------

# colors used

B='#00000000' # center background
C='#ffffff22' # center background verif
T='#5E81ACff' # center text
D='#88C0D0ff' # default ring
I='#5E81ACff' # indicator
W='#EBCB8Bff' # wrong ring + indicator
V='#88C0D0ff' # verif ring

#----------------
# how to change fonts
# --{time, date, layout, verif, wrong, greeter}-font=sans-serif
#----------------

notify-send "DUNST_COMMAND_PAUSE"

# font to use
# FONT="VictorMono Nerd Font"
# FONT="monofur"
FONT="Iosevka Nerd Font"

i3lock \
    -c 2E3440 \
    --insidevercolor=$C \
    --ringvercolor=$V \
    \
    --insidewrongcolor=$C \
    --ringwrongcolor=$W \
    \
    --ringcolor=$D \
    --linecolor=$T \
    --separatorcolor=$D \
    \
    --insidecolor=$B \
    --verifcolor=$T \
    --wrongcolor=$T \
    --timecolor=$T \
    --datecolor=$T \
    --layoutcolor=$T \
    --keyhlcolor=$I \
    --bshlcolor=$I \
    \
    --clock \
    --indicator \
    --timestr="%I:%M %p" \
    --datestr="%A, %m %Y" \
    \
    --veriftext="Verifying..." \
    --wrongtext="Nope!" \
    \
    --date-font="$FONT" \
    --time-font="$FONT" \
    --layout-font="$FONT" \
    --verif-font="$FONT" \
    --wrong-font="$FONT" \
    --greeter-font="$FONT" \
    \
    --datesize=30 \
    --timesize=40 \
    --layoutsize=40 \
    --verifsize=40--wrongsize=40 \
    --greetersize=40 \
    \
    --modsize=10 \
    --radius=200

notify-send "DUNST_COMMAND_RESUME"
sleep 1
exit
