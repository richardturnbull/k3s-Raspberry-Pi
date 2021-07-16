#!/bin/sh
rm ~/.ssh/known_hosts
for ip in 192.168.1.58 192.168.1.59 192.168.1.142 192.168.1.179; do
    ssh-keyscan -t rsa,dsa -H $ip >> ~/.ssh/known_hosts
    ssh-copy-id -i ~/.ssh/kubes.pub ubuntu@$ip
done


