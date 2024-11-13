#!/bin/bash

white='\033[7m'   
clear='\033[m'
underline='\e[4m'

Head_text() {
    text="$1"
    width=$(tput cols)
    padding=$(( (width - ${#text}) / 2 ))
    endpad=$((( (width - ${#text}) / 2 )-1))
    printf "${white} %${padding}s%s%${endpad}s\n${clear}" "" "$text"
}

center_text() {
    text="$1"
    width=$(tput cols)
    padding=$(( (width - ${#text}) / 2 ))
    printf "%${padding}s%s%${padding}s\n" "" "$text"
}

wh_line_sweep(){
    sleep 0.01
    [[ $LINES ]] || LINES=$(tput lines)
    [[ $COLUMNS ]] || COLUMNS=$(tput cols)
    tput civis
    for (( i=0; i<$LINES; i++ ))
    do
    clear
    if [ $i -gt 0 ]
    then
    n=$(($i-1))
    eval printf "$'\n%.0s'" {0..$n}
    fi
    eval printf %.1s '$((RANDOM & 1))'{1..$COLUMNS}
    sleep 0.01
    done
    clear
    tput cnorm
}

wh_line_sweep

Head_text "WELCOME TO                                "
Head_text "░█▀▄░█░░█░█▀▀▄░█▀▀▄░█▀▀▀░█▀▀░▒█▀▀▀█░▒█▀▀▀█"
Head_text "░█░░░█▄▄█░█░▒█░█▄▄█░█░▀▄░█▀▀░▒█░░▒█░░▀▀▀▄▄"
Head_text "░▀▀▀░▄▄▄▀░▀░░▀░▀░░▀░▀▀▀▀░▀▀▀░▒█▄▄▄█░▒█▄▄▄█"
Head_text ""

printf "\nif the text font is very small,\n[ctrl] + [Shift] + [+]\n"

printf "\n${underline}BASIC USAGE${clear}\n"

cat << "EOF" 

 ⤺  cynbar is a preconfigured waybar for cynageOS

 - Power button
 - Clipboard (Rightclick for deleting the items and middleclick for clearing the clipboard)
 - Terminal (Middleclick to kill all existing terminals)
 - QuickNotes

--bottom--

 , 󰤨 , 󱘖  - Network

󰂎 - Laptop battery
 - Audio (Middleclick to mute and scroll to change volume)
 - Notifications
 - Mic (Middleclick to mute and scroll to chnage volume) 

USE the AURA key for settings (calib) [Menu or ArmouryCrate]

move floating applications using [MOD]+rightclick_drag,

EOF

sed -i '43d;'  ~/.config/hypr/hyprland.conf 
sed -i 's/^#exec-once2/exec-once/g' ~/.config/hypr/hyprland.conf

sleep 10s && ~/.config/hypr/keyframe/cheatsheet.sh 
