**script code...**
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


**Make run as systemd service...**
sudo visudo:    Added line: my-pc ALL=(root) NOPASSWD: /home/my-pc/Documents/Notes/Scripts/auto-update.sh
Edit sudoers (sudo visudo) → Allow my-pc to run auto-update.sh as root without a password.

sudo nano /etc/systemd/system/auto-update.service:    Create systemd service (sudo nano /etc/systemd/system/auto-update.service) → Define the script as a service.

[Unit]
Description=Run Auto Update Script
After=network.target

[Service]
ExecStart=/home/my-pc/Documents/Notes/Scripts/auto-update.sh
Restart=on-failure
# Remove User= line so it defaults to root
WorkingDirectory=/home/my-pc/Documents/Notes/Scripts
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload:  Reload systemd sudo systemctl daemon-reload) → Apply the new service configuration.

sudo systemctl restart auto-update.service:  Start/restart service (sudo systemctl restart auto-update.service) → Run the script via systemd.

journalctl -u auto-update.service -e:    Check logs (journalctl -u auto-update.service -e) → View the service output and any errors.
