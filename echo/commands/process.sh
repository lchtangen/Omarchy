#!/usr/bin/env bash
set -euo pipefail
# Voice command processor — matches transcribed text to actions
# Usage: process.sh "<transcribed text>"

TEXT="${1:-}"
[[ -z "$TEXT" ]] && exit 0

# Normalize
TEXT=$(echo "$TEXT" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g')

# Load command definitions
COMMANDS_DIR="$(dirname "$0")"
MATCHED=false

match() {
    local pattern="$1" action="$2"
    if echo "$TEXT" | grep -qE "$pattern"; then
        echo "Match: $pattern -> $action"
        eval "$action"
        MATCHED=true
    fi
}

match "open terminal" "alacritty &"
match "open browser" "chromium &"
match "next workspace" "hyprctl dispatch workspace +1"
match "previous workspace" "hyprctl dispatch workspace -1"
match "lock screen|lock" "hyprlock &"
match "screenshot (region|area)" "hyprshot -m region"
match "screenshot (screen|display)" "hyprshot -m output"
match "toggle floating" "hyprctl dispatch togglefloating"
match "close window|close" "hyprctl dispatch killactive"
match "volume up" "pactl set-sink-volume @DEFAULT_SINK@ +5%"
match "volume down" "pactl set-sink-volume @DEFAULT_SINK@ -5%"
match "mute|volume off" "pamixer -t"
match "switch to (.*)" "omarchy theme set '\1' 2>/dev/null || true"

if ! $MATCHED; then
    echo "No match for: $TEXT"
    notify-send -u low "Echo" "No command matched: $TEXT" 2>/dev/null || true
fi
