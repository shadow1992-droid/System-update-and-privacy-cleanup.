LP# 🛡️ Shaun’s Ubuntu Update & Privacy Script

A balanced update and cleanup script that keeps your system secure, clean, and still debuggable.

---

## ⚙️ Features

### 🔄 System Updates
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

## 🔁 Run as a Systemd Service
1. Allow Passwordless sudo
Edit sudoers:
Bash
sudo visudo
Add (replace username and path):
Bash
my-pc ALL=(root) NOPASSWD: /home/my-pc/Documents/Notes/Scripts/auto-update.sh
2. Create Service
Bash
sudo nano /etc/systemd/system/auto-update.service
Paste:
INI
```[Unit]
Description=Automatic System Update Script
After=network.target

```[Service]
Type=simple
ExecStart=/home/my-pc/Documents/Notes/Scripts/auto-update.sh
WorkingDirectory=/home/my-pc/Documents/Notes/Scripts
Restart=on-failure
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

```[Install]
WantedBy=multi-user.target
3. Enable & Start
Bash
sudo systemctl daemon-reload
sudo systemctl enable --now auto-update.service
4. Check Logs
Bash
journalctl -u auto-update.service -e
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

## 🚀 Usage

```bash
nano update-lite.sh
chmod +x update-lite.sh
sudo ./update-lite.sh

