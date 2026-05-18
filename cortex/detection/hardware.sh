#!/usr/bin/env bash
set -euo pipefail
# Hardware detection — identify system capabilities

detect_gpu() {
  if lspci | grep -qi "nvidia"; then
    echo "nvidia"
  elif lspci | grep -qi "amd.*graphics\|radeon"; then
    echo "amd"
  elif lspci | grep -qi "intel.*graphics"; then
    echo "intel"
  else
    echo "unknown"
  fi
}

detect_displays() {
  hyprctl monitors 2>/dev/null | grep -c "Monitor" || echo 0
}

detect_form_factor() {
  if [ -d /sys/class/power_supply ] && ls /sys/class/power_supply | grep -q "BAT"; then
    echo "laptop"
  elif systemd-detect-virt --quiet 2>/dev/null; then
    echo "vm"
  else
    echo "desktop"
  fi
}

echo "GPU: $(detect_gpu)"
echo "Displays: $(detect_displays)"
echo "Form factor: $(detect_form_factor)"
