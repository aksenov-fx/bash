#!/bin/bash

#Install ssh
    sudo apt update
    sudo apt install -y openssh-server

    sudo systemctl enable ssh --now

    sudo ufw allow ssh

# Add ssh key
    curl https://github.com/aksenov-fx.keys >> ~/.ssh/authorized_keys
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

# Download ssh config
    sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
    sudo wget -P /etc/ssh/ https://raw.githubusercontent.com/aksenov-fx/bash/main/sshd_config

# Disable password authentication
    #sudo sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    #sudo sed -i 's/^#\?PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Restart ssh
sudo systemctl restart ssh