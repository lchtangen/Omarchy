#!/usr/bin/env bash
set -euo pipefail
# MPRIS lock screen player — fetches album art for hyprlock background
# Pattern from omarchy-config hyprlock/scripts/playerctlock.sh

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/hyprlock"
mkdir -p "$CACHE_DIR"

playerctl_metadata() {
    playerctl -p spotify metadata "$1" 2>/dev/null || echo ""
}

title=$(playerctl_metadata title)
artist=$(playerctl_metadata artist)
art_url=$(playerctl_metadata mpris:artUrl)

[[ -z "$title" ]] && { echo "No track playing"; exit 0; }

# Download album art
if [[ -n "$art_url" ]]; then
    art_file="$CACHE_DIR/album_art.jpg"
    blurred_file="$CACHE_DIR/album_art_blur.jpg"

    curl -sL "$art_url" -o "$art_file" 2>/dev/null || exit 1

    # Create blurred background with ImageMagick
    if command -v convert &>/dev/null; then
        convert "$art_file" -resize 1920x1080^ \
            -gravity center -extent 1920x1080 \
            -blur 0x30 "$blurred_file" 2>/dev/null
        echo "Lock screen background: $blurred_file"
    fi
fi

# Signal hyprlock to refresh
pkill -SIGUSR2 hyprlock 2>/dev/null || true
