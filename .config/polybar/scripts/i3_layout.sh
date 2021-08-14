#!/usr/bin/env bash

LAYOUT=$(i3-msg -t get_tree | jq -r 'recurse(.nodes[];.nodes!=null)|select(.nodes[].focused).layout')

SPLITH=" SplitH"
SPLITV=" SplitV"
STACKED=" Stack"
TAB=" Tab"
FLOAT=" Float"


case "$LAYOUT" in
    "splith")
        echo $SPLITH
    ;;
    "splitv")
        echo $SPLITV
    ;;
    "stacked")
        echo $STACKED
    ;;
    "tabbed")
        echo $TAB
    ;;
    *)
        echo $FLOAT
    ;;
esac