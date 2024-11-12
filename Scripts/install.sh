#!/bin/bash
#|---/ /+--------------------------+---/ /|#
#|--/ /-| Main installation script |--/ /-|#
#|-/ /--| @ekah cynageOS           |-/ /--|#
#|/ /---+--------------------------+/ /---|#

white='\033[7m'   
clear='\033[m'

center_text() {
    text="$1"
    width=$(tput cols)
    padding=$(( (width - ${#text}) / 2 ))
    endpad=$((( (width - ${#text}) / 2 )-1))
    printf "${white} %${padding}s%s%${endpad}s\n${clear}" "" "$text"
}

clear

center_text " "
center_text "░█▀▄░█░░█░█▀▀▄░█▀▀▄░█▀▀▀░█▀▀░▒█▀▀▀█░▒█▀▀▀█             "
center_text "░█░░░█▄▄█░█░▒█░█▄▄█░█░▀▄░█▀▀░▒█░░▒█░░▀▀▀▄▄ INSTALLATION"
center_text "░▀▀▀░▄▄▄▀░▀░░▀░▀░░▀░▀▀▀▀░▀▀▀░▒█▄▄▄█░▒█▄▄▄█             "
center_text " "

cat << "EOF"

cynageOS installer will install your customized hyprland WM (cynageOS)
Estimated TIME: 1:40:00
Toxify --> Radiate --> Ionize
It will automatically Start SDDM. PLEASE RESTART AFTER THAT

EOF

#------------------#
# clear all errors #
#------------------#
source error.sh
if [ $? -ne 0 ] ; then
    echo "Error: unable to source error.sh, please execute manually"
    exit 1
fi

#--------------------------------#
# import variables and functions #
#--------------------------------#
source global_fn.sh
if [ $? -ne 0 ] ; then
    echo "Error: unable to source global_fn.sh, please execute from $(dirname $(realpath $0))..."
    exit 1
fi


#------------------#
# evaluate options #
#------------------#
flg_Install=0
flg_Restore=0
flg_Service=0

while getopts idrs RunStep
do
    case $RunStep in
    i) flg_Install=1 ;;
    d) flg_Install=1
        export use_default="--noconfirm" ;;
    r) flg_Restore=1 ;;
    s) flg_Service=1 ;;
    *)  echo "...valid options are..."
        echo "i : [i]nstall hyprland without configs"
        echo "r : [r]estore config files"
        echo "s : start system [s]ervices"   
        exit 1 ;;
    esac
done

if [ $OPTIND -eq 1 ] ; then
    flg_Install=1
    flg_Restore=1
    flg_Service=1
fi


#------------#
# installing #
#------------#
if [ $flg_Install -eq 1 ] ; then
cat << "EOF"

▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
█▄▄░▄▄██░▄▄▄░█▄▀█▀▄█▄░▄██░▄▄▄█▄░▄██░▀██░██░▄▄░██
███░████░███░███░████░███░▄▄███░███░█░█░██░█▀▀██
███░████░▀▀▀░█▀▄█▄▀█▀░▀██░████▀░▀██░██▄░██░▀▀▄██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀

EOF

    #----------------------#
    # prepare package list #
    #----------------------#
    shift $((OPTIND -1))
    cust_pkg=$1
    cp custom_hypr.lst install_pkg.lst

    if [ -f "$cust_pkg" ] && [ ! -z "$cust_pkg" ] ; then
        cat $cust_pkg >> install_pkg.lst
    fi

    #--------------------------------#
    # add nvidia drivers to the list #
    #--------------------------------#
    if nvidia_detect ; then

        cat /usr/lib/modules/*/pkgbase | while read krnl
        do
            echo "${krnl}-headers" >> install_pkg.lst
        done

        echo -e "nvidia-open\nnvidia-utils" >> install_pkg.lst

    else
        echo "nvidia card not detected, skipping nvidia drivers..."
    fi

    #--------------------------------#
    # install packages from the list #
    #--------------------------------#
    ./install_pkg.sh install_pkg.lst
    rm install_pkg.lst
fi


#---------------------------#
# restore my custom configs #
#---------------------------#
if [ $flg_Restore -eq 1 ] ; then
cat << "EOF"

▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██░▄▄▀█░▄▄▀██░▄▄▀█▄░▄█░▄▄▀█▄▄░▄▄█▄░▄██░▀██░██░▄▄░██
██░▀▀▄█░▀▀░██░██░██░██░▀▀░███░████░███░█░█░██░█▀▀██
██░██░█░██░██░▀▀░█▀░▀█░██░███░███▀░▀██░██▄░██░▀▀▄██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀

EOF

    ./restore_fnt.sh
    ./restore_cfg.sh
fi


#---------------------------#
# update sddm, grub and zsh #
#---------------------------#
if [ $flg_Install -eq 1 ] && [ $flg_Restore -eq 1 ] ; then
    ./restore_sgz.sh
fi


#------------------------#
# enable system services #
#------------------------#
if [ $flg_Service -eq 1 ] ; then
cat << "EOF"

▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
█▄░▄██░▄▄▄░██░▀██░█▄░▄██░▄▄▄░█▄░▄██░▀██░██░▄▄░██
██░███░███░██░█░█░██░███▀▀▀▄▄██░███░█░█░██░█▀▀██
█▀░▀██░▀▀▀░██░██▄░█▀░▀██░▀▀▀░█▀░▀██░██▄░██░▀▀▄██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀


EOF

center_text " "
center_text "REMINDER: RESTART after loginscreen appears"
center_text " "

    ln -s ~/.config ~/Settings
    service_ctl NetworkManager
    service_ctl bluetooth
    sudo systemctl enable --now swayosd-libinput-backend.service
    service_ctl sddm
    
fi

