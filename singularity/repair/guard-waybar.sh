#!/usr/bin/env bash
set -euo pipefail
# Waybar guard — prevents duplicate instances, restart if missing
# Systemd-timer compatible: returns 0 if OK, 1 if restarted

if pgrep -x waybar > /dev/null 2>&1; then
    count=$(pgrep -x waybar | wc -l)
    if (( count > 1 )); then
        echo "WARN: $count waybar instances — killing duplicates"
        for pid in $(pgrep -x waybar | tail -n +2); do
            kill "$pid" 2>/dev/null || true
        done
        exit 0
    fi
    echo "OK: waybar running (single instance)"
    exit 0
fi

echo "REPAIR: waybar not running — restarting"
notify-send -u critical "Omarchy Guard" "Waybar was down — restarted" 2>/dev/null || true
waybar &
exit 1
