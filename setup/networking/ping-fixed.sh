#!/bin/sh
ansible all -i inventory.fixed-ip -m ping
