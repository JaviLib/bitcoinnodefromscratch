#!/bin/bash
# reset pending channels:
#https://github.com/lightningnetwork/lnd/issues/4991
#When lnd docker image is executed for the first time the wallet-unlock should be commented since we will create the wallet.
exec lnd --lnddir=/lnd --backupfilepath=/backup/channel.backup  #--wallet-unlock-password-file=/lnd/pass.txt
#During the second exectuion of the docker image we include the wallet command to unlock the wallet automatically .
exec lnd --lnddir=/lnd --backupfilepath=/backup/channel.backup  #--wallet-unlock-password-file=/lnd/pass.txt
