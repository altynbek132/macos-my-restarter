#!/bin/bash

PLIST="$HOME/Library/LaunchAgents/com.user.restarter.plist"
OLD_PLIST="$HOME/Library/LaunchAgents/com.user.alttabrestarter.plist"
SCRIPT_TARGET="$HOME/.local/bin/restarter.sh"
OLD_SCRIPT_TARGET="$HOME/.local/bin/alttab-restarter.sh"

echo "🛑 Stopping LaunchAgent (if active)..."
launchctl bootout gui/$(id -u) "$PLIST" 2>/dev/null
launchctl bootout gui/$(id -u) "$OLD_PLIST" 2>/dev/null

echo "🧹 Removing LaunchAgent file..."
rm -f "$PLIST"
rm -f "$OLD_PLIST"

echo "🧹 Removing installed script copy..."
rm -f "$SCRIPT_TARGET"
rm -f "$OLD_SCRIPT_TARGET"

echo "✅ Uninstallation completed."
