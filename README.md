# Arch Linux ARM image creator for Raspberry Pi
Shell script that creates an Arch Linux image for the Raspberry Pi 1 or 2

Tested on CentOS Linux release 7.2.1511 x86_64

## Prerequisites
- bsdtar
- dosfstools
- parted
- wget

#Installation
Download the script and make it executable:
```sh
$ wget https://raw.githubusercontent.com/ivanmarban/arch-linux-raspberry-pi-image-creator/master/image-creator.sh
$ chmod +x image-creator.sh
```
Flash the created image to your SD Card
```sh
$ dd bs=4M if=arch-linux-X-XXXXXXXX.img of=/dev/sdX
```
