# Restarter

A lightweight macOS LaunchAgent script that keeps selected apps fresh and locks the microphone input volume.

Current behavior:
- Restarts AltTab and Whispering every 60 minutes
- Checks microphone input volume every 3 seconds
- Resets microphone input volume to 100% if another app changes it

## 🔧 How it Works

- A shell script runs continuously in the background
- App restart and microphone lock intervals are controlled in `restarter.sh`
- A macOS `LaunchAgent` ensures the script starts automatically at user login

## 📦 Installation

1. Clone the repository:
```bash
git clone <repo-url>
cd my_restarter
```

2. Run the installation script:
```bash
# eventually you need to chmod the file first: chmod +x register-daemon.sh
./register-daemon.sh
```

The service will start immediately and continuously monitor your microphone level.

## 🧪 Verify Installation

Check if the service is running:
```bash
launchctl list | grep com.user.restarter
```
If a line appears (with PID or exit code 0), the service is active.

## 🔄 Uninstallation

To remove the tool:
```bash
chmod +x unregister-daemon.sh
./unregister-daemon.sh
```
This will remove the LaunchAgent and optionally delete the shell script.

## ⚙️ Configuration

### Changing Microphone Level

1. Open `restarter.sh` and modify this line:
```bash
TARGET_VOLUME=100  # Set desired input level (0-100)
```

2. Reinstall/restart the service:
```bash
./register-daemon.sh
```

## ⚠️ Performance Warning

A very low sleep interval (e.g., less than 2-3 seconds) in the monitoring script can lead to increased CPU usage by the macOS process `/usr/sbin/coreaudiod`. This may be visible in the Activity Monitor as higher CPU consumption. If you notice this, consider increasing `MIC_CHECK_INTERVAL` in `restarter.sh` to reduce system load.

## 📁 Project Structure

```
.
├── restarter.sh               # App restart and microphone lock script
├── com.user.restarter.plist   # LaunchAgent template
├── register-daemon.sh         # Installation script
├── unregister-daemon.sh       # Uninstallation script
└── Readme.md                  # This documentation
```

## 🛡️ Note

This tool:
- Doesn't modify system files
- Doesn't require administrative privileges
- Doesn't interfere with other audio settings
- Can be removed cleanly at any time

## 🧑‍💻 License

Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
Contributions welcome!
