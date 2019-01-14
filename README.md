# Arch Linux ARM image creator for Raspberry Pi
Shell script that creates an Arch Linux image for the Raspberry Pi 1, 2 or 3

Tested on CentOS Linux release 7.2.1511 x86_64

## Prerequisites
- bsdtar
- dosfstools
- parted
- wget

## Installation
Download the script and make it executable:
```sh
$ wget https://raw.githubusercontent.com/ivanmarban/arch-linux-raspberry-pi-image-creator/master/image-creator.sh
$ chmod +x image-creator.sh
```
Flash the created image to your SD Card
```sh
$ dd bs=4M if=arch-linux-X-XXXXXXXX.img of=/dev/sdX
```

## Troubleshooting
If you are getting messages like:
```sh
bsdtar: Ignoring malformed pax extended attribute
```
Try bsdtar 3.3.2:
```sh
wget https://www.libarchive.org/downloads/libarchive-3.3.2.tar.gz
tar xzf libarchive-3.3.2.tar.gz
cd libarchive-3.3.2
./configure
make
sudo make install
```
