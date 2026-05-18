#!/usr/bin/env bash
set -euo pipefail
# Theme change webhook — triggers on every omarchy theme set
# Register: omarchy-theme-hook add protocol/webhooks/theme-hook.sh

THEME="${1:-}"
echo "[webhook] Theme changed to: $THEME"

# Notify all running instances
if command -v makoctl &>/dev/null; then
  makoctl dismiss -a
fi

# Trigger Waybar refresh
pkill -SIGUSR2 waybar 2>/dev/null || true

# Log the change
echo "$(date -Iseconds) theme=$THEME" >> /tmp/omarchy-webhook.log
