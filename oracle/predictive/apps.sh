#!/usr/bin/env bash
set -euo pipefail
# App launch prediction — preload likely next app
# Learns from hyprctl window history

HISTORY_LOG="$HOME/.cache/oracle-app-history.log"
mkdir -p "$(dirname "$HISTORY_LOG")"

# Record window focus changes
hyprctl events -f | while read -r event; do
  if echo "$event" | grep -q "activewindow"; then
    class=$(echo "$event" | cut -d'>' -f2 | xargs)
    echo "$(date +%s) $class" >> "$HISTORY_LOG"
  fi
done
