#!/bin/bash
#
# Use: Used to edit the configurations files quickly
# Dependencies: dmenu

# configuration
dconf=$HOME/Scripts/dmenu/dconf
select_bg=$(awk '$1=="select_bg" {print $2}' "$dconf")
select_fg=$(awk '$1=="select_fg" {print $2}' "$dconf")

nselect_bg=$(awk '$1=="nselect_bg" {print $2}' "$dconf")
nselect_fg=$(awk '$1=="nselect_fg" {print $2}' "$dconf" )

font=$(grep "font " "$dconf" | cut -d' ' -f 2-)
font_size=$(awk '$1=="font_size" {print $2}' "$dconf")

font_size="16"

# Defining the text editor to use.
# DMENUEDITOR="st -e vim"
# DMENUEDITOR="st -e nvim"
# DMEDITOR="emacsclient -c -a emacs"
DMEDITOR="code"

# function to check if an element is inside an array
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

# An array of options to choose.
# You can edit this list to add/remove config files.

# "quickmarks - $HOME/.config/qutebrowser/quickmarks"
# "qutebrowser - $HOME/.config/qutebrowser/autoconfig.yml"
# "termite - $HOME/.config/termite/config"
# "sxhkd - $HOME/.config/sxhkd/sxhkdrc"
# "vifm - $HOME/.config/vifm/vifmrc"

# "herbstluftwm - $HOME/.config/herbstluftwm/autostart"
# "spectrwm - $HOME/.spectrwm.conf"
# "awesome - $HOME/.config/awesome/rc.lua"
# "stumpwm - $HOME/.config/stumpwm/config"
# "xmobar mon1  - $HOME/.config/xmobar/xmobarrc0"
# "xmonad - $HOME/.xmonad/README.org"

declare -a options=(
"alacritty - $HOME/.config/alacritty/alacritty.yml"
"bash - $HOME/.bashrc"
"bspwm - $HOME/.config/bspwm"
"cava - $HOME/.config/cava/config"
"compton - $HOME/.config/compton.conf"
"dunst - $HOME/.config/dunst/dunstrc"
"i3 - $HOME/.config/i3/config"
"neovim - $HOME/.config/nvim"
"openbox - $HOME/.config/openbox"
"pallete - $HOME/Scripts/dmenu/src/palette"
"picom - $HOME/.config/picom/picom.conf"
"polybar - $HOME/.config/polybar"
"qtile - $HOME/.config/qtile"
"rofi - $HOME/.config/rofi"
"vim - $HOME/.vimrc"
"xava - $HOME/.config/xava/config"
"xresources - $HOME/.Xresources"
"zathura - $HOME/.config/zathura/zathurarc"
"zsh - $HOME/.zshrc"
)

# Piping the above array into dmenu.
# We use "printf '%s\n'" to format the array one item to a line.

choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 20 -nb "$nselect_bg" -nf "$nselect_fg" -sb "$select_bg" -sf "$select_fg" -fn "$font"-"$font_size" -p '  ')

# check if choice is in list if not exit
containsElement "$choice" "${options[@]}"
res=$?
if [ $res == 1 ]; then
    exit
fi

# now open the choice with the editor
if [ "$choice" ]; then
	cfg=$(printf '%s\n' "${choice}" | awk '{print $NF}')
	$DMEDITOR "$cfg"
else
    echo "Program terminated." && exit 1
fi
