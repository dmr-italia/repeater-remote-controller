#!/bin/bash

#echo "Type the OpenVPN client certificate id that has been sent to you (12 characters), followed by [ENTER]:"
#read OVPN

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
mv -f ./vhusbdarm /usr/bin

echo "
###############################################################################
###   Install OpenVPN client certificate $1 into /etc/openvpn/client folder
###############################################################################
"
rm ./$1
wget http://www.dmr-italia.it/ovpn/$1
openssl enc -d -aes-256-cbc -md sha256 -pass pass:$1 -in ./$1 > /etc/openvpn/${1}.conf

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
systemctl enable openvpn@$1
systemctl enable virtualhere
systemctl start openvpn@$1
systemctl start virtualhere

echo "
###############################################################################
###   Setup complete!
###   Now you should reboot your Raspberry PI with command:

sudo reboot

###############################################################################
"
