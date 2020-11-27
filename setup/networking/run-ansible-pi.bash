#!/bin/bash

docker run \
-v "$(PWD)":/work \
-v ~/.ssh:/root/.ssh:ro \
--rm \
docker-ansible ansible-playbook -i inventory main.yml
