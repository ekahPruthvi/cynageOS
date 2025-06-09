<p align="center">
    <img align="center" width="49%" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/COSlogo/cynageOS.png" /> 
</p>

# cynageOS
The Project overtaken by SCU </br>
> update .4.9
</br>
cynageOS, an innovative operating system that is meticulously crafted to boost productivity. </br>
The design philosophy revolves around minimizing distractions while providing an aesthetically pleasing experience.</br>
By combining modern aesthetics with user-friendly interfaces. </br></br>

>For Installing or updating Instructions scroll below ⬇⬇ or [click here](#inst) </br>
>❗❗❗ CYNAGEOS IS CONSTANTLY BEING UPDATED (CHECK UPDATING INSTRUCTIONS BELOW) ❗❗❗

## What makes The cynageOS?</br>

![cynageOS_show](https://github.com/user-attachments/assets/a323d14a-886d-43b5-ba23-ae03eba488e8)


### Minimilitic nature 
cynageOS integrates the features of the desktop in a very minimalistic nature to keep away the distractions and allows you to focus on your work. ``The Simple by design concept`` 

The sysBar ``Clyde`` integrates itself with the wallpaper to show Important information in a very subtle manner

### cCal
cynicalCalibrator </br>
A useful Settings applet to control and calibrate cynageOS </br>

> can also be activated using the keybinding ```AURA``` on asus keyboards </br>
> This can be changed in keybindings.conf by changing the aura binding  

### Wallpapers
quick change : ```ALT```+```-->```  or  ```ALT```+```<--``` </br>
or simply use the change wallpaper applet

### Themes
The themes applet lets to easily switch the color profiles and the shaders 

### AURA
Change the keyboard colors easily 


### DeTox
Cleans cynageOS of cache and unused app data

### Notification center
Custom configuration of swaync


### Others 
❏ Super FAST!!! </br>
❏ Amazing animations </br>
❏ Looks COOOL </br>
❏ Devloper friendly</br>


<p align="center">
  <img width="150" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/COSlogo/COS.png" />   
</p>

<a id="inst"></a>
### Installation

⚠️ Under ~~development~~ constant development 

The installation script is made for Arch, but **may** work on some Arch based distros.   

THIS IS SPECIALLY TUNED FOR ASUS ( ROG & TUF ) LAPTOPS. </br>   

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

### Updating

If you have a working cynageOS installation, Checkout the github releases page under the cynageos tag and download the tarball file.
![image](https://github.com/user-attachments/assets/0da922f4-fbf4-4016-a680-ae2348890871)
</br>

Download the latest update and extract it.
![image](https://github.com/user-attachments/assets/fb031dd0-226b-4792-9c39-0e57454ba9bb)

</br>
Now Run the updateX_XX.sh file either in the terminal or by simply through the file manager.

![image](https://github.com/user-attachments/assets/9f55341a-1eee-4087-8a8a-ab52eda7719f)

### INSTALL ARCH
NOT TO BE USED AS A GUIDE. USE ONLY IF YOU KNOW WHAT YOU ARE DOING
```bash
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██░▀██░█▀▄▄▀█▄░▄█░▄▄█░▄▄█████
██░█░█░█░██░██░██░▄▄█▄▄▀█▀▀██
██░██▄░██▄▄███▄██▄▄▄█▄▄▄█▄▄██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
INSTALL arch
1] <iwctl> - station 'device' get-networks
	     station 'device' connect 'ssid'

2] <pacman -Sy> and <pacman -Sy archlinux-keyring>
	 
3] <lsblk> and <cfdisk> -  to get the partition names and creating them
			   create EFI partition and linux filesystem 
			   and linux swap (optional)

4] <mkfs.fat -F32 '/dev/devicelocation'> - for boot partition
   <mkfs.ext4 '/dev/devicelocation'> - for root partition
   (optional)
   <mkswap '/dev/deviceloaction'> - for swap partition

5] <mount 'root partition' /mnt> - mounting the root partition into /mnt to access it
   <mkdir /mnt/boot> - making boot directory for linking boot partition with root partition
   <mount 'boot partition' /mnt/boot> - mounting bootpartition in /mnt/boot
   (optional)
   <swapon 'swap partition'> - to mount the swap partition

NOW lsblk should give the mounted output

6] <pacstrap -i /mnt base base-devel linux linux-firmware git sudo neofetch htop 'intel-ucode' nano vim bluez bluez-utils 'networkmanager'>  - installing basic linux and its packages in mnt root partition
																	       REMEMBER replace intel-ucode with amd-ucode for amd processors and use the 
																	       tools of your liking (bluez and networkmanager)	

7] <genfstab -U /mnt >> /mnt/etc/fstab> - generating file system and check if it is generated with <cat /mnt/etc/fstab>

NOW to chroot into /mnt and finish settingup arch linux

8] <arch-chroot /mnt> - change root into /mnt
   <passwd> - set password
   <useradd -m -g users -G wheel, storage, power, video, audio -s /bin/bash 'username'> - replace username with your user name
   <passwd 'username'>
   <visudo> - HERE uncomment to allow members of group wheel to execute any command
   
9] <su - 'username'> - superuser into the username
   <sudo pacman -Syu> - update archlinux
   <exit> - exit out of superuser

10]<ln -sf /usr/share/zoneinfo/'zone' /etc/localtime> - use tab space after zoneinfo/ to find the zones available and type it in zone
   <hwclock --systohc> 
   <nano /etc/locale.gen> - select language (for english us en-US UTF-8) 
   <locale-gen> - genrate locale
   <nano /etc/locale.conf> -> LANG=en_US.UTF-8
   <nano /etc/hostname> -> 'computername' 
   <nano /etc/hosts> -> 127.0.0.1		 localhost
			::1			 localhost
			127.0.1.1 		 'computername'.localdomain		'computername'

11]<pacman -S grub efibootmgr dosfstools mtools os-prober> - install efi tools 
   <grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id='bootloader_name'> - installing grub in /boot
   <grub-mkconfig -o /boot/grub/grub.cfg> - enable osprober before this step to show other os in grub menu
   
ENABLING system services

12]<systemctl enable bluetooth>
   <systemctl enable NetworkManager>

EXIT and unmounting

13]<exit>
   <umount -lR /mnt>
   <shutdown now>
```

### Theming
To add your own custom theme, please refer [theming.md](https://github.com/ekahPruthvi/cynageOS/blob/main/theming.md)
- Available themes
    - [x] Cynage
    - [x] Lightage
    - [x] Developer
    - [x] Rosé-Pine
    - [x] Graphite-Mono

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

This install script and some modules has been adopted from hyprdots with modifications.
quickshell config is adopted from (caelestia-dots)[https://github.com/caelestia-dots/shell?tab=readme-ov-file] with little modification 
