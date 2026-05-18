#!/usr/bin/env bash
set -euo pipefail
# Ambient theme switching — changes theme based on time of day
# Cron: 0 */3 * * * /path/to/cortex/theming-engine/ambient.sh

HOUR=$(date +%H)

case $HOUR in
  6|7|8|9)
    # Morning — bright, warm
    THEME="Flexoki Light"
    ;;
  10|11|12|13|14|15|16)
    # Day — balanced
    THEME="Catppuccin Latte"
    ;;
  17|18|19)
    # Evening — warm dark
    THEME="Gruvbox"
    ;;
  20|21|22|23|0|1|2|3|4|5)
    # Night — deep dark
    THEME="Tokyo Night"
    ;;
esac

CURRENT=$(omarchy theme get 2>/dev/null || echo "")
if [ "$CURRENT" != "$THEME" ]; then
  omarchy theme set "$THEME"
  notify-send "Cortex" "Switched to $THEME (ambient)"
fi
