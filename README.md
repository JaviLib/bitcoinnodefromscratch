# Bitcoin node from scratch

This tutorial shows you how to install a Bitcoin node with lightning and several applications from scratch, using Docker technology.

## Why?

You may be asking why not install Umbrel directly? Umbrel is great, but still there are several reasons why you may want to install your own node from scratch:

- You want to fine tune everything, up to any possible parameter, in any application.
- You want to learn how a Bitcoin node works from the inside out, understand the magic happening in the background.
- You want to be able to choose versions of everything.
- You want to have custom network requirements, including having both an static IP (FQDN) or Tor, or advanced inverse socks proxy from an VPN.
- You want to install custom application to manage your node or having a Private App Server

## Which apps will contain?

Starting from Bitcoin Core and LND as base we will start adding some apps and tools that are needed for a smooth and efficient node management.

- Electrum Server in Rust - electrs https://hub.docker.com/r/iangregsondev/electrs
- RTL (Ride the Lightning) - https://github.com/Ride-The-Lightning/RTL
- Thunderhub - https://github.com/apotdevin/thunderhub
- and other apps to be added

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
alias lncli='dc exec lnd lncli'

# Bitcoin node folder structure 
btc (parent folder) and below are subfolders for each application.
`bitcoin  bos  docker-compose.yml lnd	rtl  th  tor`
Folder structure bitcoin->bitcoin. This folder will hold the bitcoin blockchian data 

# Tor application  
./btc/tor: tor has the below sub folders
build  etc  lib
build folder will hold the Dockerfile file. The Dockerfile is the basis for the build of the tor docker container.
etc folder will hold the torrc file.

# Bitcoin core 
Bitcoin.conf file is also in the bitcoin->bitcoin folder. The .conf file contains the parameters to control the bitcon core.
File bitcoin --> Dockerfile is to build the bitcoin core container.
bitcoin-cli commands will not work directly as we have specified a specific ip address range to the rpcallowip parameter.
To execture bitcoin core command we have to use:
`dc exec bitcoind bitcoin-cli -rpcconnect=10.19.0.10 -getinfo` (or any ip in the range)
Also you can create an alias for the command in root's ./bash.rc . alias bitcoin-cli = 'dc exec bitcoind bitcon-cli -rpcconnect=10.19.0.10'

If you already have a running node and to want improve the blockchain sync the below command can be executed 
`bitcoin-cli addnode <running node ipaddress>:8333 "onetry"`

Docker network : where docker containers can communicate with each other  
docker network create -d bridge --subnet 10.10.0.0/16 --gateway 10.10.0.1 bitcoin
this creates an external virtual interface so everybody in your machine can connect to it. It is very useful to do NAT and forwarding from an external server

# LND
The following steps will help us run lnd in a docker 
lnd file structure -
./btc/lnd : Dockerfile 
./btc/lnd: start.shbecause the lnd/lnd directory may contain gb of data, we are preventing docker to look into it, so create a .dockerignore inside lnd/
./btc/lnd/.dockerignore will have the value/text lnd . This is to inform the Dockerifle to ignore the folder lnd/lnd because lnd/lnd may contain gb of data .
./btc/lnd/lnd  : folder
./btc/lnd/lnd/lnd.conf: lnd configuration file to set various parameters for our lnd instance
./btc/lnd/lnd/pass.txt: password for your wallet 
Run docker command alias "dcu" in the folder where the docker-compose.yml file resides to build the image .
Once the image is built we will have below folder/files created. 
 -backup folder : This is the channel backup 
 - data folder 
 - tls.cert
 - tls.key
 - v3_onion_private_key : private key form which the node ,watchtower onion address is generated. This file is created when we first start the wallet . LND calls tor control and creates hidden service on the go .

Run the alias dcl lnd to check the lnd logs, also htop to check if lnd is running and using cpu.   
Run the command lncli create : to create your wallet  . * Please do not provide the cipher seed passphrase as you will not be able to unlock the wallet.
Once the wallet is created keep note of the 24 seed words .
In the start.sh file remove the comment # in the below command and run dcu again to unlock  the wallet. 
lnd --lnddir=/lnd --backupfilepath=/backup/channel.backup  #--wallet-unlock-password-file=/lnd/pass.txt
* Please take periodic backup of lnd/lnd directory (all the files) in a separate SSD or other location . This folder along with the wallet seed will help to restore funds if the node is down for some reason.
* If we backup only the lnd/lnd/backup folder then we can only recover the funds in the channel(force close of channels) but not really restore the channels.
In any situation if LND docker is not working  then we do the below :
- dcu down , this will stop the containers from running .
- Take a backup or copy files lnd.conf, pass.txt to a different folder and delete the lnd/lnd folder.
- make the dir lnd/lnd  and copy the files lnd.conf , pass.txt 
- dcu to start the containers,before you run this command #(comment out ) --wallet-unlock-password-file/lnd/pass.txt in start.sh,-, dcl lnd to check the lnd logs ,  dcl -f lnd will give realtime information of the lnd logs .
- lnc create:  to create the wallet .  
- again run dcu ,before you run it uncomment the code  --wallet-unlock-password-file/lnd/pass.txt in start.sh  to unlock the wallet.
Once your LND is up and running .
-Import the LND wallet seed to BW or any wallet that supports AZEED wallet .
-Compare the ZPUB of wallet imported to BW and the zpub of the LND wallet to know you have imported the wallet successfully . 
-lncli wallet account list to get the wallet YPUB/ZPUB information
-lncli newaddress p2wkh to get the wallet address in lncli.
-In order to use or scan the LND wallet QR codes we can do the follwoing
   . first generate the wallet address
   . qrencode -t UTF8 <<btc address >>


 







