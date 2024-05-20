#!/bin/bash
# ekah, CCal

menu=$(printf "Compositor_Settings\nWindow_rules\nTheme_Settings\nWaybar_color_Transperent\nWaybar_color_Black\nWaybar_Blur_Enable\nWaybar_Blur_Disable\n BACK" | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/calib/calib.rasi"')

case "$menu" in
 "Compositor_Settings") kitty nvim ~/.config/hypr/hyprland.conf;;
 "Window_rules") kitty nvim ~/.config/hypr/windowrules.conf;;
 "Theme_Settings") kitty nvim ~/.config/hypr/themes/theme.conf;;
 "Waybar_color_Transperent") sed -i '13d;'  ~/.config/waybar/style.css && sed -i '13ibackground: @bar-bg;'  ~/.config/waybar/style.css && killall waybar && waybar;;
 "Waybar_color_Black") sed -i '13d;'  ~/.config/waybar/style.css && sed -i '13ibackground: #000000;'  ~/.config/waybar/style.css && killall waybar && waybar;;
 "Waybar_Blur_Disable") sed -i 's/^blurls=waybar/#blurls=waybar/g' ~/.config/hypr/themes/theme.conf && killall waybar && waybar;;
 "Waybar_Blur_Enable") sed -i 's/^#blurls=waybar/blurls=waybar/g' ~/.config/hypr/themes/theme.conf && killall waybar && waybar;;
 " BACK") ./.config/hypr/cCal/cCal.sh;;
esac