#!/bin/bash

set -euxo pipefail

echo "Updating package list..."
    sudo apt-get update

echo "Installing prerequisites..."
    sudo apt-get install -y wget apt-transport-https software-properties-common

echo "Registering Microsoft repository GPG keys..."
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

echo "Adding Microsoft package repository..."
    sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main"

echo "Updating package list again..."
    sudo apt-get update

echo "Installing PowerShell..."
    sudo apt-get install -y powershell

echo "Enabling SSHRemoting..."
    pwsh -Command "Install-Module -Name Microsoft.PowerShell.Remotingtools -Force -AllowClobber"

echo "Enabling PSRemoting..."
    pwsh -Command "Enable-SSHRemoting -Force"

echo "Verifying PowerShell installation..."
    pwsh -Command "\$PSVersionTable"

echo "Restarting SSH service..."
    sudo systemctl restart ssh
