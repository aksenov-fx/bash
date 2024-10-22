#!/bin/bash

sudo apt update
sudo apt install -y openssh-server

sudo systemctl enable ssh --now

sudo ufw allow ssh

curl https://github.com/aksenov-fx.keys >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

sudo systemctl restart ssh