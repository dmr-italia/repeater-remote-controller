#!/bin/bash

echo "
###############################################################################
###   Update the package list from the repository
###############################################################################
"
sudo apt-get update

echo "
###############################################################################
###   Install OpenVPN
###############################################################################
"
sudo apt-get install -y openvpn

echo "
###############################################################################
###   Remove old copies of VirtualHere server
###############################################################################
"
if [ -f ./vhusbdarm ]; then
    rm ./vhusbdarm*
fi
if [ -f /usr/sbin/vhusbdarm ]; then
    rm /usr/sbin/vhusbdarm*
fi

echo "
###############################################################################
###   Download VirtualHere server for ARM architecture
###############################################################################
"
wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm

echo "
###############################################################################
###   Install VirtualHere server
###############################################################################
"
chmod +x ./vhusbdarm
mv ./vhusbdarm /usr/sbin

