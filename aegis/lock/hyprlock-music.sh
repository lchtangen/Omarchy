#!/usr/bin/env bash
set -euo pipefail
# Hyprlock with music — uses music-player-themed lock screen if Spotify playing
# Pattern from omarchy-config hyprlock scripts

if [[ "$(playerctl -p spotify status 2>/dev/null)" == "Playing" ]]; then
    hyprlock --config ~/.config/hyprlock/music.conf
else
    hyprlock
fi
