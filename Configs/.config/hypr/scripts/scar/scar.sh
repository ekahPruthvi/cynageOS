#!/bin/bash
flag=1
if pgrep -x nwg-wrapper > /dev/null; then
  echo "Process '$process_name' is running. Killing it..."
  pkill -x nwg-wrapper
else
  echo "Process '$process_name' is not running."
fi
case "$flag" in
    0) pkill nwg-wrapper && notify-send "UnScared" ;;
    1) nwg-wrapper -s ~/Settings/hypr/scripts/scar/clock/time.sh -c ~/Settings/hypr/scripts/scar/clock/time.css -r 100 -p center & nwg-wrapper -s ~/Settings/hypr/scripts/scar/battery.sh -c ~/Settings/hypr/scripts/scar/clock/battery.css -r 100 -p center -a end ;;
    2) nwg-wrapper -t ~/Settings/hypr/scripts/scar/mark/mark.txt -c ~/Settings/hypr/scripts/scar/mark/mark.css -r 100 -p center -a end & nwg-wrapper -s ~/Settings/hypr/scripts/scar/battery.sh -c ~/Settings/hypr/scripts/scar/clock/battery.css -r 100 -p center -a end;;
    3) nwg-wrapper -s ~/Settings/hypr/scripts/scar/vclock/time.sh -c ~/Settings/hypr/scripts/scar/vclock/time.css -r 100 -p center -a start -mb 30 & nwg-wrapper -s ~/Settings/hypr/scripts/scar/vclock/date.sh -c ~/Settings/hypr/scripts/scar/vclock/date.css -r 500 -p center -a start & nwg-wrapper -s ~/Settings/hypr/scripts/scar/battery.sh -c ~/Settings/hypr/scripts/scar/clock/battery.css -r 100 -p center -a end ;;
esac