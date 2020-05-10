#!/bin/sh
sudo nmap -sP 192.168.179.0/24 | grep -B 2 Raspberry | grep "Nmap scan"