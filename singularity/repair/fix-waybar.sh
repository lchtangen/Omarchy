#!/usr/bin/env bash
set -euo pipefail
# Waybar crash recovery — auto-restart if Waybar dies

pidfile="/tmp/waybar-pid.pid"

if pgrep -x waybar > /dev/null; then
  echo "OK: Waybar is running"
else
  echo "REPAIR: Waybar not running — restarting"
  waybar &
  notify-send -u critical "Singularity" "Waybar restarted (crash recovery)"
fi
