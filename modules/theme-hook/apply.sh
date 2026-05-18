#!/usr/bin/env bash
set -euo pipefail
# Theme hook system — applies a theme across all configured apps
# Usage: apply.sh <theme-name> [--dry]

THEME_NAME="${1:-}"
DRY="${2:-}"
HOOK_DIR="${OMARCHY_HOOK_DIR:-$HOME/.config/omarchy/hooks}"
THEME_DIR="${OMARCHY_THEME_DIR:-$HOME/.config/omarchy/themes/$THEME_NAME}"
STATE_DIR="${OMARCHY_STATE_DIR:-$HOME/.local/state/omarchy}"

[[ -z "$THEME_NAME" ]] && { echo "Usage: apply.sh <theme-name>"; exit 1; }
[[ -d "$THEME_DIR" ]] || { echo "Theme not found: $THEME_DIR"; exit 1; }

run_hook() {
    local hook="$1" arg="$2"
    local hook_path="$HOOK_DIR/$hook"
    [[ -x "$hook_path" ]] || return 0
    if [[ "$DRY" == "--dry" ]]; then
        echo "[DRY] would execute: $hook_path $arg"
    else
        "$hook_path" "$arg"
    fi
}

notify() {
    local msg="$1"
    echo "$msg"
    command -v notify-send &>/dev/null && notify-send "Omarchy Theme" "$msg"
}

link_current() {
    local current="$HOME/.config/omarchy/current/theme"
    mkdir -p "$(dirname "$current")"
    ln -sfT "$THEME_DIR" "$current"
}

# --- Main ---
link_current

# Apply wallpaper
bg_dir="$THEME_DIR/backgrounds"
if [[ -d "$bg_dir" ]]; then
    bg=$(find "$bg_dir" -type f | shuf -n 1)
    [[ -n "$bg" ]] && {
        hyprctl hyprpaper wallpaper ",$bg" 2>/dev/null || true
        swaybg -i "$bg" &>/dev/null &
    }
fi

# Source theme colors
colors_file="$THEME_DIR/colors.toml"
[[ -f "$colors_file" ]] && source <(grep -E '^\w+\s*=' "$colors_file" 2>/dev/null || true)

# Apply per-app themes
run_hook "theme-terminal" "$THEME_NAME"
run_hook "theme-gtk" "$THEME_NAME"
run_hook "theme-browser" "$THEME_NAME"
run_hook "theme-vscode" "$THEME_NAME"
run_hook "theme-obsidian" "$THEME_NAME"

# Reload affected services
hyprctl reload 2>/dev/null || true
pkill -USR2 waybar 2>/dev/null || true
pkill -USR2 swayosd 2>/dev/null || true
pkill -SIGUSR2 btop 2>/dev/null || true
makoctl reload 2>/dev/null || true

# Run post-set hook
run_hook "theme-set" "$THEME_NAME"

notify "Theme applied: $THEME_NAME"
