#!/bin/bash

PLIST="$HOME/Library/LaunchAgents/com.user.alttabrestarter.plist"
SCRIPT_TARGET="$HOME/.local/bin/alttab-restarter.sh"

echo "🛑 Stopping LaunchAgent (if active)..."
launchctl bootout gui/$(id -u) "$PLIST" 2>/dev/null

echo "🧹 Removing LaunchAgent file..."
rm -f "$PLIST"

echo "🧹 Removing installed script copy..."
rm -f "$SCRIPT_TARGET"

echo "✅ Uninstallation completed."
