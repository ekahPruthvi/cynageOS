#!/usr/bin/env bash

BaseDir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

mkdir -p $HOME/cynageiso
cp -r /usr/share/archiso/configs/releng $HOME/cynageiso/cos/

# PROFILEDEF.SH
PROFILEDEF="$HOME/cynageiso/cos/profiledef.sh"

read -rp "Enter the version number (e.g., 5): " version
read -rp "Enter the release type (e.g., alpha2 or stable): " release_type

new_iso_name="cynageOSv$version"
new_iso_label="cosv${version}_${release_type}_\$(date --date=\"@${SOURCE_DATE_EPOCH:-\$(date +%s)}\" +%Y%m)"
new_iso_publisher='ekahPruthvi <ekahpdp@gmail.com>'
new_iso_application='CynageOS Linux Live/Rescue DVD (arch)'

sed -i -E \
  -e "s|^iso_name=.*|iso_name=\"$new_iso_name\"|" \
  -e "s|^iso_label=.*|iso_label=\"$new_iso_label\"|" \
  -e "s|^iso_publisher=.*|iso_publisher=\"$new_iso_publisher\"|" \
  -e "s|^iso_application=.*|iso_application=\"$new_iso_application\"|" \
  "$PROFILEDEF"

cat > /tmp/new_entries.txt <<'EOF'
  ["/usr/bin/inmepls"]="0:0:755"
  ["/usr/bin/cap"]="0:0:755"
  ["/usr/bin/archincos.sh"]="0:0:755"
  ["/usr/bin/cage"]="0:0:755"
  ["/usr/bin/altDot"]="0:0:755"
  ["/usr/bin/batt_low"]="0:0:755"
  ["/usr/bin/calibrate"]="0:0:755"
  ["/usr/bin/capsule"]="0:0:755"
  ["/usr/bin/clipper"]="0:0:755"
  ["/usr/bin/cynagectl"]="0:0:755"
  ["/usr/bin/octobacillus"]="0:0:755"
  ["/usr/bin/octobacilluscus"]="0:0:755"
  ["/usr/bin/terminatee"]="0:0:755"
  ["/usr/bin/welp"]="0:0:755"
  ["/usr/bin/cynsetupcos.sh"]="0:0:755"
)
EOF

sed -i "/file_permissions=(/,/)/ {
  /)/ r /tmp/new_entries.txt
  /)/ d
}" "$PROFILEDEF"

rm /tmp/new_entries.txt

echo "Adding entries to file_permissions in $PROFILEDEF" && sleep 3s

# packages.x86_64
cat <<EOF >> $HOME/cynageiso/cos/packages.x86_64
gcc
meson
mesa
xcb-util-renderutil
xcb-util-wm
xcb-util-errors
wayland
wayland-protocols
egl-wayland
libglvnd
vulkan-icd-loader
vulkan-headers
glslang
libdrm
libinput
libxkbcommon
pixman
seatd
hwdata
libdisplay-info
libliftoff
xorg-xwayland
libxkbcommon
gtk4
gtk4-layer-shell
vte4
networkmanager
pango
gdk-pixbuf2
cairo
glib2
git
fzf
EOF

echo "Appeding required packages" && sleep 3s

# splash
rm $HOME/cynageiso/cos/syslinux/splash.png

# archiso head
sed -i -E \
  -e "s/^MENU TITLE Arch Linux.*/MENU TITLE CynageOS Linux/" \
  "$HOME/cynageiso/cos/syslinux/archiso_head.cfg"

# efibootloader
sed -i -E "s|^title\s+Arch Linux install medium \(.*\)|title    CynageOS Linux install medium (arch, UEFI)|" "/home/ekah/cynageiso/cos/efiboot/loader/entries/01-archiso-linux.conf"

# AIROOTFS
cp -r "$BaseDir/iso/bin" "$HOME/cynageiso/cos/airootfs/usr/"
cp -r "$BaseDir/iso/include" "$HOME/cynageiso/cos/airootfs/usr/"
cp -r "$BaseDir/iso/lib" "$HOME/cynageiso/cos/airootfs/usr/"
cp -r "$BaseDir/iso/var" "$HOME/cynageiso/cos/airootfs/"

cd $BaseDir
cargo build --release && mv "$BaseDir/target/release/cap" "$HOME/cynageiso/cos/airootfs/usr/bin/" && cargo clean

echo "Managing permissions and creating the MOTD" && sleep 3s

# etc
echo "cynageOS" > "$HOME/cynageiso/cos/airootfs/etc/hostname"

# required packages
TARGET_DIR="$HOME/cynageiso/cos/airootfs/var/lib/cos/req_pkgs/"
mkdir -p "$TARGET_DIR"

PKGS=(
  archiso ark bc blueman brightnessctl cliphist code cpio
  dnsmasq dosfstools dunst efibootmgr espeak-ng eza ffmpegthumbs flatpak fuse2
  greetd grimblast-git grub gst-plugin-pipewire gst-plugins-base gtk4-layer-shell
  hostapd hyprland hyprpicker hyprshot i2c-tools imagemagick iw jq kde-cli-tools
  kdeconnect kitty kvantum kvantum-qt5 libconfig libev libnotify libresprite linux-headers
  loupe man-db mpv mtools nautilus netdiscover network-manager-applet
  noto-fonts-emoji nwg-look oh-my-zsh-git pacman-contrib pam-python pamixer parallel pavucontrol
  pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse playerctl pokemon-colorscripts-git
  polkit-kde-agent pv pyprland qt5-graphicaleffects qt5-imageformats qt5-quickcontrols qt5-quickcontrols2
  qt5-wayland qt5ct qt6-virtualkeyboard qt6-wayland qt6ct rpi-imager rustup sddm slurp smassh-bin
  sox swww system-config-printer systemd tk ttf-bigblueterminal-nerd ttf-heavydata-nerd udiskie
  usbutils uthash v4l-utils zen-browser vte4 wev wf-recorder wget wireplumber
  xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xf86-video-vesa xorg-bdftopcf
  xorg-docs xorg-font-util xorg-fonts-100dpi xorg-fonts-75dpi xorg-iceauth xorg-mkfontscale
  xorg-server-devel xorg-server-xephyr xorg-server-xnest xorg-server-xvfb xorg-sessreg xorg-smproxy
  xorg-x11perf xorg-xbacklight xorg-xcmsdb xorg-xcursorgen xorg-xdpyinfo xorg-xdriinfo xorg-xev
  xorg-xgamma xorg-xhost xorg-xinput xorg-xkbevd xorg-xkbutils xorg-xkill xorg-xlsatoms
  xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xrandr xorg-xrdb xorg-xrefresh
  xorg-xsetroot xorg-xvinfo xorg-xwd xorg-xwininfo xorg-xwud
  zsh-autosuggestions-git zsh-syntax-highlighting-git zsh-theme-powerlevel10k-git
  xcb-util-renderutil xcb-util-wm xcb-util-errors wayland wayland-protocols egl-wayland
  libglvnd vulkan-icd-loader vulkan-headers glslang libdrm libinput libxkbcommon pixman
  seatd hwdata libdisplay-info libliftoff xorg-xwayland libxkbcommon gtk4 gtk4-layer-shell vte4 mesa
)

sudo pacman -Scc --noconfirm
yay -Sw --noconfirm "${PKGS[@]}"

cp /var/cache/pacman/pkg/*.pkg.tar.zst "$TARGET_DIR"
echo "All packages downloaded and copied to $TARGET_DIR"


# MoTD
cat << EOF > $HOME/cynageiso/cos/airootfs/etc/motd
__________________________________________________________________________________________________________________________________________

██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
                                                                     
                                                      ▄▄█▀▀██▄  ▄█▀▀▀█▄█    
                                                    ▄██▀    ▀██▄██    ▀█    
 ▄██▀██▀██▀   ▀██▀████████▄  ▄█▀██▄  ▄█▀█████ ▄▄█▀████▀      ▀█████▄        
██▀  ██  ██   ▄█   ██    ██ ██   ██ ▄██  ██  ▄█▀   ███        ██ ▀█████▄    
██        ██ ▄█    ██    ██  ▄█████ ▀█████▀  ██▀▀▀▀▀▀█▄      ▄██     ▀██    
██▄    ▄   ███     ██    ██ ██   ██ ██       ██▄    ▄██▄    ▄██▀█     ██             
 █████▀    ▄█    ▄████  ████▄████▀██▄███████  ▀█████▀ ▀▀████▀▀ █▀█████▀ v5.0.0 pre-alpha   
         ▄█                         █▀     ██                               
       ██▀                          ██████▀                                 

▒▄▀▄░░░█▀▄▒██▀░█▒█░█▒░░▄▀▄▒█▀▄▒██▀▒█▀▄░░░▄▀▄▒█▀▄░█▒██▀░█▄░█░▀█▀▒██▀░█▀▄░░░▄▀▄▒█▀▄▒██▀▒█▀▄▒▄▀▄░▀█▀░█░█▄░█░▄▀▒░░░▄▀▀░▀▄▀░▄▀▀░▀█▀▒██▀░█▄▒▄█░░
░█▀█▒░▒█▄▀░█▄▄░▀▄▀▒█▄▄░▀▄▀░█▀▒░█▄▄░█▀▄▒░░▀▄▀░█▀▄░█░█▄▄░█▒▀█░▒█▒░█▄▄▒█▄▀▒░░▀▄▀░█▀▒░█▄▄░█▀▄░█▀█░▒█▒░█░█▒▀█░▀▄█▒░▒▄██░▒█▒▒▄██░▒█▒░█▄▄░█▒▀▒█▒░

░█░░▒█░█░▀█▀░█▄█░░▒▄▀▄░░░▄▀▀░█▒░▒██▀▒██▀░█▄▀░░░█▄▒▄█░▄▀▄▒█▀▄░█▀▄▒██▀▒█▀▄░█▄░█░░░█▒░░▄▀▄░▄▀▄░█▄▀░░
░▀▄▀▄▀░█░▒█▒▒█▒█▒░░█▀█▒░▒▄██▒█▄▄░█▄▄░█▄▄░█▒█▒░░█▒▀▒█░▀▄▀░█▀▄▒█▄▀░█▄▄░█▀▄░█▒▀█▒░▒█▄▄░▀▄▀░▀▄▀░█▒█░▄


author: ekahPruthvi <ekahpdp@gmail.com>
github: https://github.com/ekahPruthvi/cynageOS.git

██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
__________________________________________________________________________________________________________________________________________



To initiate the cynageOSv5 installation, follow these steps:

1. If Laptop, Please make sure your device has enough battery or connect to a charger.
2. Wired Ethernet Connection: Connect your device to the internet using a wired Ethernet connection. 
   Then, type 'inmepls' to begin the installation process.
3. WiFi Connection: If you're using WiFi, simply type 'inmepls' to start the installation.

EOF

cat << EOF > $HOME/cynageiso/cos/airootfs/etc/os-release
NAME="cynageOS Linux"
PRETTY_NAME="cynageOS"
ID=arch
BUILD_ID=rolling
ANSI_COLOR="38;2;23;147;209"
LOGO=cos-logo
DOCUMENTATION_URL="https://ekahpruthvi.github.io/StertorusPages/blogs/notes.html"
EOF

echo "Getting files redy for mkarchiso" && sleep 3s

echo "Starting mkarchiso" && sleep 3s

cd "$HOME/cynageiso/cos/"
sudo mkarchiso -v .




