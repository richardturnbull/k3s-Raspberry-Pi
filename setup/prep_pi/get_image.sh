#!/bin/sh
os_release="20.04"
os_image="ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz"
download_url="http://cdimage.ubuntu.com/releases/${os_release}/release/${os_image}"
curl -v "${download_url}" -o ${os_image}
