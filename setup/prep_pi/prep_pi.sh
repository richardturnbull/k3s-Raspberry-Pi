#!/bin/sh
diskutil unmountDisk /dev/disk2
pv ./ubuntu-20.04-preinstalled-server-arm64+raspi.img | sudo dd bs=1m of=/dev/rdisk2
#diskutil mountDisk /dev/disk2
sleep 4
#touch /Volumes/boot/ssh
diskutil unmountDisk /dev/disk2
diskutil eject /dev/disk2
echo "Ready to remove SD card"