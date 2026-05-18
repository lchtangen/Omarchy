#!/usr/bin/env bash
set -euo pipefail
# Bluetooth proximity unlock — when phone/watch is near, unlock

DEVICE_MAC="${1:-}"
POLL_INTERVAL="${2:-5}"

[ -z "$DEVICE_MAC" ] && echo "Usage: $0 <device-mac> [interval-s]" && exit 1

echo "=== Beacon: Watching for $DEVICE_MAC ==="

while true; do
  if bluetoothctl info "$DEVICE_MAC" 2>/dev/null | grep -q "Connected: yes"; then
    # Device is near — ensure unlocked
    if pidof hyprlock > /dev/null 2>&1; then
      pkill hyprlock
      notify-send "Beacon" "Device detected — unlocked"
    fi
  else
    # Device is away — lock after timeout
    sleep 30
    if ! bluetoothctl info "$DEVICE_MAC" 2>/dev/null | grep -q "Connected: yes"; then
      hyprlock
    fi
  fi
  sleep "$POLL_INTERVAL"
done
