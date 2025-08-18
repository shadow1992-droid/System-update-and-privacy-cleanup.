Auto-Update Script for Ubuntu

This repository contains a bash script to automatically update your Ubuntu system, including packages and firmware, with optional systemd integration to run it as a service.


---

Script: auto-update.sh

Description:
This script updates your Ubuntu system safely, performing package upgrades, cleaning unused packages, and updating firmware.

Usage:

sudo /path/to/auto-update.sh

Script Content:

#!/bin/bash

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

echo "Starting system update..."

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

# Remove old packages
echo "Autoremoving old packages..."
apt -y autoremove

# Clean package cache
echo "Cleaning up..."
apt clean

# Update firmware via fwupd
echo "Refreshing firmware metadata..."
fwupdmgr refresh

echo "Checking for firmware updates..."
fwupdmgr get-updates

echo "Applying firmware updates (if any)..."
fwupdmgr update

echo "System update complete. ✅"


---

Run Script as a Systemd Service

You can run this script automatically as a systemd service.

1. Allow passwordless sudo for the script

Edit sudoers:

sudo visudo

Add the line (replace my-pc and path as needed):

my-pc ALL=(root) NOPASSWD: /home/my-pc/Documents/Notes/Scripts/auto-update.sh

2. Create systemd service

Create the service file:

sudo nano /etc/systemd/system/auto-update.service

Add the following:

[Unit]
Description=Run Auto Update Script
After=network.target

[Service]
ExecStart=/home/my-pc/Documents/Notes/Scripts/auto-update.sh
Restart=on-failure
WorkingDirectory=/home/my-pc/Documents/Notes/Scripts
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

[Install]
WantedBy=multi-user.target

> Note: Do not include User= to run as root.



3. Reload systemd and start service

sudo systemctl daemon-reload
sudo systemctl enable --now auto-update.service

4. Check service logs

journalctl -u auto-update.service -e


---

✅ Your Ubuntu system will now update automatically via systemd.
