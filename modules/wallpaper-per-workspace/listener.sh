#!/usr/bin/env bash
set -euo pipefail
# Workspace wallpaper listener — changes wallpaper per workspace
# Listens on Hyprland socket2 for workspace events

SOCKET="/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
CACHE_DIR="/run/user/$(id -u)/omarchy-wallpaper-ws"

[[ -S "$SOCKET" ]] || { echo "Hyprland socket not found"; exit 1; }
mkdir -p "$CACHE_DIR"

set_wallpaper() {
    local ws="$1"
    # Map workspace to wallpaper: WS1 -> wallpapers/1/*, WS2 -> wallpapers/2/*, etc.
    ws_dir="$WALLPAPER_DIR/workspace-$ws"
    if [[ -d "$ws_dir" ]]; then
        bg=$(find "$ws_dir" -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' \) | shuf -n 1)
    else
        # Fallback: numbered wallpaper files
        bg=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f | shuf -n 1)
    fi
    [[ -n "$bg" ]] || return
    hyprctl hyprpaper wallpaper ",$bg" 2>/dev/null || true
    echo "$bg" > "$CACHE_DIR/current"
    echo "Wallpaper set for workspace $ws: $bg"
}

# Initial wallpaper
active_ws=$(hyprctl activeworkspace -j 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('id',1))" 2>/dev/null || echo 1)
set_wallpaper "$active_ws"

# Listen for workspace changes
nc -U "$SOCKET" | while read -r event; do
    case "$event" in
        workspace\>\>*)
            ws_id="${event#workspace>>}"
            set_wallpaper "$ws_id"
            ;;
    esac
done
