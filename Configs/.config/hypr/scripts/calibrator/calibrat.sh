#!/bin/bash
white='\033[7m'   
clear='\033[m'

center_text() {
    text="$1"
    width=$(tput cols)
    padding=$(( (width - ${#text}) / 2 ))
    printf "${white} %${padding}s%s%${padding}s\n${clear}" "" "$text"
}

line_sweep(){
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

line_sweep && echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░   ░░░░░░░░░░░░░░░   ░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
▒▒   ▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒  ▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒   ▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒▒▒  ▒    ▒▒▒▒   ▒▒▒▒▒    ▒  ▒▒▒▒   ▒▒▒▒▒  ▒    ▒▒▒▒▒▒▒▒▒▒
▓   ▓▓▓▓▓▓▓▓▓   ▓▓   ▓▓   ▓   ▓   ▓   ▓▓▓▓   ▓▓▓▓▓   ▓▓   ▓▓▓▓   ▓▓▓▓   ▓▓   ▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓▓▓
▓   ▓▓▓▓▓▓▓▓   ▓▓▓   ▓▓   ▓   ▓   ▓▓▓   ▓▓   ▓▓▓▓   ▓▓▓   ▓▓▓▓   ▓▓▓   ▓▓▓▓   ▓▓   ▓▓▓▓▓▓▓▓▓▓▓▓▓
▓▓   ▓▓▓   ▓   ▓▓▓   ▓▓   ▓   ▓   ▓▓▓   ▓▓   ▓▓▓▓   ▓▓▓   ▓▓▓▓   ▓ ▓▓   ▓▓   ▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓▓▓
████     █████   █    █   █   █   █   ███    ██████   █    ████   █████   █████    ████  ███████
████████████████████████████████████████████████████████████████████████████████████████████████ " |  pv -qL 500 && sleep 1s && line_sweep

mon=$(python3 ~/.config/hypr/scripts/calibrator/calibrator.py 1)
center_text "Calibrating cynageOS for your computer"
printf "Monitor resolution detected: %s\n\n" "$mon" | pv -qL 80
printf "DO YOU WANT TO CHNAGE IT? (y/n) " | pv -qL 60 
read inp
case $inp in
    y) printf "Please type in the Resolution and the refresh rate in the above format :\n"
       read mon ;;
    n) printf "continuing..\n" ;;
    *) echo "invalid input" ;;
esac

sed -i 's/^monitor = eDP-1, 1920x1080@144, 0x0, 1/monitor = eDP-1, '"$mon"', 0x0, 1/g' ~/.config/hypr/hyprland.conf

printf "\nMONITOR CALIBRATED!!\n\n" | pv -qL 60
printf "If there is any issue please head on to ~/Settings/hypr/hyprland.conf" && sleep 5s && line_sweep

center_text "configuring calib key"

printf "\nThe calib key is configured to the armoury crate key in asus TUF and ROG laptops and keyboard \nDo you have the armoury crate key on your keyboard (YES/NO)\n\n"
read inp
case $inp in
    YES) printf "continuing..\n" ;;
    NO) printf "\nCalib will be using the 'menu' key\n"
        sed -i 's/^$aura = XF86Launch3/$aura = menu/g' ~/.config/hypr/keybindings.conf ;;
    *) echo "invalid input" ;; 
esac

sleep 1s && line_sweep

printf "Calibration completed!! \nTESTING THEME ENGINE"

sleep 2s 
line_sweep
line_sweep


~/.config/hypr/scripts/calibrator.sh && pkill kitty 



