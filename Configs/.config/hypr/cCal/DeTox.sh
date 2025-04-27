#!/bin/bash

echo "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██░▄▄▀█░██░▄▄█░▄▄▀█░▄▄▀██▄██░▄▄▀█░▄▄▄████░███░█▀▄▄▀█░██░█░▄▄▀███▄░▄█░▄▄▀█░▄▄█▄░▄█░▄▄▀█░██░███
██░████░██░▄▄█░▀▀░█░██░██░▄█░██░█░█▄▀████▄▀▀▀▄█░██░█░██░█░▀▀▄████░██░██░█▄▄▀██░██░▀▀░█░██░███
██░▀▀▄█▄▄█▄▄▄█▄██▄█▄██▄█▄▄▄█▄██▄█▄▄▄▄██████░████▄▄███▄▄▄█▄█▄▄███▀░▀█▄██▄█▄▄▄██▄██▄██▄█▄▄█▄▄██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"

echo "Pacman and yay cache" | pv -qL 10 && sleep 2s
yay -Sc

echo "Do you want to clear cache completely including the most recent versions.
Use with caution as this will require redownloading all packages if you need them again. [y/n]" | pv -qL 40 && sleep 2s
read flag

if [ $flag = "y" ] || [ $flag = "Y" ]; then
    yay -Scc
else 
    continue
fi

echo "Removing Unused Packages" | pv -qL 10 && sleep 2s
sudo pacman -Qtdq    
sudo pacman -Rns $(pacman -Qtdq) 

echo "System cache"| pv -qL 10 && sleep 2s
sudo du -sh ~/.cache/ && rm -rf ~/.cache/*

echo "flatpak"| pv -qL 10 && sleep 2s
sudo rm -rfv /var/tmp/flatpak-cache-* &&  flatpak uninstall --unused   

echo "Systemd cache"| pv -qL 10 && sleep 2s
sudo journalctl --vacuum-size=50M

sleep 3s
