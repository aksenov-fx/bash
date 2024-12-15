#!/bin/bash

set -euxo pipefail

#Install ssh
    sudo apt update
    sudo apt install -y openssh-server curl

    sudo systemctl enable ssh --now

    if [ -x "$(command -v ufw)" ]; then
        sudo ufw allow ssh
    fi

# Add ssh key
    mkdir -p ~/.ssh
    curl https://github.com/aksenov-fx.keys >> ~/.ssh/authorized_keys
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

# Disable password authentication
    #sudo sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    #sudo sed -i 's/^#\?PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Download ssh config
    timestamp=$(date +%Y%m%d_%H%M%S)
    sudo mv /etc/ssh/sshd_config "/etc/ssh/sshd_config_${timestamp}.bak"
    sudo wget -P /etc/ssh/ https://raw.githubusercontent.com/aksenov-fx/bash/main/sshd_config

# Restart ssh
    sudo systemctl restart ssh

echo SSH was configured successfully