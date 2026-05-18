#!/usr/bin/env bash
set -euo pipefail
# Network-based location detection — switch profiles based on SSID

SSID=$(iwctl station wlan0 show 2>/dev/null | grep "Connected network" | awk '{print $3}')

case "$SSID" in
  "HomeNetwork")
    echo "Location: HOME"
    /home/arch/Omarchy/beacon/geo/home-profile
    ;;
  "Office-5G"|"Office-Guest")
    echo "Location: WORK"
    /home/arch/Omarchy/beacon/geo/work-profile
    ;;
  *)
    echo "Location: UNKNOWN ($SSID)"
    # Keep current profile
    ;;
esac
