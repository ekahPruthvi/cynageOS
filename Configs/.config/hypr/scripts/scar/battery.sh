#!/bin/bash
wire=$(nmcli device status | grep Wired)
if [ -n "$wire" ]; then
    printf "Wired Connection"
else
    state=$(nmcli -fields WIFI g)
    test=$(echo "$state" | grep "enabled")
    if [ $test = "enabled" ]; then
        net=$(nmcli -t -f active,SSID device wifi | awk -F: '/^yes:/ {print $2}')
        if [[ -z $net ]]; then
            printf "No Connection"
        else
            printf "󱘖 Network Enabled - $net "
        fi
    else
        printf " Network Disabled "
    fi
fi

printf "     "

bat=$(cat /sys/class/power_supply/BAT1/capacity)
if [[ $bat -le 20 ]]; then
   printf "󰁻 $bat%% "
elif [[ $bat -le 40 ]]; then
   printf "󰁾 $bat%% "
elif [[ $bat -le 60 ]]; then
    printf "󰂀 $bat%% "
elif [[ $bat -ge 60 ]]; then
    printf "󰁹 $bat%% "
fi

charge=$(cat /sys/class/power_supply/BAT1/status)
if [ $charge = "Charging" ]; then
    printf "  "
fi