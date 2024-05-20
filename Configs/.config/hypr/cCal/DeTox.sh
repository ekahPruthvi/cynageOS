#!/bin/bash

echo "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██░▄▄▀█░██░▄▄█░▄▄▀█░▄▄▀██▄██░▄▄▀█░▄▄▄████░███░█▀▄▄▀█░██░█░▄▄▀███▄░▄█░▄▄▀█░▄▄█▄░▄█░▄▄▀█░██░███
██░████░██░▄▄█░▀▀░█░██░██░▄█░██░█░█▄▀████▄▀▀▀▄█░██░█░██░█░▀▀▄████░██░██░█▄▄▀██░██░▀▀░█░██░███
██░▀▀▄█▄▄█▄▄▄█▄██▄█▄██▄█▄▄▄█▄██▄█▄▄▄▄██████░████▄▄███▄▄▄█▄█▄▄███▀░▀█▄██▄█▄▄▄██▄██▄██▄█▄▄█▄▄██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"

echo "Pacman and yay cache"
sudo pacman -Sc && yay -Sc

echo "\nUnused Packages"
sudo pacman -Qtdq    
sudo pacman -Rns $(pacman -Qtdq) 

echo "\nSystem cache"
sudo du -sh ~/.cache/ && rm -rf ~/.cache/*

echo "\nflatpak"
sudo rm -rfv /var/tmp/flatpak-cache-* &&  flatpak uninstall --unused   

echo "\nSystemd cache"
sudo journalctl --vacuum-size=50M

sleep 1s
