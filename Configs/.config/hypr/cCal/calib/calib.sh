#!/bin/bash
# ekah, CCal

menu=$(printf "Compositor_Settings\nWindow_rules\nTheme_Settings\nWaybar_color_Dark\nWaybar_color_Light\nWaybar_Blur_Enable\nWaybar_Blur_Disable\n BACK" | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/calib/calib.rasi"')

case "$menu" in
 "Compositor_Settings") kitty nvim ~/.config/hypr/hyprland.conf;;
 "Window_rules") kitty nvim ~/.config/hypr/windowrules.conf;;
 "Theme_Settings") kitty nvim ~/.config/hypr/themes/theme.conf;;
 "Waybar_color_Dark") sed -i '117d;'  ~/.config/waybar/style.css && sed -i '117icolor: @main-fg;'  ~/.config/waybar/style.css && killall waybar && waybar;;
 "Waybar_color_Light") sed -i '117d;'  ~/.config/waybar/style.css && sed -i '117icolor: @main-bg;'  ~/.config/waybar/style.css && killall waybar && waybar;;
 "Waybar_Blur_Disable") sed -i '61d;' ~/.config/hypr/themes/theme.conf && sed -i '61i#blurls = waybar ' ~/.config/hypr/themes/theme.conf && killall waybar && waybar;;
 "Waybar_Blur_Enable") sed -i '61d;' ~/.config/hypr/themes/theme.conf && sed -i '61iblurls = waybar ' ~/.config/hypr/themes/theme.conf && killall waybar && waybar;;
 " BACK") ./.config/hypr/cCal/cCal.sh;;
esac