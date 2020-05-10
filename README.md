# Setting up a kubernetes cluster using Raspberry Pi's

A cluster of Raspberry Pi 4 running the lightweight [k3s](https://k3s.io/) implementation of Kubernetes.

## Why?

Mainly to learn about Kubernetes and Ansible. I started from the excellent work done by [Jeff Geerling](https://github.com/geerlingguy) with the [Pi Dramble Project](http://www.pidramble.com/). Lots of the code here is from his project.

## Hardware setup

There are lot's of tutorials on how to set up the hardware. A brilliant starting point is the [Dramble project](http://www.pidramble.com/wiki/hardware).

I used 4 Raspberry Pi 4s with 4GB RAM.

## Preparing the Raspberry Pi

[Rasbian](https://www.raspberrypi.org/downloads/raspbian/) is the officially supported OS for the Raspberry Pi but it only comes in a 32-bit build and I wanted to get a bit more bleeding edge. I went for [Ubuntu 20.04 (Focal Fossa)](https://ubuntu.com/download/raspberry-pi).

These instructions are for macOS, and will be considerably different on Linux or Windows.

Here are the main steps to prepare the machines:

1. Download the 64-bit Ubuntu image for the Raspberry. There is a convenience script `/setup/prep_pi/get_image.sh` to help with this.
2.  The image is an xz archive, so you will need to have installed xz using [Homebrew](https://brew.sh/).
3. Flash the image to the SD card. Insert the SD card into the Mac using a USB or  microSD adapter accoridng to the model of Mac you're using. `diskutil list` will show you which device has been allocated to the SD card. Then run the following commands:
    ```
    diskutil unmountDisk /dev/disk<your disk>
    pv ./ubuntu-20.04-preinstalled-server-arm64+raspi.img | sudo dd bs=1m of=/dev/rdisk<your disk>
    diskutil eject /dev/disk<your disk>
    ```
Do this for all 4 SD cards. There is a script `prep_pi.sh` which you can modify to help automate the steps.
1. Put the SD cards into each Raspberry Pi and power them on.


## Setting up networking
The Raspberry Pis will have booted and been assigned IP addresses by your home router's DHCP service. We need to give them fixed IPs. Rummage about in your router's admin console to find out which addresses are on the same IP subnet but will not be allocated using DHCP.

Then we need to find out what the MAC and IP addresses of the PI's are now, so we can make the required changes to the networking configuration on each device. The easiest way to do this is you use your router's admin console. Alternatively, you can run `nmap -sP <192.168.100.0/24>` replacing the network with your own.

You will need to ssh into each device and change the password to something sensible. `ssh ubuntu@<deviceip>`. Then you need to generate ssh keys using `ssh-key-gen` and copy them across. There is a script `copy_keys.sh` to help with this. Store the private and public keys in your .ssh directory and modify `.ssh/config` to your taste.

In the `/setup/networking/` directory, copy the `vars.yml.example` to 'vars.yml' and make the required changes. The IP addresses in this file are the desired, fixed IP addresses that work for your network.

Also copy `inventory.example` to `inventory` and make the required changes. The IP addresses in this file are the ones that your router has assigned.

Once this prep is all done, run `ansible-playbook -i inventory main.yml`. This will make all the changes required to allocated the fixed IP addresses to the raspberry Pi devices and reboot them all.

## Setting up K3S

Make the required changes to `inventory.pi` to suit your network, the SSH keys and the extra k3s args. k3s comes with an older version of Traefik, so I decided to exclude it.

There are some galaxy roles required for the main playbook to run. To get these, run `ansible-galaxy install -r requirements.yml`

To set up the cluster, run `ansible-playbook -i inventory.pi main.yml`. After about 5 minutes, you will have working k3s cluster on your machines.

Install kubectl from Homebrew (`brew install kubectl`) so you can access the cluster. The last step in the playbook will deliver a config file (`config-pi`) into the project root and you need to point kubectl at this, using `export KUBECONFIG=$(pwd)/config-pi`.

To test if the cluster is up and running, run `kubectl get nodes`. Success will look like this:
```
NAME    STATUS   ROLES    AGE   VERSION
kube4   Ready    <none>   15h   v1.17.5+k3s1
kube3   Ready    <none>   15h   v1.17.5+k3s1
kube2   Ready    <none>   15h   v1.17.5+k3s1
kube1   Ready    master   15h   v1.17.5+k3s1
```

## Vagrant
For testing, there is a Vagrantfile which will bring up a 4-node cluster based on Ubtuntu. Run `vagrant up` to bring up the cluster.
