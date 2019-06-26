#!/bin/bash

sudo apt-get update && sudo apt-get install -y openvpn

wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm
chmod +x ./vhusbdarm
cp ./vhusbdarm /usr/sbin