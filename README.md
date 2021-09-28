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
 Install docker & docker compose. Follow the link https://docs.docker.com/engine/install/debian/ for how to . 
 
 #Bitcoin node folder structure 
 btc(parent folder) and below are subfolders
bitcoin  bos  docker-compose.yml lnd	rtl  th  tor
./btc/tor:
build  etc  lib
./btc/tor/build:
Dockerfile

./btc/tor/etc:
torrc

./btc/tor/lib:
cached-certs  cached-microdesc-consensus  cached-microdescs  cached-microdescs.new  control_auth_cookie  keys  lock  onionweb  state

./btc/tor/lib/keys:

./btc/tor/lib/onionweb:
authorized_clients  hostname  hs_ed25519_public_key  hs_ed25519_secret_key

./btc/tor/lib/onionweb/authorized_clients:


