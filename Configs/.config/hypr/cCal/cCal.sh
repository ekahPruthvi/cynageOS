#! /bin/bash
# ekah, cCal

menu=$(printf " Calibration_Settings\n Keybindings\n Aura\n Bluetooth\n Audio\n DeTox\nDeadlineDoomsday\nRunning_Processes\n EXIT" | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/MAIN/Main.rasi"')

case "$menu" in
 " Calibration_Settings") ~/.config/hypr/cCal/calib/calib.sh;;
 " Keybindings") cat ~/.config/hypr/cCal/keybindings/key.txt | rofi -dmenu -p -theme-str '@import "~/.config/hypr/cCal/keybindings/key.rasi"';;
 " Aura") ~/.config/hypr/cCal/aura/aura.sh;;
 " Bluetooth") blueman-manager;;
 " Audio") pavucontrol ;;
 " DeTox") kitty ~/.config/hypr/cCal/DeTox.sh ;;
 "DeadlineDoomsday") ~/.config/hypr/scripts/ddmd.sh && killall waybar && waybar;;
 "Running_Processes") ps -e | rofi -dmenu -i -theme-str '@import "~/.config/hypr/cCal/MAIN/Main.rasi"' ;;
 " EXIT") exit 1;;
esac
  