# cynageOS
The Project overtaken by SCU

<p align="center">
  <img width="250" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/COSlogo/COS(2).png" />   
</p>


## desktop


<p align="center">
    <img align="center" width="49%" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/cosdem.png" /> 
</p>


### Installation

⚠️ Under ~~development~~ constant development 

The installation script is made for Arch, but **may** work on some Arch based distros.   
For Debian, please refer **Senshi111**'s version [here](https://github.com/Senshi111/debian-hyprland-hyprdots).

THIS IS SPECIALLY TUNED FOR ASUS ( ROG & TUF ) LAPTOPS. 
Use of asusctl is recomended    

> **Warning**
>
> Install script will auto-detect nvidia card and install nvidia-dkms drivers for your kernel.   
> Nvidia drm will be enabled in grub, so please [ensure](https://wiki.archlinux.org/title/NVIDIA) your nvidia card supports dkms drivers/hyprland.
> If on install the resolution is incorrect pls change in ```~/.config/hypr/hyprland.conf``` under monitor.
> The keybinding for utility capsule is there only for ROG and TUF laptops. For others change in ```~/.config/hypr/keybindings.conf```

Some errors might be encountered during the installation due to chroot or gpg keyring , etc
To Fix them
```shell
pacman -Syu
pacman -S archlinux-keyring

sudo pacman-key --init
sudo pacman-key --populate
sudo pacman-key --lsign cachyos (Possible error in this command .. This will not be a problem)

(For Fakeroot)
sudo pacman -Sy --needed base-devel

(For wlogout pgp keyring error)
curl -sS https://keys.openpgp.org/vks/v1/by-fingerprint/F4FDB18A9937358364B276E9E25D679AF73C6D2F | gpg --import -

```

After minimal Arch install (with grub), clone and execute -
```shell
pacman -Sy git
git clone https://github.com/ekahPruthvi/cynageOS.git
sudo chmod +x cynageOS
sudo chmod -R 777 cynageOS
cd ~/cynageOS/Scripts
./install.sh
```

> **Note**
>
> You can also create your own list (for ex. `custom_apps.lst`) with all your favorite apps and pass the file as a parameter to install it -
>```shell
>./install.sh custom_apps.lst
>```

Please reboot after the install script completes and takes you to sddm login screen (or black screen) for the first time.   
For more details, please refer [installation.md](https://github.com/ekahPruthvi/blob/main/installation.md)


### Theming
To add your own custom theme, please refer [theming.md](https://github.com/ekahPruthvi/hyprdots/blob/main/theming.md)
- Available themes
    - [x] Catppuccin-Mocha
    - [x] Catppuccin-Latte
    - [x] Decay-Green
    - [x] Rosé-Pine
    - [x] Tokyo-Night
    - [x] Material-Sakura
    - [x] Graphite-Mono
    - [x] Cyberpunk-Edge

<details>
<summary><h4>Packages</h4></summary>

| nvidia | |
| :-- | --- |
linux-headers | for main kernel (script will auto detect from /usr/lib/modules/)
linux-zen-headers | for zen kernel (script will auto detect from /usr/lib/modules/)
linux-lts-headers | for lts kernel (script will auto detect from /usr/lib/modules/)
nvidia-dkms | nvidia drivers (script will auto detect from lspci -k | grep -A 2 -E "(VGA|3D)")
nvidia-utils | nvidia drivers (script will auto detect from lspci -k | grep -A 2 -E "(VGA|3D)")

| tools | |
| :-- | --- |
pipewire | audio and video server
pipewire-alsa | for audio
pipewire-audio | for audio
pipewire-jack | for audio
pipewire-pulse | for audio
gst-plugin-pipewire | for audio
wireplumber | audio and video server
networkmanager | network manager
network-manager-applet | nm tray
bluez | for bluetooth
bluez-utils | for bluetooth
blueman | bt tray
brightnessctl | brightness control for laptop

| login | |
| :-- | --- |
sddm-git | display manager for login
qt5-wayland | for QT wayland XDP
qt6-wayland | for QT wayland XDP
qt5-quickcontrols | for sddm theme
qt5-quickcontrols2 | for sddm theme
qt5-graphicaleffects | for sddm theme

| hypr | |
| :-- | --- |
hyprland-git | main window manager (script will change this to hyprland-nvidia-git if nvidia card is detected)
dunst | graphical notification daemon
rofi-lbonn-wayland-git | app launcher
waybar-hyprland-git | status bar
swww | wallpaper app
swaylock-effects-git | lockscreen
swayidle | idle management daemon
wlogout | logout screen
grim | screenshot tool
slurp | selects region for screenshot/screenshare
swappy | screenshot editor
cliphist | clipboard manager

| dependencies | |
| :-- | --- |
polkit-kde-agent | authentication agent
xdg-desktop-portal-hyprland-git | XDG Desktop Portal
imagemagick | for kitty/neofetch image processing
qt5-imageformats | for dolphin thumbnails
pavucontrol | audio settings gui
pamixer | for waybar audio

| theming | |
| :-- | --- |
nwg-look | theming GTK apps
kvantum | theming QT apps
qt5ct | theming QT5 apps

| applications | |
| :-- | --- |
firefox | browser
kitty | terminal
neofetch | fetch tool
dolphin | kde file manager
visual-studio-code-bin | gui code editor
vim | text editor
ark | kde file archiver

| shell | |
| :-- | --- |
zsh | main shell
exa | colorful file lister
oh-my-zsh-git | for zsh plugins
zsh-theme-powerlevel10k-git | theme for zsh
zsh-syntax-highlighting-git | highlighting of commands
zsh-autosuggestions-git | see completion as you type
pokemon-colorscripts-git | display pokemon sprites

</details>

### Credits
prashantrangan(tittu).
This install script has been adopted from hyprdots with little modifications to it.
