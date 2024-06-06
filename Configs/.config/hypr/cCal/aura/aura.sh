#! /bin/bash
# ekah, cCal

menu=$(printf "Select_color\nBacklight_style\n BACK" | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/MAIN/Main.rasi"')

case "$menu" in
 "Select_color") python3 ~/.config/hypr/cCal/aura/aura_work.py;;
 "Backlight_style") ./.config/hypr/cCal/aura/back.sh;;
 " BACK") ./.config/hypr/cCal/cCal.sh;;
esac
  