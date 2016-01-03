#!/bin/bash	

BASEURL=http://os.archlinuxarm.org/os/
RPI=ArchLinuxARM-rpi-latest.tar.gz
RPI2=ArchLinuxARM-rpi-2-latest.tar.gz
ARMV6IMG=arch-linux-armv6-$(date +%Y%m%d).img
ARMV7IMG=arch-linux-armv7-$(date +%Y%m%d).img

echo -e "\n==============================================="
echo -e " Arch Linux ARM image creator for Raspberry Pi "
echo -e "==============================================="
echo -e "\nEnter your choice:\n"

options=("Raspberry Pi   (ARMv6)" "Raspberry Pi 2 (ARMv7)" "Quit")

create_image(){
	losetup /dev/loop0 && exit 1 || true
	wget -N $1
	truncate -s 1G $2
	losetup /dev/loop0 $2
	parted -s /dev/loop0 mklabel msdos
	parted -s /dev/loop0 unit MiB mkpart primary fat32 -- 1 32
	parted -s /dev/loop0 set 1 boot on
	parted -s /dev/loop0 unit MiB mkpart primary ext2 -- 32 -1
	parted -s /dev/loop0 print
	mkfs.vfat -n SYSTEM /dev/loop0p1
	mkfs.ext4 -L root -b 4096 -E stride=4,stripe_width=1024 /dev/loop0p2
	mkdir -p arch-boot
	mount /dev/loop0p1 arch-boot
	mkdir -p arch-root
	mount /dev/loop0p2 arch-root
	bsdtar -xpf $3 -C arch-root
	sed -i "s/ defaults / defaults,noatime /" arch-root/etc/fstab
	mv arch-root/boot/* arch-boot/
	umount arch-boot arch-root
	losetup -d /dev/loop0
}

select option in "${options[@]}"; do
	case "$REPLY" in 
		1)
			IMG=$ARMV6IMG
			URL=$BASEURL$RPI
			create_image $URL $IMG $RPI
			break ;;
		2)
			IMG=$ARMV7IMG
			URL=$BASEURL$RPI2
			create_image $URL $IMG $RPI2
			break ;;
		3)
			break ;;
	esac
done
