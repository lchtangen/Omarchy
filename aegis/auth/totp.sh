#!/usr/bin/env bash
set -euo pipefail
# TOTP authentication — generate 2FA codes from command line
# Uses oath-toolkit: sudo pacman -S oath-toolkit

SECRET_FILE="$HOME/.config/aegis/totp-secrets.gpg"
ACTION="${1:-list}"

case "$ACTION" in
  list)
    gpg -d "$SECRET_FILE" 2>/dev/null | grep "^#" || echo "No secrets found"
    echo "Usage: $0 <service-name>"
    ;;
  *)
    gpg -d "$SECRET_FILE" 2>/dev/null | grep "^$ACTION " | awk '{print $2}' | while read -r secret; do
      oathtool --totp -b "$secret"
    done
    ;;
esac
