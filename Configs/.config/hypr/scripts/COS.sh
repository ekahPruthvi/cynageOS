#! /bin/sh

ok=$(printf "CynageOS MENU\nSettings\nTerminal\nAbout COS" | rofi -dmenu -i -theme-str '@import "pwr.rasi"')

case "$ok" in
	"Settings") ;;
	"Terminal") kitty ;;
	"About COS") kitty nvim /home/ekah/Settings/hypr/scripts/About.txt ;;
	*) exit 1 ;;
esac
