#!/bin/bash
# ekah, CCal

menu=$(printf "Default_clock\nTop_clock\nMARK\nUNSCAR\n BACK" | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/MAIN/Main.rasi"')

case "$menu" in
 "Default_clock") sed -i '2d;'  ~/.config/hypr/scripts/scar/scar.sh && sed -i '2iflag=1'  ~/.config/hypr/scripts/scar/scar.sh && ./.config/hypr/scripts/scar/scar.sh ;;
 "UNSCAR") sed -i '2d;'  ~/.config/hypr/scripts/scar/scar.sh && sed -i '2iflag=0'  ~/.config/hypr/scripts/scar/scar.sh && ./.config/hypr/scripts/scar/scar.sh;;
 "Top_clock") sed -i '2d;'  ~/.config/hypr/scripts/scar/scar.sh && sed -i '2iflag=3'  ~/.config/hypr/scripts/scar/scar.sh && ./.config/hypr/scripts/scar/scar.sh ;;
 "MARK") sed -i '2d;'  ~/.config/hypr/scripts/scar/scar.sh && sed -i '2iflag=2'  ~/.config/hypr/scripts/scar/scar.sh && ./.config/hypr/scripts/scar/scar.sh ;;
 " BACK") ~/.config/hypr/cCal/calib/calib.sh;;
esac