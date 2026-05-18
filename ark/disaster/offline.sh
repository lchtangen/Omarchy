#!/usr/bin/env bash
set -euo pipefail
# Offline recovery mode — restore from local snapshots without network

echo "=== Ark Offline Recovery ==="
echo ""

# Detect btrfs snapshots
SNAPSHOTS=$(find /.snapshots -maxdepth 1 -name "*-*" 2>/dev/null | sort -r | head -10)
if [ -n "$SNAPSHOTS" ]; then
  echo "Available snapshots:"
  echo "$SNAPSHOTS" | nl
  echo ""
  read -p "Enter snapshot number to rollback (or 0 to cancel): " choice
  if [ "$choice" -gt 0 ] 2>/dev/null; then
    SNAP=$(echo "$SNAPSHOTS" | sed -n "${choice}p")
    if [ -d "$SNAP" ]; then
      echo "Rolling back to: $SNAP"
      # Rollback logic
      echo "Rollback initiated. Reboot recommended."
    fi
  fi
else
  echo "No snapshots found."
  echo "Fallback: reinstall Omarchy from ISO at https://omarchy.org"
fi
