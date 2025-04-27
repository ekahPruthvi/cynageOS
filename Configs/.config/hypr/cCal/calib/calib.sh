#!/bin/bash
# ekah, CCal

menu=$(printf "Compositor_Settings\nToggle_Panel\nWindow_rules\nTheme_Settings\nscar_settings\n BACK" | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/MAIN/Main.rasi"')

case "$menu" in
 "Compositor_Settings") kitty vim ~/.config/hypr/hyprland.conf;;
 "Toggle_Panel") pkill waybar && sed -i 's/^exec-once=waybar/#exec-once=waybar/' ~/.config/hypr/hyprland.conf || (waybar & sed -i 's/^#exec-once=waybar/exec-once=waybar/' ~/.config/hypr/hyprland.conf);;
 "Window_rules") kitty vim ~/.config/hypr/windowrules.conf;;
 "Theme_Settings") kitty vim ~/.config/hypr/themes/theme.conf;;
 "scar_settings") ./.config/hypr/cCal/calib/scar_settings.sh ;;
 " BACK") ./.config/hypr/cCal/cCal.sh;;
esac