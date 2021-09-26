# Bitcoin node from scratch

This tutorial shows you how to install a Bitcoin node with lightning and several applications from scratch, using Docker technology.

## Why?

You may be asking why not install Umbrel directly? Umbrel is great, but still there are several reasons why you may want to install your own node from scratch:

- You want to fine tune everything, up to any possible parameter, in any application.
- You want to learn how a Bitcoin node works from the inside out, understand the magic happening in the background.
- You want to be able to choose versions of everything.
- You want to have custom network requirements, including having both an static IP or Tor, or advanced inverse socks proxy from an VPN.
- Stack sats

##How 
#Debian Linux Installation 
The tutorial is to install the node on Linux(Debian) system and can be modified to be installed on other OS.

Install the latest debian OS from https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.0.0+nonfree/amd64/iso-cd/firmware-11.0.0-amd64-netinst.iso. The ISO image is a miminum install and need to be connected to the internet when installing the OS from a flash drive.

Copy the iso image from hdd/ssd to flash/usb drive.The command sudo dd if=~/Downloads/*.iso(iso image location) of=/dev/sda bs=1M status=progress. DD is a dangerous command so be careful when using it . 
The usb has to be mounted and use fdisk -l or lsblk to identify the usb device.

#Docker Installation 
 Install docker & docker compose https://docs.docker.com/engine/install/debian/
Install using the repository
Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.
--Set up the repository

    Update the apt package index and install packages to allow apt to use a repository over HTTPS:

 sudo apt-get update

 sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
--Add Docker’s official GPG key:
 curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
 
-- Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below. Learn about nightly and test channels.

    Note: The lsb_release -cs sub-command below returns the name of your Debian distribution, such as helium. Sometimes, in a distribution like BunsenLabs Linux, you might need to change $(lsb_release -cs) to your parent Debian distribution. For example, if you are using BunsenLabs Linux Helium, you could use stretch. Docker does not offer any guarantees on untested and unsupported Debian distributions.
  ---  echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
-- Install Docker Engine 
   sudo apt-get update, sudo apt-get install docker-ce docker-ce-cli containerd.io
