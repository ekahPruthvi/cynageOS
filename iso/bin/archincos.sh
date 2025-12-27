#!/bin/bash
# buit for cynageOS but can also be used to install arch Linux
# ekahPruthvi <https://github.com/ekahPruthvi>
# Usage: ./archincos.sh <root_partition> <boot_partition> [swap_partition]

ROOT="$1"
BOOT="$2"
SWAP="$3"

echo "ROOT='$1', BOOT='$2', SWAP='$3' ($# args)"

if [ -z "$ROOT" ] || [ -z "$BOOT" ]; then
    echo "Usage: $0 <root_partition> <boot_partition> [swap_partition]"
    exit 1
fi

echo "Formatting root partition ($ROOT) as ext4..."
mkfs.ext4 "$ROOT"

echo "Formatting boot partition ($BOOT) as FAT32..."
mkfs.fat -F32 "$BOOT"

if [ -n "$SWAP" ]; then
    echo "Formatting swap partition ($SWAP) as swap..."
    mkswap "$SWAP"
fi

echo "Mounting root partition ($ROOT) at /mnt..."
mount "$ROOT" /mnt

echo "Creating /mnt/boot directory..."
mkdir -p /mnt/boot

echo "Mounting boot partition ($BOOT) at /mnt/boot..."
mount "$BOOT" /mnt/boot

if [ -n "$SWAP" ]; then
    echo "Enabling swap partition ($SWAP)..."
    swapon "$SWAP"
fi

set -e

if grep -qi 'amd' /proc/cpuinfo; then
    UCODE="amd-ucode"
else
    UCODE="intel-ucode"
fi

echo "Detected microcode: $UCODE"

cat << 'EOF'

░▒█▀▀▀█░▒█▀▀▀░▀▀█▀▀░▀▀█▀▀░▀█▀░▒█▄░▒█░▒█▀▀█
░░▀▀▀▄▄░▒█▀▀▀░░▒█░░░░▒█░░░▒█░░▒█▒█▒█░▒█░▄▄
░▒█▄▄▄█░▒█▄▄▄░░▒█░░░░▒█░░░▄█▄░▒█░░▀█░▒█▄▄▀

░▒█░▒█░▒█▀▀▀█░▒█▀▀▀░▒█▀▀▄░▒█▄░▒█░█▀▀▄░▒█▀▄▀█░▒█▀▀▀░░░░░
░▒█░▒█░░▀▀▀▄▄░▒█▀▀▀░▒█▄▄▀░▒█▒█▒█▒█▄▄█░▒█▒█▒█░▒█▀▀▀░▄▄░░
░░▀▄▄▀░▒█▄▄▄█░▒█▄▄▄░▒█░▒█░▒█░░▀█▒█░▒█░▒█░░▒█░▒█▄▄▄░▀▀░░
EOF

sleep 2s
pidof cap | xargs kill -37

read -p "Enter your username (all in small letters): " USERNAME
read -p "Enter your computer name (hostname): " COMPUTERNAME

echo "$USERNAME" > bob.txt

if [[ "$USERNAME" == "pdp" || "$USERNAME" == "ekah" ]]; then
    cat <<'EOF'

░█░░░░█▀▀░█░░█░░▄▀▀▄
░█▀▀█░█▀▀░█░░█░░█░░█
░▀░░▀░▀▀▀░▀▀░▀▀░░▀▀░
░█▀▄░█▀▀▄░█▀▀░█▀▀▄░▀█▀░▄▀▀▄░█▀▀▄░░░░░░░
░█░░░█▄▄▀░█▀▀░█▄▄█░░█░░█░░█░█▄▄▀░░░▄▄░░
░▀▀▀░▀░▀▀░▀▀▀░▀░░▀░░▀░░░▀▀░░▀░▀▀░░░▀▀░░

EOF
    sleep 2s

elif [[ "$USERNAME" == "chands" || "$USERNAME" == "murgi" || "$USERNAME" == "chickenswab" ]]; then
    cat <<'EOF'

░█░░░░█▀▀░█░░█░░▄▀▀▄
░█▀▀█░█▀▀░█░░█░░█░░█
░▀░░▀░▀▀▀░▀▀░▀▀░░▀▀░
░▄▀▀▄░█▀▀░█▀▀▄░█▀▀▀░█░░░▀░░█▀▀▄░░░░░░░
░█▄▄█░█▀▀░█░▒█░█░▀▄░█░░░█▀░█░▒█░░░▄▄░░
░█░░░░▀▀▀░▀░░▀░▀▀▀▀░▀▀░▀▀▀░▀░░▀░░░▀▀░░

EOF
    sleep 2s
fi

sleep 2s

printf "

░▒█▀▀▄░▒█▀▀▀█░▒█▄░▒█░▒█▀▀▀░▀█▀░▒█▀▀█░▒█░▒█░▒█▀▀▄░▀█▀░▒█▄░▒█░▒█▀▀█░
░▒█░░░░▒█░░▒█░▒█▒█▒█░▒█▀▀░░▒█░░▒█░▄▄░▒█░▒█░▒█▄▄▀░▒█░░▒█▒█▒█░▒█░▄▄░
░▒█▄▄▀░▒█▄▄▄█░▒█░░▀█░▒█░░░░▄█▄░▒█▄▄▀░░▀▄▄▀░▒█░▒█░▄█▄░▒█░░▀█░▒█▄▄▀░

░▒█░░░░█▀▀▄░▒█▄░▒█░▒█▀▀█░▒█░▒█░█▀▀▄░▒█▀▀█░▒█▀▀▀░░░░░░░
░▒█░░░▒█▄▄█░▒█▒█▒█░▒█░▄▄░▒█░▒█▒█▄▄█░▒█░▄▄░▒█▀▀▀░░░▄▄░░
░▒█▄▄█▒█░▒█░▒█░░▀█░▒█▄▄▀░░▀▄▄▀▒█░▒█░▒█▄▄▀░▒█▄▄▄░░░▀▀░░

press return to select language

"
read
LOCALE=$(cat /usr/share/i18n/SUPPORTED | fzf | cut -d ' ' -f1)
echo "Selected locale: $LOCALE"

BOOTLOADER_NAME="cynageOS"

echo "Pacstrapping base system..."
while ! pacstrap -i /mnt base base-devel linux linux-firmware git sudo htop $UCODE nano fzf go vim bluez bluez-utils networkmanager; do
  echo "pacstrap failed, retrying..."
done

echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab
echo "Resulting /mnt/etc/fstab:"
cat /mnt/etc/fstab

cp -pa /usr/bin/cage  /mnt/usr/bin/
cp -pa /usr/bin/altDot  /mnt/usr/bin/
cp -pa /usr/bin/batt_low  /mnt/usr/bin/
cp -pa /usr/bin/calibrate  /mnt/usr/bin/
cp -pa /usr/bin/capsule  /mnt/usr/bin/
cp -pa /usr/bin/clipper  /mnt/usr/bin/
cp -pa /usr/bin/cynagectl  /mnt/usr/bin/
cp -pa /usr/bin/octobacillus  /mnt/usr/bin/
cp -pa /usr/bin/octobacilluscus  /mnt/usr/bin/
cp -pa /usr/bin/terminatee  /mnt/usr/bin/
cp -pa /usr/bin/welp /mnt/usr/bin/
cp -par /usr/include/wlroots-0.18 /mnt/usr/include/
cp -pa /usr/lib/libwlroots-0.18.so /mnt/usr/lib/
cp -pa /usr/lib/wlroots-0.18.pc /mnt/usr/lib/
cp -pa /etc/os-release /mnt/etc/os-release
cp -pa /var/lib/cos/yay-12.5.3-1-x86_64.pkg.tar.zst /mnt/root/

cat <<EOF > /mnt/root/chroot_setup.sh
#!/bin/bash
set -e

printf "
░▒█▀▀▄░▒█▀▀▄░▒█▀▀▀░█▀▀▄░▀▀█▀▀░▀█▀░▒█▄░▒█░▒█▀▀█
░▒█░░░░▒█▄▄▀░▒█▀▀▀▒█▄▄█░░▒█░░░▒█░░▒█▒█▒█░▒█░▄▄
░▒█▄▄▀░▒█░▒█░▒█▄▄▄▒█░▒█░░▒█░░░▄█▄░▒█░░▀█░▒█▄▄▀\n
░▒█░▒█░▒█▀▀▀█░▒█▀▀▀░▒█▀▀▄░░░░░
░▒█░▒█░░▀▀▀▄▄░▒█▀▀▀░▒█▄▄▀░▄▄░░
░░▀▄▄▀░▒█▄▄▄█░▒█▄▄▄░▒█░▒█░▀▀░░\n"

echo "Setting root password..."
until passwd; do
    echo "Password did not match or failed. Try again..."
done

echo "Adding user $USERNAME..."
useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash $USERNAME\

echo "Setting password for $USERNAME..."
until passwd "$USERNAME"; do
    echo "~~~ Dear Sire/Madam, your passwords do not match ~~~"
done

echo "Editing sudoers..."
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^# //' /etc/sudoers

echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

echo "Switching to user $USERNAME..."
su - $USERNAME -c 'sudo pacman -Syu'


printf "

░▒█▀▀▄░▒█▀▀▀█░▒█▄░▒█░▒█▀▀▀░▀█▀░▒█▀▀█░▒█░▒█░▒█▀▀▄░▀█▀░▒█▄░▒█░▒█▀▀█░
░▒█░░░░▒█░░▒█░▒█▒█▒█░▒█▀▀░░▒█░░▒█░▄▄░▒█░▒█░▒█▄▄▀░▒█░░▒█▒█▒█░▒█░▄▄░
░▒█▄▄▀░▒█▄▄▄█░▒█░░▀█░▒█░░░░▄█▄░▒█▄▄▀░░▀▄▄▀░▒█░▒█░▄█▄░▒█░░▀█░▒█▄▄▀░

░▀▀█▀▀░▀█▀░▒█▀▄▀█░▒█▀▀▀░▒█▀▀▀█░▒█▀▀▀█░▒█▄░▒█░▒█▀▀▀░░░░░░░
░░▒█░░░▒█░░▒█▒█▒█░▒█▀▀▀░░▄▄▄▀▀░▒█░░▒█░▒█▒█▒█░▒█▀▀▀░░░▄▄░░
░░▒█░░░▄█▄░▒█░░▒█░▒█▄▄▄░▒█▄▄▄█░▒█▄▄▄█░▒█░░▀█░▒█▄▄▄░░░▀▀░░

press return to select timezone

"
read
ZONE=\$(find /usr/share/zoneinfo/ -type f | sed 's|/usr/share/zoneinfo/||' | fzf)
ln -sf "/usr/share/zoneinfo/\$ZONE" /etc/localtime

echo "Setting hardware clock..."
hwclock --systohc

echo "Selecting locale..."
echo "$LOCALE UTF-8" >> /etc/locale.gen
locale-gen

echo "Setting locale..."
echo "LANG=$LOCALE" > /etc/locale.conf

echo "Setting hostname..."
echo "$COMPUTERNAME" > /etc/hostname

echo "Configuring /etc/hosts..."
cat <<EOT > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   $COMPUTERNAME.localdomain $COMPUTERNAME
EOT

echo "Installing bootloader tools..."
pacman -S grub efibootmgr dosfstools mtools os-prober --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=$BOOTLOADER_NAME

echo "Enabling OS prober..."
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub

sed -i -E -e "s|^GRUB_DISTRIBUTOR=.*|GRUB_DISTRIBUTOR=\"$BOOTLOADER_NAME\"|" "/etc/default/grub"


echo "Generating GRUB config..."
grub-mkconfig -o /boot/grub/grub.cfg

echo "Enabling system services..."
systemctl enable bluetooth
systemctl enable NetworkManager

sed -i '/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/s/^/# /' /etc/sudoers

chmod 777 /root/yay-12.5.3-1-x86_64.pkg.tar.zst
pacman -U /root/yay-12.5.3-1-x86_64.pkg.tar.zst

echo "Finished inside chroot."
EOF

chmod +x /mnt/root/chroot_setup.sh

echo "Entering chroot to complete Arch setup..."
arch-chroot /mnt /root/chroot_setup.sh

echo "Cleaning chroot setup script..."
rm /mnt/root/chroot_setup.sh

sleep 3s
pidof cap | xargs kill -36