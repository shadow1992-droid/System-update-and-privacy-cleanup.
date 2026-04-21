Shaun's Ubuntu Update & Privacy Script (Lite Version)
A safer, balanced version of the update script that:
Keeps important system logs for troubleshooting
Performs full system + firmware updates
Cleans unnecessary caches and temporary files
Reduces (not destroys) trace data
⚙️ Features
🔄 System Updates
Enables phased updates bypass
Updates package lists
Runs:
apt upgrade
apt full-upgrade
Removes unused packages (autoremove)
Cleans package cache
💻 Firmware Updates
Refreshes firmware metadata
Checks for updates
Applies updates via fwupdmgr
🔒 Privacy (Lite Mode)
This version is non-destructive and keeps logs useful for debugging.
🧾 Logs (Preserved & Trimmed)
System logs are rotated instead of deleted
Journal logs reduced to a reasonable size (e.g. last few days)
APT and dpkg logs are kept
✔ Helps with:
Debugging issues
Reviewing update history
System auditing
🌐 Network & Tool Cleanup
Removes:
wget HSTS files
Keeps:
curl configs (can contain user settings)
🧑‍💻 User Trace Cleanup
Clears:
Thumbnail cache
Temporary files (/tmp, /var/tmp)
Does NOT remove:
Bash history
User configuration files
🌍 Browser Cleanup (Safe)
Clears cache only
Keeps:
History
Cookies
Logins
Sessions
Supported:
Firefox / Mozilla
Chrome / Chromium
Brave
🚀 Usage
1. Save the script
Bash
nano update-lite.sh
2. Make executable
Bash
chmod +x update-lite.sh
3. Run
Bash
sudo ./update-lite.sh
⚠️ Key Differences (Lite vs Full)
Feature
Full Version ❌
Lite Version ✅
System logs
Deleted
Rotated/kept
Bash history
Removed
Preserved
Browser data
Wiped
Cache only
APT/dpkg logs
Deleted
Preserved
Debugging ability
Limited
Maintained
🛠 Recommended Log Retention
You can tweak this line in the script:
Bash
journalctl --vacuum-time=7d
Examples:
3d → minimal logs
7d → balanced (recommended)
14d → more history
❗ Notes
Still requires sudo
Safe for daily/weekly use
Ideal for:
Personal systems
Developers
Anyone who wants privacy without breaking diagnostics
✅ Output

System update and light cleanup complete. ✅
📄 License
Free to use and modify. No warranty.
If you want next step, I can also:
�⁠Write the actual lite script version to match this README
�⁠Add log size limits instead of time-based cleanup
�⁠Turn it into an automatic weekly maintenance job
