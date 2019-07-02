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
###   Install VirtualHere server into /usr/sbin folder
###############################################################################
"
chmod +x ./vhusbdarm
mv -f ./vhusbdarm /usr/sbin

echo "
###############################################################################
###   Install OpenVPN client certificate $OVPN into /etc/openvpn/client folder
###############################################################################
"
wget http://www.dmr-italia.it/ovpn/$OVPN
openssl enc -d -aes-256-cbc -pass pass:$1 -in ./$1 > /etc/openvpn/client/$1

echo "
###############################################################################
###   Configure OpenVPN and VirtualHere server for automatic startup
###############################################################################
"
cat <<EOF > /etc/systemd/system/virtualhere.service
Description=VirtualHere USB Sharing
Requires=avahi-daemon.service
After=avahi-daemon.service
[Service]
ExecStartPre=/bin/sh -c 'logger VirtualHere settling...;sleep 1s;logger VirtualHere settled'
ExecStart=/usr/bin/vhusbdarm
Type=idle
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable openvpn@client
systemctl enable virtualhere
systemctl start openvpn@client
systemctl start virtualhere

echo "
###############################################################################
###   Setup complete!
###   Now you should reboot your Raspberry PI with command:

sudo reboot

###############################################################################
"
