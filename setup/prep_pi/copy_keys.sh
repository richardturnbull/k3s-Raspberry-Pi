#!/bin/sh
rm ~/.ssh/known_hosts
for ip in 192.168.179.190 192.168.179.169 192.168.179.130 192.168.179.93; do
    ssh-keyscan -t rsa,dsa -H $ip >> ~/.ssh/known_hosts
    ssh-copy-id -i ~/.ssh/kubes.pub ubuntu@$ip
done


