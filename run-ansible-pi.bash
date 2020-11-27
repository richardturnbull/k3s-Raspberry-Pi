#!/bin/bash

docker run \
-v "$(PWD)":/work \
--rm \
docker-ansible ansible-playbook -i inventory.pi main.yml
