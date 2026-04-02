#!/bin/bash

# Must be run as root
if [[ $EUID -ne 0 ]]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

echo "Starting Shauns Ubuntu system update..."

# Disable phased updates
echo 'APT::Get::Always-Include-Phased-Updates "true";' > /etc/apt/apt.conf.d/99phased-updates

# Update package list
echo "Updating package list..."
apt update

# Upgrade installed packages
echo "Upgrading installed packages..."
DEBIAN_FRONTEND=noninteractive \
apt -y -o Dpkg::Options::="--force-confdef" \
       -o Dpkg::Options::="--force-confold" \
upgrade

# Full upgrade (handles dependencies and kernel)
echo "Performing full upgrade..."
DEBIAN_FRONTEND=noninteractive \
apt -y -o Dpkg::Options::="--force-confdef" \
       -o Dpkg::Options::="--force-confold" \
full-upgrade

# Autoremove unused packages
echo "Autoremoving old packages..."
apt -y autoremove

# Clean up cache
echo "Cleaning up..."
apt clean

# Update firmware via fwupd
echo "Refreshing firmware metadata..."
fwupdmgr refresh

echo "Checking for firmware updates..."
fwupdmgr get-updates

echo "Applying firmware updates (if any)..."
fwupdmgr update

echo "Shauns System update complete. ✅"

