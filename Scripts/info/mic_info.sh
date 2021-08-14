#!/bin/bash
# Get active audio source index
CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -f3 -d" ")

# List lines in pactl after the source name match and pick mute status

OUT=$(pactl list sources | grep -A 10 "$CURRENT_SOURCE")
CHECK="Mute: yes"

if [[ "$OUT" == *"$CHECK"* ]]; then
	echo "MUTE"
else
	echo "NOT MUTE"
fi
