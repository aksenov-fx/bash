#!/bin/bash

# Exit on any error
set -e

# Variables (modify these)
DEVICE="/dev/sdb"
MOUNT_POINT="/mnt/k8s-storage"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Create partition
echo "Creating partition on ${DEVICE}"
parted ${DEVICE} mklabel gpt
parted -a optimal ${DEVICE} mkpart primary ext4 0% 100%

# Format partition
echo "Formatting ${DEVICE}1 with ext4"
mkfs.ext4 ${DEVICE}1

# Create mount point
echo "Creating mount point ${MOUNT_POINT}"
mkdir -p ${MOUNT_POINT}

# Get UUID of new partition
UUID=$(blkid -s UUID -o value ${DEVICE}1)

# Add to fstab
echo "Adding to /etc/fstab"
echo "UUID=${UUID} ${MOUNT_POINT} ext4 defaults 0 2" >> /etc/fstab

# Mount the partition
echo "Mounting partition"
mount ${MOUNT_POINT}

# Verify mount
df -h ${MOUNT_POINT}

echo "Setup complete"