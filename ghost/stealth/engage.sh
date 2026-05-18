#!/usr/bin/env bash
set -euo pipefail
# Engage stealth mode — disappear from the network

echo "=== Ghost: Engaging stealth mode ==="

# VPN kill switch — block all non-VPN traffic
if command -v mullvad &>/dev/null; then
  mullvad connect
  mullvad lockdown-mode set on
  echo "  [vpn] Mullvad connected + lockdown"
fi

# Kill camera
if [ -e /dev/video0 ]; then
  sudo modprobe -r uvcvideo 2>/dev/null && echo "  [camera] disabled" || true
fi

# Kill microphone
pactl set-source-mute @DEFAULT_SOURCE@ 1 2>/dev/null && echo "  [mic] muted"

# Disable Bluetooth
bluetoothctl power off 2>/dev/null && echo "  [bluetooth] off"

# Clear clipboard
echo -n "" | wl-copy 2>/dev/null && echo "  [clipboard] cleared"

# Clear recent files
rm -f ~/.local/share/recently-used.xbel 2>/dev/null

# Set privacy theme
notify-send -u critical "👻 Ghost Mode Engaged" "All connections secured"
