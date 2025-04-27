#!/bin/bash

######################################################################################
# ancientBasil is the backend UI toolkit for shell scripting[RETRO MODE]             #
# This file can be sourced and used for any shell script                             #
# CWRITE - ekahPruthvi                                                               #
######################################################################################

# Reset
clear='\033[0m\033[1;92m'       # Text Reset


# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[1;92m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
Pink='\033[0;95m'         # light Magenta

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
BPink='\033[1;95m'        # light Magenta

# Thin
TBlack='\033[2;30m'       # Black
TRed='\033[2;31m'         # Red
TGreen='\033[2;32m'       # Green
TYellow='\033[2;33m'      # Yellow
TBlue='\033[2;34m'        # Blue
TPurple='\033[2;35m'      # Purple
TCyan='\033[2;36m'        # Cyan
TWhite='\033[2;37m'       # White
TPink='\033[2;95m'        # light Magenta

# Italics
SBlack='\033[3;30m'       # Black
SRed='\033[3;31m'         # Red
SGreen='\033[1;92m'       # Green
SYellow='\033[3;33m'      # Yellow
SBlue='\033[3;34m'        # Blue
SPurple='\033[3;35m'      # Purple
SCyan='\033[3;36m'        # Cyan
SWhite='\033[3;37m'       # White
SPink='\033[3;95m'        # light Magenta


# Underline
UBlack='\033[1;92m'       # Black
URed='\033[1;92m'         # Red
UGreen='\033[1;92m'       # Green
UYellow='\033[1;92m'      # Yellow
UBlue='\033[1;92m'        # Blue
UPurple='\033[1;92m'      # Purple
UCyan='\033[1;92m'        # Cyan
UWhite='\033[1;92m'       # White
UPink='\033[1;92m'       # light Magenta

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[1;92m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[7m'        # White
On_Pink='\033[105m'       # light Magenta

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[1;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
BIPink='\033[1;95m'       # light Magenta 

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

# Default Variables 
bg="$On_White"
ul="$UBlack"

# This is the header
Head_text() {
    local htext="┌──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┐"
    local hwidth=$(tput cols)
    local hpadding=$(( (hwidth - ${#htext}) / 2 ))
    local hendpad=$((( (hwidth - ${#htext}) / 2 )-1))
    local varpad=$( shuf -i 3-37 -n 1 )
    printf "$BIGreen %${hpadding}s%${varpad}s⮟\n"
    printf "%${hpadding}s┌──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┐\n"
    printf "%${hpadding}s0     1     2     3     4     5     6     7\n"
}

# This is the footer
Foot(){
    local COL=$(tput cols)
    local ROW=$(tput lines)
    tput cup $(( ROW - 1 ))
    local ftext="$(date) "
    local fwidth=$(tput cols)
    local fpadding=$(( (fwidth - ${#ftext})-15))
    printf "$BIGreen %${fpadding}s%s$clear" "" "Press Enter | $ftext"
}

# Display the text in center
Center_text() {
    local ctext="$1"
    local cwidth=$(tput cols)
    local cpadding=$(( (cwidth - ${#ctext}) / 2 ))
    printf "%${cpadding}s%s \n" "" "$ctext"
}

# Animation and clear screen
Line_sweep(){
    clear
    local ROW=$(tput lines)
    local ctext="█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█"
    local cwidth=$(tput cols)
    local cpadding=$(( (cwidth - ${#ctext}) / 2 ))
    for ((i=0;i<1;i++)) do
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s\033[?25l█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.01
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s███████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s███████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀██████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄██████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀██████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄██████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀██████▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄██████▄▄▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀██████▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄██████▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀▀██████▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄██████▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀▀▀▀▀▀██████▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄▄▄▄▄██████▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀██████▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄██████▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀██████▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄██████▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀██████▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄██████▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀▀▀▀▀▀██████▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄▄▄▄▄██████▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀▀██████▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄██████▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀██████▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄██████▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀██████▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄██████▄▄▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀██████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄██████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀██████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄██████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█\n"
        sleep 0.09
        clear
        tput cup $(((ROW / 2)-2))
        printf "%${cpadding}s█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█\n"
        printf "%${cpadding}s█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█\033[?25h\n"
        clear
    done
}

# This is a form, and it is customizable changing colors and the underline
# To edit teh colors, pls chnage the color variables (bg and ul)
# The Form has a min padding threshold of 50 charecters

Form(){
    local lineno="$#"
    local max=50
    for i in "$@"
    do      
        local temp="$i"
        local wc=${#temp}
        if [ "$wc" -gt "$max" ]
        then
            max="$wc"
        fi
    done
    max=$(($max+5))
    local fwidth=$(tput cols)
    local fpadding=$(( (fwidth - ${max}) / 2 ))
    local fendpad=$((( (fwidth - ${max}) / 2 )-1))
    local finstartpadd=2
    local finendpadd=2
    local cont=0
    echo ""
    for i in "$@"
    do
        local end="║"
        if [ "$cont" -eq 0 ]
        then
            end="╗"
        fi
        cont=$(($cont+1))
        temp="$i"
        wc=${#temp}
        finendpadd=$(( ($max-$wc)-5 ))
        printf "%${fpadding}s$BIGreen %${finstartpadd}s %s%${finendpadd}s$clear" "" "$temp"
        echo "$end"
        local fline="╚"
        if [ "$cont" -eq "$lineno" ]
        then 
            printf "%${fpadding}s"
            for f in $(seq 1 "$((max - 2 ))" )
            do
                if [ "$f" -eq "$(( max - 2 ))" ]
                then
                    fline="╝"
                fi
                printf "$fline"
                fline="═"
            done
        fi
    done
}

Fillaform(){
    local lineno="$#"
    local max=50
    for i in "$@"
    do      
        local temp="$i"
        local wc=${#temp}
        if [ "$wc" -gt "$max" ]
        then
            max="$wc"
        fi
    done
    max=$(($max+5))
    local fwidth=$(tput cols)
    local fpadding=$(( (fwidth - ${max}) / 2 ))
    local fendpad=$((( (fwidth - ${max}) / 2 )-1))
    local cont=0
    echo ""
    echo ""
    for i in "$@"
    do
        local finstartpadd=2
        local finendpadd=2
        temp="$i"
        local end="║"
        if [ "$cont" -eq 0 ]
        then
            end="╗"
            
        fi
        cont=$(($cont+1))
        wc=${#temp}
        finendpadd=$(( ($max-$wc)-5 ))
        printf "%${fpadding}s$BIGreen %${finstartpadd}s %s%${finendpadd}s" "" "$temp"
        echo "$end"
        local fline="╚"
        if [ "$cont" -eq "$lineno" ]
        then 
            printf "%${fpadding}s"
            for f in $(seq 1 "$((max - 2 ))" )
            do
                if [ "$f" -eq "$(( max - 2 ))" ]
                then
                    fline="╝"
                fi
                printf "$fline"
                fline="═"
            done
        fi
    done
    printf "\n %${fpadding}s"
}

Links(){
    printf "${UBlue}"
    local placeholder='\e]8;;'${1}'\e\\'${2}'\e]8;;\e\\'
    echo -e $placeholder
    printf "${clear}"
}

Linspace(){
    local lines="$1"
    for line in $(seq 0 "$1")
    do
        echo ""
    done
}

printf "\033[?25l"

# ekahPruthvi - SCU
sleep 1s && Line_sweep
ROW=$(tput lines)
tput cup $((ROW / 3))
cat << EOL
    ██╗  ██╗███████╗██╗     ██╗      ██████╗     
    ██║  ██║██╔════╝██║     ██║     ██╔═══██╗              
    ███████║█████╗  ██║     ██║     ██║   ██║                                          
    ██╔══██║██╔══╝  ██║     ██║     ██║   ██║                                             
    ██║  ██║███████╗███████╗███████╗╚██████╔╝                                             
    ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝  
    ░▒█░▒█░▒█▀▀▀█░▒█▀▀▀░▒█▀▀▄░░░░░░█▀█
    ░▒█░▒█░░▀▀▀▄▄░▒█▀▀▀░▒█▄▄▀░░░▄▄░▒▄▀
    ░░▀▄▄▀░▒█▄▄▄█░▒█▄▄▄░▒█░▒█░░░▀▀░█▄▄




    "UNLIKE CITIZENS,
     A WINDOW MANAGER HAS RIGHTS BUT NO RESPONSIBLITIES"


    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
    █ ███ █ ▄▄█ ██▀▄▀█▀▄▄▀█ ▄▀▄ █ ▄▄███▄ ▄█▀▄▄▀███▀▄▀█ ██ █ ▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██ ▄▄▄ ██ ▄▄▄ █████
    █▄▀ ▀▄█ ▄▄█ ██ █▀█ ██ █ █▄█ █ ▄▄████ ██ ██ ███ █▀█ ▀▀ █ ██ █ ▀▀ █ █▄▀█ ▄▄██ ███ ██▄▄▄▀▀█▀▀██
    ██▄█▄██▄▄▄█▄▄██▄███▄▄██▄███▄█▄▄▄████▄███▄▄█████▄██▀▀▀▄█▄██▄█▄██▄█▄▄▄▄█▄▄▄██ ▀▀▀ ██ ▀▀▀ █▄▄██
    ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
EOL
printf "\033[?25l"
sleep 3 && pkill kitty

