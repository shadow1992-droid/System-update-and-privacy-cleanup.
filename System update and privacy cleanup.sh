#!/bin/bash

# Must be run as root
if [[ $EUID -ne 0 ]]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

echo "Starting Shaun's Ubuntu system update and privacy cleanup complete. ✅"

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

# ============================
# PRIVACY / LOG CLEANING
# ============================

echo "Cleaning internet-related logs and traces..."

# Clear APT logs (package download history)
rm -f /var/log/apt/history.log
rm -f /var/log/apt/term.log

# Clear dpkg logs
rm -f /var/log/dpkg.log

# Rotate & aggressively clear system journal logs
journalctl --rotate
vacuum-time=7d

# Clear auth + syslog (network/login traces)
truncate -s 0 /var/log/auth.log 2>/dev/null
truncate -s 0 /var/log/syslog 2>/dev/null

# Remove wget & curl traces
rm -f /root/.wget-hsts
rm -f /home/*/.wget-hsts 2>/dev/null
rm -f /home/*/.curlrc 2>/dev/null

# Clear bash history (root + all users)
history -c
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/*/.bash_history 2>/dev/null

# Clear thumbnail cache (downloaded images, previews)
rm -rf /home/*/.cache/thumbnails/* 2>/dev/null

# Clear common browser caches
rm -rf /home/*/.cache/mozilla/* 2>/dev/null
rm -rf /home/*/.cache/google-chrome/* 2>/dev/null
rm -rf /home/*/.cache/chromium/* 2>/dev/null

# Flush DNS cache
resolvectl flush-caches 2>/dev/null

# ============================
# BRAVE BROWSER CLEANING
# ============================

echo "Cleaning Brave browser data..."

# Remove cache
rm -rf /home/*/.cache/BraveSoftware/Brave-Browser/* 2>/dev/null

# Remove browsing data (history, cookies, logins, etc.)
find /home/*/.config/BraveSoftware/Brave-Browser/ -type f \( \
  -name "History" -o \
  -name "History-journal" -o \
  -name "Cookies" -o \
  -name "Cookies-journal" -o \
  -name "Web Data" -o \
  -name "Web Data-journal" -o \
  -name "Login Data" -o \
  -name "Login Data-journal" -o \
  -name "Top Sites" -o \
  -name "Visited Links" \
\) -exec rm -f {} \; 2>/dev/null

# Uncomment for FULL wipe (bookmarks, extensions, sessions)
# rm -rf /home/*/.config/BraveSoftware/Brave-Browser/*

echo "Brave data cleaned."

# ============================
# FINAL TEMP CLEANUP
# ============================

echo "Cleaning temporary files..."
rm -rf /tmp/*
rm -rf /var/tmp/*

echo "System update and privacy cleanup complete. ✅"
