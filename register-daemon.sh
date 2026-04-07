#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_SRC="$SCRIPT_DIR/restarter.sh"
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_TARGET="$INSTALL_DIR/restarter.sh"
PLIST_TEMPLATE="$SCRIPT_DIR/com.user.restarter.plist"
PLIST_TARGET="$HOME/Library/LaunchAgents/com.user.restarter.plist"
OLD_PLIST_TARGET="$HOME/Library/LaunchAgents/com.user.alttabrestarter.plist"
OLD_SCRIPT_TARGET="$INSTALL_DIR/alttab-restarter.sh"

if [ ! -f "$SCRIPT_SRC" ]; then
  echo "❌ Error: restarter.sh not found at $SCRIPT_SRC"
  exit 1
fi

mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_SRC" "$SCRIPT_TARGET"
chmod +x "$SCRIPT_TARGET"

echo "🔧 Creating LaunchAgent plist with current script path..."
sed "s|/Users/username/path/to/restarter.sh|$SCRIPT_TARGET|g" "$PLIST_TEMPLATE" > "$PLIST_TARGET"

chmod 644 "$PLIST_TARGET"

echo "♻️ Unloading existing LaunchAgent (if exists)..."
launchctl bootout gui/$(id -u) "$PLIST_TARGET" 2>/dev/null
launchctl bootout gui/$(id -u) "$OLD_PLIST_TARGET" 2>/dev/null
rm -f "$OLD_PLIST_TARGET"
rm -f "$OLD_SCRIPT_TARGET"

echo "🚀 Loading LaunchAgent..."
launchctl bootstrap gui/$(id -u) "$PLIST_TARGET"

echo "✅ Done. The service is now running with script at:"
echo "   $SCRIPT_TARGET"
