## 🛡️ Shaun’s Ubuntu Update & Privacy Script

A balanced update and cleanup script that keeps your system secure, clean, and still debuggable.

---

## ⚙️ Features

## 🔄 System Updates
- Bypasses phased updates  
- Updates package lists  
- Runs:
  - `apt upgrade`
  - `apt full-upgrade`
- Removes unused packages (`autoremove`)  
- Cleans package cache  

### 💻 Firmware Updates
- Refreshes firmware metadata  
- Checks for updates  
- Applies updates via `fwupdmgr`  

---

## 🔒 Privacy (Lite Mode)
Non-destructive cleanup that improves privacy without breaking diagnostics.

---

## 🧾 Logs (Preserved & Trimmed)
- Logs are **rotated, not deleted**  
- Journal logs trimmed (e.g. last 7 days)  
- APT & dpkg logs preserved  

✔ Useful for:
- Debugging  
- Update tracking  
- System auditing  

---

## 🌐 Network & Tool Cleanup
- Removes `wget` HSTS files  
- Keeps `curl` configs (may contain user settings)  

------

## ⚠️ Notes
Designed for Ubuntu-based systems
Uses safe defaults (non-destructive cleanup)
Review script before running on critical systems
Update paths and usernames to match your setup
## 📌 Philosophy
Clean enough for privacy, but not so clean that you lose visibility.

## 🧑‍💻 User Cleanup
- Clears:
  - Thumbnail cache  
  - Temp files (`/tmp`, `/var/tmp`)  
- Keeps:
  - Bash history  
  - User config files  

---

## 🌍 Brave Browser Cleanup
- Clears cache and browsing data (history, cookies, sessions)  
- Optional full wipe available (disabled by default)  

---

## 🔁 Run as a Systemd Service
## 1. Allow Passwordless sudo
Edit sudoers:
sudo visudo
Add (replace username and path):
Bash
my-pc ALL=(root) NOPASSWD: /home/my-pc/Documents/Notes/Scripts/System-update-and-privacy-cleanup.sh
## 2. Create Service sudo nano /etc/systemd/System-update-and-privacy-cleanup.

[Unit]
Description=Automatic System Update Script
After=network.target

[Service]
Type=simple
ExecStart=/home/my-pc/Documents/Notes/Scripts/System-update-and-privacy-cleanup.sh
WorkingDirectory=/home/my-pc/Documents/Notes/Scripts
Restart=on-failure
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

[Install]

WantedBy=multi-user.target
## 3. Enable & Start
sudo systemctl daemon-reload
sudo systemctl enable --now auto-update.service
## 4. Check Logs
journalctl -u auto-update.service -e
## 🚀 Usage
nano System-update-and-privacy-cleanup.sh
sudo ./System-update-and-privacy-cleanup.sh
