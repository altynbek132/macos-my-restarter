#!/bin/bash

# Restarter
# Keeps selected apps fresh and locks the microphone input volume.

TARGET_VOLUME=100
MIC_CHECK_INTERVAL=3
APP_RESTART_INTERVAL=3600
LAST_APP_RESTART=0

restart_apps() {
  echo "Restarting apps at $(date)"

  pkill -f AltTab
  sleep 1
  open /Applications/AltTab.app

  # pkill -f Whispering
  # sleep 1
  # open /Applications/Whispering.app
}

lock_microphone_volume() {
  CURRENT_VOLUME=$(osascript -e "input volume of (get volume settings)")
  if [ "$CURRENT_VOLUME" != "$TARGET_VOLUME" ]; then
    osascript -e "set volume input volume $TARGET_VOLUME"
    echo "Microphone volume reset to $TARGET_VOLUME% at $(date)"
  fi
}

while true; do
  NOW=$(date +%s)

  if [ $((NOW - LAST_APP_RESTART)) -ge "$APP_RESTART_INTERVAL" ]; then
    restart_apps
    LAST_APP_RESTART="$NOW"
  fi

  lock_microphone_volume
  sleep "$MIC_CHECK_INTERVAL"
done
