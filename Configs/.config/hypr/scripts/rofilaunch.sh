#!/usr/bin/env sh

theme_file="$HOME/.config/hypr/themes/theme.conf"
rofi_conf="~/.config/rofi/config.rasi"


# rofi action

case $1 in
    d)  r_mode="drun" ;; 
    w)  r_mode="window" ;;
    f)  r_mode="filebrowser" ;;
    h)  echo -e "rofilaunch.sh [action]\nwhere action,"
        echo "d :  drun mode"
        echo "w :  window mode"
        echo "f :  filebrowser mode,"
        exit 0 ;;
    *)  r_mode="drun" ;;
esac


# read hypr theme border

hypr_border=`awk -F '=' '{if($1~" rounding ") print $2}' $theme_file | sed 's/ //g'`
hypr_width=0
wind_border=$(( hypr_border * 1 ))
elem_border=`[ $hypr_border -eq 0 ] && echo "10" || echo $(( hypr_border * 2 ))`
r_override="element {border-radius: ${elem_border}px;}"


# read hypr font size

#fnt_size=`awk '{if($6=="font-name") print $NF}' $theme_file | sed "s/'//g"`
fnt_override=`gsettings get org.gnome.desktop.interface font-name | awk '{gsub(/'\''/,""); print $NF}'`
fnt_override="configuration {font: \"JetBrainsMono Nerd Font ${fnt_override}\";}"


# read hypr theme icon

icon_override=`gsettings get org.gnome.desktop.interface icon-theme | sed "s/'//g"`
icon_override="configuration {icon-theme: \"${icon_override}\";}"


# launch rofi

rofi -show $r_mode -theme-str "${fnt_override}" -theme-str "${r_override}" -theme-str "${icon_override}" -config "${rofi_conf}"


