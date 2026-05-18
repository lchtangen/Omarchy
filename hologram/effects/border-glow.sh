#!/usr/bin/env bash
set -euo pipefail
# Active window border glow — pulses the active border color
# Requires: hyprctl (built into Hyprland)

hue=0
while true; do
  hue=$(( (hue + 2) % 360 ))
  r=$(bc -l <<< "scale=0; (s($hue * 3.14159 / 180) * 127 + 128) / 1" 2>/dev/null || echo 128)
  g=$(bc -l <<< "scale=0; (s(($hue + 120) * 3.14159 / 180) * 127 + 128) / 1" 2>/dev/null || echo 128)
  b=$(bc -l <<< "scale=0; (s(($hue + 240) * 3.14159 / 180) * 127 + 128) / 1" 2>/dev/null || echo 128)
  hex=$(printf "rgb(%d, %d, %d)" "$r" "$g" "$b")
  hyprctl keyword decoration:col.active_border "$hex" 2>/dev/null || true
  sleep 0.05
done
