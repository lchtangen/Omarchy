#!/usr/bin/env bash
set -euo pipefail
# Waybar crash recovery — auto-restart if Waybar dies

if pgrep -x waybar > /dev/null; then
  echo "OK: Waybar is running"
else
  command -v waybar &>/dev/null || { echo "ERROR: waybar command not found"; exit 1; }
  echo "REPAIR: Waybar not running — restarting"
  waybar &>/dev/null &
  notify-send -u critical "Singularity" "Waybar restarted (crash recovery)" 2>/dev/null || true
fi
