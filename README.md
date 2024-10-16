<p align="center">
    <img align="center" width="49%" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/COSlogo/cynageOS.png" /> 
</p>

# cynageOS
The Project overtaken by SCU </br>
> update .3
</br>
cynageOS, an innovative operating system that is meticulously crafted to boost productivity. </br>
The design philosophy revolves around minimizing distractions while providing an aesthetically pleasing experience.</br>
By combining modern aesthetics with user-friendly interfaces, </br>

## What makes The cynageOS?

### Minimilitic nature 
cynageOS integrates the features of the desktop in a very minimalistic nature to keep away the distractions and allows you to focus on your work. ``The Simple by design concept`` 
![swappy-20240708_124848](https://github.com/ekahPruthvi/cynageOS/assets/136414172/3544433c-d762-4ea8-8148-32bbc8aeca0e)

The sysBar ``Clyde`` integrates itself with the wallpaper to show Important information in a very subtle manner

![image](https://github.com/user-attachments/assets/6941a328-a9e3-4c09-824c-dbdd5235fd9d)




### Deadline Doomsday
Keep track of ur whole week and stay focused </br>
cynageOS welcomes you to your desktop with DDmd which lets you set To-Dos for your Week. </br>
![swappy-20240708_122733](https://github.com/ekahPruthvi/cynageOS/assets/136414172/d3be860a-f8ee-4264-b87e-f7bb37819a2b)


DDmd conveniently auto-hides after 2 seconds, letting you remember your productivity goals and then get right back to your place. </br>
It can be easily called back and edited from the "cynicalCalibrator" - ```cCAL```  </br>
![swappy-20240629_124317](https://github.com/ekahPruthvi/cynageOS/assets/136414172/6586947e-e167-4b16-a49f-700b43762383)

 </br>Edit by Day </br>
 
![swappy-20240708_122239](https://github.com/ekahPruthvi/cynageOS/assets/136414172/d191c3ac-cd3f-4a76-83a7-8a066c66e7cc)

### cCal
cynicalCalibrator </br>
A useful Settings applet to control and calibrate cynageOS </br>

![swappy-20240708_123006](https://github.com/ekahPruthvi/cynageOS/assets/136414172/99d94c6f-d3a9-40a9-94f7-72f5a9d933e4)

> can also be activated using the keybinding ```AURA``` on asus keyboards </br>
> This can be changed in keybindings.conf by changing the aura binding  

### Wallpapers
quick change : ```ALT```+```-->```  or  ```ALT```+```<--``` </br>
or simply use the change wallpaper applet
![swappy-20240708_122803](https://github.com/ekahPruthvi/cynageOS/assets/136414172/3c75bf91-d7d6-4247-bdcb-2f76cb51fa86)

### Themes
The themes applet lets to easily switch the color profiles and the shaders 
![swappy-20240708_122849](https://github.com/ekahPruthvi/cynageOS/assets/136414172/b322505f-ad6a-4b56-b521-eb374a3f4b03)

### AURA
Change the keyboard colors easily 

![swappy-20240708_122311](https://github.com/ekahPruthvi/cynageOS/assets/136414172/ce6b7cd3-13d0-404c-902f-044768cbd200)

### DeTox
Cleans cynageOS of cache and unused app data
![swappy-20240708_122419](https://github.com/ekahPruthvi/cynageOS/assets/136414172/ba0123ea-e296-49c4-85ac-6e59e91935ec)

### Notification center
Custom configuration of swaync
![swappy-20240708_122905](https://github.com/ekahPruthvi/cynageOS/assets/136414172/922163c1-3409-4e56-ba03-ed55d16ed7ef)



### Others 
[ ] Super FASTTT!!! </br>
[ ] Amazing animations </br>
[ ] Looks COOOL </br>


<p align="center">
  <img width="250" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/COSlogo/COS.png" />   
</p>


## desktop


<p>
    <img align="center" width="49%" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/cosdemo.png" /> 
</p>


### Installation

⚠️ Under ~~development~~ constant development 

The installation script is made for Arch, but **may** work on some Arch based distros.   

THIS IS SPECIALLY TUNED FOR ASUS ( ROG & TUF ) LAPTOPS. </br>
Consider installing asusctl   

> **Warning**
>
> Install script will auto-detect nvidia card and install nvidia-dkms drivers for your kernel.   
> Nvidia drm will be enabled in grub, so please [ensure](https://wiki.archlinux.org/title/NVIDIA) your nvidia card supports dkms drivers/hyprland.
> If on install the resolution is incorrect pls change in ```~/.config/hypr/hyprland.conf``` under monitor.
> The keybinding for utility capsule is there only for ROG and TUF laptops. For others change in ```~/.config/hypr/keybindings.conf```

After minimal Arch install (with grub), clone and execute -
```shell
pacman -Sy git
git clone https://github.com/ekahPruthvi/cynageOS.git
sudo chmod +x cynageOS
sudo chmod -R 777 cynageOS
cd ~/cynageOS/Scripts
./install.sh
```
RESTART pc after the install completes and sddm appears 

> **Note**
>
> You can also create your own list (for ex. `custom_apps.lst`) with all your favorite apps and pass the file as a parameter to install it -
>```shell
>./install.sh custom_apps.lst
>```

Please reboot after the install script completes and takes you to sddm login screen (or black screen) for the first time.   
For more details, please refer [installation.md](https://github.com/ekahPruthvi/cynageOS/blob/main/installation.md)


### Theming
To add your own custom theme, please refer [theming.md](https://github.com/ekahPruthvi/cynageOS/blob/main/theming.md)
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
sddm | display manager for login
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

This install script has been adopted from hyprdots with modifications.
