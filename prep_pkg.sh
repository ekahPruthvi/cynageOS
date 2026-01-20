#!/bin/bash
# prepare required packages for cynageOS ISO build


PKGS=(
  archiso ark bc blueman brightnessctl cliphist code cpio
  dnsmasq dosfstools dunst efibootmgr espeak-ng eza ffmpegthumbs flatpak fuse2
  greetd grimblast-git grub gst-plugin-pipewire gst-plugins-base
  hostapd i2c-tools imagemagick iw jq kde-cli-tools
  kdeconnect kitty kvantum kvantum-qt5 libconfig libev libnotify libresprite linux-headers
  loupe man-db mpv mtools nautilus netdiscover network-manager-applet
  noto-fonts-emoji oh-my-zsh-git niri pacman-contrib pamixer parallel pavucontrol
  pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse playerctl pokemon-colorscripts-git
  polkit-kde-agent pv pyprland qt5-graphicaleffects qt5-imageformats qt5-quickcontrols qt5-quickcontrols2
  qt5-wayland qt5ct qt6-virtualkeyboard qt6-wayland qt6ct rpi-imager rustup sddm slurp smassh-bin
  sox swww system-config-printer systemd tk ttf-bigblueterminal-nerd ttf-heavydata-nerd udiskie
  usbutils uthash v4l-utils min-browser-bin vte4 wev wf-recorder wget wireplumber
  xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring xf86-video-vesa xorg-bdftopcf
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

yay -Sy --noconfirm "${PKGS[@]}"

