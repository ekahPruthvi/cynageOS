<p align="center">
    <img align="center" width="49%" src="https://raw.githubusercontent.com/ekahPruthvi/cynageOS/main/Source/Pictures/COSlogo/cynageOS.png" /> 
</p>

# cynageOS
The Project overtaken by SCU </br>
> update .5.0.1
</br>
cynageOS, an innovative operating system that is meticulously crafted to boost productivity. </br>
The design philosophy revolves around minimizing distractions while providing an aesthetically pleasing experience.</br>
By combining modern aesthetics with user-friendly interfaces. </br></br>

> [!CAUTION]
> The source code is being updated from `.4.9` to `5.0.0`
> Please wait a couple of days

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

<details>
<summary><h4>Packages</h4></summary>

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

</details>
