#!/bin/bash

# exit script on errors:
set -o errexit

#-----------------------------------------
# this script installs dashy on debian 11.
# if installed on proxmox or lxc container
# make sure to use 2 CPUs & 1024Mb RAM!
#-----------------------------------------

# first update the system
apt update && apt full-upgrade
# install required packages.
apt install git curl net-tools
# install node.js version 16.x
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo bash -
apt update
apt install -y nodejs
apt update && apt upgrade -y
# remove cmdtest
apt remove --purge cmdtest
apt autoremove
# prepare yarn installation
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt update
apt install yarn
# download dashy
cd /opt/
git clone https://github.com/Lissy93/dashy.git
cd /opt/dashy/
# install dashy dependencies
yarn
# set the max amount of memory used for building dashy
export NODE_OPTIONS=--max-old-space-size=1000
# build dashy
yarn build
# create a system service for dashy
cat <<EOF > /etc/systemd/system/dashy.service
[Unit]
Description=Dashy
After=network.target
[Service]
Type=simple
ExecStart=/usr/bin/yarn --cwd /opt/dashy/ start
[Install]
WantedBy=multi-user.target
Alias=Dashy
EOF
# enable the service for systemctl
systemctl enable dashy
# starting dashy.service
systemctl start dashy
# final output
echo congratulations, script finished without errors!
