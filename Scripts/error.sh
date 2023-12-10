#!/bin/bash
#|---/ /+--------------------------+---/ /|#
#|--/ /-| fix all possible errors  |--/ /-|#
#|-/ /--| @ekah cynageOS           |-/ /--|#
#|/ /---+--------------------------+/ /---|#

# Run before installing cynageOS
echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄\n██░▄▄▄██░▄▄▀██░▄▄▀██░▄▄▄░██░▄▄▀████░▄▄█░█████\n██░▄▄▄██░▀▀▄██░▀▀▄██░███░██░▀▀▄█▀▀█▄▄▀█░▄▄░██\n██░▀▀▀██░██░██░██░██░▀▀▀░██░██░█▄▄█▄▄▄█▄██▄██\n▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀\n"

echo "Fixing keyring Issues"
pacman -Syu
pacman -S archlinux-keyring

sudo pacman-key --init
sudo pacman-key --populate
sudo pacman-key --lsign cachyos

echo "Fixing Fakeroot error"
sudo pacman -Sy --needed base-devel

echo "Fixing wlogout pgp keyring error"
curl -sS https://keys.openpgp.org/vks/v1/by-fingerprint/F4FDB18A9937358364B276E9E25D679AF73C6D2F | gpg --import -

