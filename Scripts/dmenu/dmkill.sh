#!/bin/bash
#
# Description: Search for a process to kill.
# Dependencies: dmenu

selected="$(ps --user "$(id -u)" -F |
  dmenu -i -l 20 -p "Search for process to kill:" |
  awk '{print $2" "$11}')"

if [[ -n $selected ]]; then

  answer="$(echo -e "No\nYes" | dmenu -i -p "Kill $selected?")"

  if [[ $answer == "Yes" ]]; then
    selpid="$(awk '{print $1}' <<<$selected)"
    kill -9 "$selpid"
    echo "Process $selected has been killed." && exit 1
  fi

  if [[ $answer == "No" ]]; then
    echo "Program terminated." && exit 1
  fi
fi

exit 0
