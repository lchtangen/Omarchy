#!/usr/bin/env bash
set -euo pipefail
# Battery monitor — sends notifications at critical levels
# Designed for systemd timer every 30 seconds

BATTERY="${BATTERY_DEVICE:-BAT0}"
SYSFS="/sys/class/power_supply/$BATTERY"
FLAGFILE="/run/user/$(id -u)/omarchy_battery_notified"

[[ -d "$SYSFS" ]] || exit 0

capacity=$(cat "$SYSFS/capacity" 2>/dev/null || echo 100)
status=$(cat "$SYSFS/status" 2>/dev/null || echo "Unknown")

# Clear flag if charging or above threshold
if [[ "$status" == "Charging" ]] || (( capacity > 15 )); then
    rm -f "$FLAGFILE"
    exit 0
fi

# Notify only once per discharge cycle
if (( capacity <= 10 )) && [[ ! -f "$FLAGFILE" ]]; then
    notify-send -u critical "Battery Critical" "${capacity}% remaining — plug in now"
    touch "$FLAGFILE"
elif (( capacity <= 5 )) && [[ "$(cat "$FLAGFILE" 2>/dev/null)" != "5" ]]; then
    notify-send -u critical "Battery Very Low" "${capacity}% — system may suspend soon"
    echo "5" > "$FLAGFILE"
fi
