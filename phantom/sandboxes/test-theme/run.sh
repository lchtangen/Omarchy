#!/usr/bin/env bash
set -euo pipefail
# Theme testing sandbox — safely apply and preview themes
# Creates an isolated Hyprland session for theme testing

SANDBOX_DIR="/tmp/phantom-theme-test"
THEME="${1:-}"

[ -z "$THEME" ] && echo "Usage: $0 <theme-name>" && exit 1

# Create sandbox config
mkdir -p "$SANDBOX_DIR/.config/hypr"
mkdir -p "$SANDBOX_DIR/.config/waybar"

# Copy host configs
cp -r ~/.config/hypr/* "$SANDBOX_DIR/.config/hypr/"
cp -r ~/.config/waybar/* "$SANDBOX_DIR/.config/waybar/"

# Apply test theme
if [ -d "repos/themes/colorschemes/$THEME" ]; then
  cp "repos/themes/colorschemes/$THEME/waybar.css" "$SANDBOX_DIR/.config/waybar/style.css" 2>/dev/null || true
  echo "Sandbox ready at $SANDBOX_DIR"
  echo "Run: HYPRLAND_INSTANCE_SIGNATURE= WAYLAND_DISPLAY= hyprctl --instance 0 --batch 'exec env HOME=$SANDBOX_DIR waybar'"
else
  echo "Theme not found: $THEME"
  exit 1
fi
