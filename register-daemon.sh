#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_SRC="$SCRIPT_DIR/alttab-restarter.sh"
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_TARGET="$INSTALL_DIR/alttab-restarter.sh"
PLIST_TEMPLATE="$SCRIPT_DIR/com.user.alttabrestarter.plist"
PLIST_TARGET="$HOME/Library/LaunchAgents/com.user.alttabrestarter.plist"

if [ ! -f "$SCRIPT_SRC" ]; then
  echo "❌ Error: alttab-restarter.sh not found at $SCRIPT_SRC"
  exit 1
fi

mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_SRC" "$SCRIPT_TARGET"
chmod +x "$SCRIPT_TARGET"

echo "🔧 Creating LaunchAgent plist with current script path..."
sed "s|/Users/username/path/to/alttab-restarter.sh|$SCRIPT_TARGET|g" "$PLIST_TEMPLATE" > "$PLIST_TARGET"

chmod 644 "$PLIST_TARGET"

echo "♻️ Unloading existing LaunchAgent (if exists)..."
launchctl bootout gui/$(id -u) "$PLIST_TARGET" 2>/dev/null

echo "🚀 Loading LaunchAgent..."
launchctl bootstrap gui/$(id -u) "$PLIST_TARGET"

echo "✅ Done. The service is now running with script at:"
echo "   $SCRIPT_TARGET"
