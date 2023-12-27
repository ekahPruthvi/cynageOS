# cynageOS
The Project overtaken by SCU

## Y cynageOS?

### Deadline Doomsday
Keep track of ur whole week and stay focused </br>
cynageOS welcomes you to your desktop with DDmd which lets you set To-Dos for your Week. </br>
![231213_18h27m52s_screenshot](https://github.com/ekahPruthvi/cynageOS/assets/136414172/17ce6d66-8a36-4c54-909a-1f336ce6b089)

DDmd conveniently auto-hides after 2 seconds, letting you remember your productivity goals and then get right back to your place. </br>
It can be easily called back and edited from the ```Utility Capsule```  </br>
![-20231227-14:44:17](https://github.com/ekahPruthvi/cynageOS/assets/136414172/8bf4f729-f19b-45b1-98a6-5d8524f37263)
 </br>Edit by Day </br>
 
![-20231227-14:44:43](https://github.com/ekahPruthvi/cynageOS/assets/136414172/110cedfb-7fb7-4907-ab56-91ad55760e5b)

### Utility Capsule
(mouse_right_click != mouse_left_click)
Smart Topbar for useful tools that appear only when needed </br>
activated with AURA key on asus keyboards

> The AURA key can be changed from ~/.config/hypr/keybindings.conf
> Clicking on cynageOS will close the bar

![-20231227-14:57:52](https://github.com/ekahPruthvi/cynageOS/assets/136414172/405b66f7-ac62-4f96-960b-35b73223e05e)

### cCal
cynicalCalibrator </br>
An useful Settings applet to control and calibrate cynageOS </br>

![231213_18h24m13s_screenshot](https://github.com/ekahPruthvi/cynageOS/assets/136414172/bb996b50-4981-46fe-866d-4c2859c9e357)
![231214_09h00m59s_screenshot](https://github.com/ekahPruthvi/cynageOS/assets/136414172/20ebf43a-fd59-457b-908b-cc532c0b3f26)

> can also be activated using the keybinding ```MOD```+```SPACE```

<p align="center">
  <img width="250" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/COSlogo/COS.png" />   
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

Some errors might be encountered during the installation due to chroot or gpg keyring , etc </br>
To Fix them run after cloning and chmodding </br>
(Recomended to run before installing, but can be done later also if found error)
```shell
cd ~/cynageOS/Scripts
./error.sh
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
