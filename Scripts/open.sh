#!/usr/bin/env bash

## opening files
open(){
    if [[ $1 == *.xlsx ]]
    then
        GTK_THEME=Adwaita:light libreoffice --calc "$1" &
    elif [[ $1 == *.docx ]]
    then
        GTK_THEME=Adwaita:light libreoffice --writer "$1" &
	elif [[ $1 == *.tex ]]
	then
		kile "$1" &; disown
	fi
	
}
