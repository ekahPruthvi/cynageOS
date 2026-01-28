#!/bin/bash

previous_state="windows: 0"

while true; do
    current_state="$(hyprctl activeworkspace | grep windows | sed -e 's/^[ \t]*//')"
    
    if [[ "$current_state" != "$previous_state" ]]; then
        if [[ "$current_state" = "windows: 0" ]]; then
            swww img /home/ekah/Settings/swww/wall.png
        else
            swww img /home/ekah/Settings/swww/wall.blur 
        fi
        previous_state="$current_state"
    fi
    sleep 2
done