#! /bin/bash
# ekah, cCal

menu=$(printf 'static\nbreathe\nstrobe\npulse\n change_color\n\n\n EXIT' | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/MAIN/Main.rasi"')

col=$("F4ACD1")

case "$menu" in
 'static') asusctl led-mode static -c $col;;
 'breathe') asusctl led-mode breathe -c F4ACD1;;
 'strobe') asusctl led-mode strobe;;
 'pulse') asusctl led-mode pulse -c $col;;
 " change_color") kitty python ~/.config/hypr/cCal/aura/color.py > ~/.config/hypr/cCal/aura/color.txt
 " EXIT") exit 1;;
esac
  