#!/bin/bash
set -e

STORAGE_PATH="/mnt/k8s-storage"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit 1
fi

# Create storage directory
mkdir -p $STORAGE_PATH

# Install snapd
apt update
apt install -y snapd
systemctl enable --now snapd

# Wait for snapd service
sleep 5

# Configure system snap directory
echo "SNAP_COMMON=$STORAGE_PATH" >> /etc/environment
export SNAP_COMMON=$STORAGE_PATH

# Set directory permissions
chown -R root:root $STORAGE_PATH
chmod 755 $STORAGE_PATH

# Install microk8s
snap install microk8s --classic

# Configure microk8s storage
snap set microk8s storage.path=$STORAGE_PATH

# Restart snapd to apply changes
systemctl restart snapd

echo "MicroK8s installed at $STORAGE_PATH"
echo "Check status with: microk8s status"