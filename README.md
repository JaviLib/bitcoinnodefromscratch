# Bitcoin node from scratch

This tutorial shows you how to install a Bitcoin node with lightning and several applications from scratch, using Docker technology.

## Why?

You may be asking why not install Umbrel directly? Umbrel is great, but still there are several reasons why you may want to install your own node from scratch:

- You want to fine tune everything, up to any possible parameter, in any application.
- You want to learn how a Bitcoin node works from the inside out, understand the magic happening in the background.
- You want to be able to choose versions of everything.
- You want to have custom network requirements, including having both an static IP (FQDN) or Tor, or advanced inverse socks proxy from an VPN.
- You want to install custom application to manage your node or having a Private App Server

## How 
# Debian Linux Installation 
The tutorial is to install the node on Linux(Debian) system and can be modified to be installed on other OS.

Install the latest Debian OS from https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.0.0+nonfree/amd64/iso-cd/firmware-11.0.0-amd64-netinst.iso. 
The ISO image is a miminum install and need to be connected to the internet when installing the OS from a flash drive.

Copy the iso image from hdd/ssd to flash/usb drive. The command
`sudo dd if=~/Downloads/*.iso(iso image location) of=/dev/sda bs=1M status=progress`
DD is a dangerous command so be careful when using it . 
The usb has to be mounted and use `fdisk -l` or `lsblk` to identify the usb device.

# Docker Installation
Install docker & docker compose. Follow the link https://docs.docker.com/engine/install/debian/ for how to.

# Alias for docker commands 
Create alias for docker in root's ./bash.rc file . Alias is like a shortcut to the actual command

alias dcub='dc build --pull && docker-compose pull --include-deps
            && docker-compose up --build  --detach'
alias dcu='docker-compose up --build --detach'
alias dc='docker-compose'
alias dc1='docker-compose logs --tail=2000'

# Bitcoin node folder structure 
btc (parent folder) and below are subfolders for each application.
`bitcoin  bos  docker-compose.yml lnd	rtl  th  tor`

# Tor application  
./btc/tor: tor has the below sub folders
build  etc  lib
build folder will hold the Dockerfile file. The Dockerfile is the basis for the build of the tor docker container.
etc folder will hold the torrc file.

# Bitcoin core 
  Folder structure bitcoin->bitcoin . This folder will hold the bitcoin blockchian data 
  Bitcoin.conf file is laso in the bitcoin->bitcoin folder.The .conf file contains the parameters to control the bitcon core
  File bitcoin->Dockerfile is to build the bitcoin core container .
  bitcoin-cli commands will not work directly as we have specified a specific ip address range to the rpcallowip parameter.
  To execture bitcoin core command we have to use "dc exec bitcoind bitcoin-cli -rpcconnect=10.19.0.10 (or any ip in the range) -getinfo
  Also you can create an alias for the command in root's ./bash.rc . alias bitcoin-cli = dc exec bitcoind bitcon-cli -rpcconnect=10.19.0.10 .
  
 
  


