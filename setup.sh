#!/bin/bash

sudo apt-get update && sudo apt-get install -y openvpn

if [ -f ./vhusbdarm ]; then
    rm ./vhusbdarm*
fi
wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm
chmod +x ./vhusbdarm
cp ./vhusbdarm /usr/sbin