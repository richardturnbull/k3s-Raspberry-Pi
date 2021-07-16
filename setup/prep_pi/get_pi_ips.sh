#!/bin/sh
sudo nmap -sP 192.168.1.0/24 | grep -B 2 Raspberry | grep "Nmap scan"