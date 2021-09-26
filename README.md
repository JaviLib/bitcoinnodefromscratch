# Bitcoin node from scratch

This tutorial shows you how to install a Bitcoin node with lightning and several applications from scratch, using Docker technology.

## Why?

You may be asking why not install Umbrel directly? Umbrel is great, but still there are several reasons why you may want to install your own node from scratch:

- You want to fine tune everything, up to any possible parameter, in any application.
- You want to learn how a Bitcoin node works from the inside out, understand the magic happening in the background.
- You want to be able to choose versions of everything.
- You want to have custom network requirements, including having both an static IP or Tor, or advanced inverse socks proxy from an VPN.
- Stack sats

The tutorial is to install the node on Linux(Debian) system and can be modified to be installed on other OS.

Install the latest debian OS
2. Copy the iso image from hdd/ssd to usb use the command
 sudo dd if=~/Downloads/*.iso of=/dev/sda bs=1M status=progress
 the usb has to be mounted and use fdisk -l or lsblk to identify the usb device.

3. Add user to sudoers

 add user to sudoers
sudoers list is in etc/sudoers
sudo adduser <<username>> sudo
4.Docker
 Install docker & docker compose
https://docs.docker.com/engine/install/debian/
