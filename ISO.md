
# Capsulator - Installer for cynageOS

> alpha testing 2

<b>Capsulator</b> is written in Rust. It uses the GTK4 toolkit for the graphical interface and VTE4 for terminal integration. The installer runs on the [cage](https://github.com/cage-kiosk/cage) Wayland kiosk display server.

## Pages
> ### 1
>> COS Signature cat eye animation for startup
> ### 2
>> Select internet (only if not connect already)
> ### 3
>> pacman keyring update (no script)
> ### 4
>> make partitions
>>>  - use `lsblk` to check
>>>  - use `cfdisk <disk>` for making partition, ex: cfdisk /dev/sda/
>>>  - use `exit` to move forward
> ### 5
>> mount and install arch linux
>> set user and password
>> <br>script: archincos.sh
> ### 6
>> Install dependecies and required programs
>> setup cynenv programs
>> finish configs
>> <br>script: cynsetupcos.sh
> ### 7
>> Finish
>> Information
 
