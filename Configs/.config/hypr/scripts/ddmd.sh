#! /bin/sh
# ekah, HellO.sh

ok=$(printf "Mon\nTue\nWed\nThur\nFri\nSat\nSun" | rofi -dmenu -i -theme-str '@import "ddmd.rasi"')

case "$ok" in
	"Mon") kitty nvim ~/.config/hypr/scripts/Deadline_Doomsday/Monday.txt;;
	"Tue") kitty nvim ~/.config/hypr/scripts/Deadline_Doomsday/Tuesday.txt ;;
	"Wed") kitty nvim ~/.config/hypr/scripts/Deadline_Doomsday/Wednesday.txt ;;
	"Thur") kitty nvim ~/.config/hypr/scripts/Deadline_Doomsday/Thursday.txt ;;
  "Fri") kitty nvim ~/.config/hypr/scripts/Deadline_Doomsday/Friday.txt ;;
  "Sat") kitty nvim ~/.config/hypr/scripts/Deadline_Doomsday/Saturday.txt ;;
  "Sun") kitty nvim ~/.config/hypr/scripts/Deadline_Doomsday/Sunday.txt ;;
  *) exit 1 ;;
esac
