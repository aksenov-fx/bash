#!/bin/bash
#for non-Debian systems

set -e

if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

apt update
apt install -y build-essential linux-headers-$(uname -r)

mkdir -p /mnt/cdrom
mount /dev/cdrom /mnt/cdrom || echo "Please insert VMware Tools CD first"

cd /tmp
cp /mnt/cdrom/VMwareTools-*.tar.gz .
tar xzf VMwareTools-*.tar.gz
cd vmware-tools-distrib
./vmware-install.pl -d

# Cleanup
cd /
rm -rf /tmp/vmware-tools-distrib
rm -f /tmp/VMwareTools-*.tar.gz
umount /mnt/cdrom

reboot