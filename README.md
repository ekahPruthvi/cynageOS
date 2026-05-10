
| <img width="100%" alt="capsule" src="https://github.com/user-attachments/assets/bae83861-0366-4018-920b-abc42287e570" /> |
| - |

> [!CAUTION]
> `v5.1.0 alpha` <br>
> Still in development not all features are implimented <br>
> And certainly not production ready

cynageOS, an innovative operating system that is meticulously crafted to boost productivity. </br>
The design philosophy revolves around minimizing distractions while providing an aesthetically pleasing experience.</br>
By combining modern aesthetics with user-friendly interfaces. </br></br>

> [!NOTE]  
> This repository houses the links to all `CynageOS Modules` and `The Capsule Design Interface Guidelines` <br>
> For more information regardeing cynageOS and its modules please refer to [This Page](https://ekahpruthvi.github.io/StertorusPages/blogs/notes.html).

| Desktop Previerw |  |
|---|---|
| <img width="1919" height="1080" alt="image" src="https://github.com/user-attachments/assets/70717769-ebfe-49da-aaec-c4b44d5c1a5c" /> | <img width="1919" height="1080" alt="image" src="https://github.com/user-attachments/assets/53b5ab61-9d07-43c2-b9ad-b7f2f3c40cd9" /> | 
| <img width="1917" height="1080" alt="image" src="https://github.com/user-attachments/assets/ffb2bdf5-bcbd-4a26-9ff4-52b269da8a35" /> | <img width="1916" height="1080" alt="image" src="https://github.com/user-attachments/assets/e1747818-9a9d-4ef1-8639-3dc56d7ce768" /> |





<br><br>

|   | Module  | version  |
|---|---|---|
| [<img height="100" alt="alt" src="https://github.com/user-attachments/assets/5a7535c1-94cd-4272-8f12-3ad044069e31" />](https://github.com/ekahPruthvi/altDotlauncher)  | <p>Alt Launcher (application launcher)</p> | 1.2.0 |
| [<img height="100" alt="calibrate" src="https://github.com/user-attachments/assets/9ee3dfa0-45ca-4977-9f86-f9e822db2450" />](https://github.com/ekahPruthvi/calibrate) | <p>Calibrate (Settings)</p> | 1.0.0 |
| [<img height="100" alt="capsule" src="https://github.com/user-attachments/assets/7015c035-7923-46f6-9299-99276e515d83" />](https://github.com/ekahPruthvi/capsule_shell)  | <p>Capsule Shell (cynageOS Navigation)</p> | 1.1.5 |
| [<img height="100" alt="clipper" src="https://github.com/user-attachments/assets/75700744-47e7-4b71-9fc9-d76b2e815066" />](https://github.com/ekahPruthvi/clipper) | <p>Clipper (Clipboard Manager)</p> | 1.0.0 |
| [<img height="100" alt="octo" src="https://github.com/user-attachments/assets/7630cb8d-fc12-4e07-879a-d6d6abd30e2e" />](https://github.com/ekahPruthvi/octobacillus) | <p>Octo (Lock and Login Screens)</p> | 1.0.2 |
| [<img height="100" alt="Power" src="https://github.com/user-attachments/assets/7c51b58d-07ee-486e-a647-f1c74ff310f6" />](https://github.com/ekahPruthvi/powerCynide) | <p>Power Cynide (Shutdown menu)</p> | 1.0.0 |



<br><br>
# Installation (iso)
- Download cynageOSv5.0.1-XXnmXX.XX.XX-x86_64.iso from [releases page](https://github.com/ekahPruthvi/cynageOS/releases)
- Flash the iso into a usb pendrive using
  - Balena Etcher
  - Rusfus Or any other
- Install CynageOS and refer to [Capsulator User Information](ISO.md)

<br><br>
# CDIG (Capsule Design Interface Guidelines)
The CDIG is the design language followed by the cynageOS applications ecosystem.<br>
The style that reflects smooth capsule and curveres as well as distinct sharp corners in places of heigher attention.<br> 
<br>
CDIG focuses on Interface Feedback and the whole UI language built around smoother and more prominant feedback ('as in UI that feels alive') and reactive to the USER.

`UPCOMMING`

<br><br>
# Theming
To add your own custom theme, please refer [theming.md](https://github.com/ekahPruthvi/cynageOS/blob/main/theming.md)
- Available themes
    - Cynage
    - Lightage (dropped support for a more unified look)

<br><br>
# Packages (not updated to the latest requirements)
| nvidia | |
| :-- | --- |
linux-headers | for main kernel (script will auto detect from /usr/lib/modules/)
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

