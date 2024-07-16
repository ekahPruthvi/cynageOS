#! /bin/sh
# ekah, HellO.sh

ok=$(printf "Mon\nTue\nWed\nThur\nFri\nSat\nSun" | rofi -dmenu -i -theme-str '@import "ddmd.rasi"')

case "$ok" in
	"Mon") kitty vim ~/.config/hypr/scripts/Deadline_Doomsday/Monday.txt;;
	"Tue") kitty vim ~/.config/hypr/scripts/Deadline_Doomsday/Tuesday.txt ;;
	"Wed") kitty vim ~/.config/hypr/scripts/Deadline_Doomsday/Wednesday.txt ;;
	"Thur") kitty vim ~/.config/hypr/scripts/Deadline_Doomsday/Thursday.txt ;;
  "Fri") kitty vim ~/.config/hypr/scripts/Deadline_Doomsday/Friday.txt ;;
  "Sat") kitty vim ~/.config/hypr/scripts/Deadline_Doomsday/Saturday.txt ;;
  "Sun") kitty vim ~/.config/hypr/scripts/Deadline_Doomsday/Sunday.txt ;;
  *) exit 1 ;;
esac
