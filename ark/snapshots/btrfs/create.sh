#!/usr/bin/env bash
set -euo pipefail
# Btrfs snapshot creation — run before risky operations

SUBVOL="${1:-@}"
SNAPSHOT_DIR="${2:-/.snapshots}"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SNAPSHOT_NAME="${SUBVOL}-${TIMESTAMP}"

if ! command -v btrfs &>/dev/null; then
  echo "ERROR: btrfs not found"
  exit 1
fi

# Create snapshot directory
sudo mkdir -p "$SNAPSHOT_DIR"

# Take snapshot
sudo btrfs subvolume snapshot -r "/mnt/@/$SUBVOL" "$SNAPSHOT_DIR/$SNAPSHOT_NAME"

echo "Snapshot created: $SNAPSHOT_DIR/$SNAPSHOT_NAME"
echo "Rollback: sudo btrfs subvolume delete /mnt/@ && sudo btrfs subvolume snapshot $SNAPSHOT_DIR/$SNAPSHOT_NAME /mnt/@"
