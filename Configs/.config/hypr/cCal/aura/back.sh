#! /bin/bash
# ekah, cCal

menu=$(printf "Strobe\nBreathe\nPulse\nStatic\n BACK" | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/MAIN/Main.rasi"')

case "$menu" in
 "Strobe") asusctl led-mode strobe;;
 "Breathe") asusctl led-mode breathe;;
 "Pulse") asusctl led-mode pulse;;
 "Static") asusctl led-mode static;;
 " BACK") ./.config/hypr/cCal/aura/aura.sh;;
esac
  