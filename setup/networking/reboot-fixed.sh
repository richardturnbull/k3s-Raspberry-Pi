#!/bin/sh
ansible all -i ../../inventory.pi -m shell -a "sleep 1s; shutdown -r now" -b -B 60 -P 0
