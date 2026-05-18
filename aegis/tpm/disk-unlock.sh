#!/usr/bin/env bash
set -euo pipefail
# TPM2 LUKS unlock — auto-decrypt root partition at boot
# Requires: tpm2-tools, systemd-cryptenroll

DISK="${1:-}"
[ -z "$DISK" ] && echo "Usage: $0 /dev/nvme0n1p2" && exit 1

echo "=== Aegis: Enrolling TPM2 for LUKS auto-unlock ==="
echo "Disk: $DISK"
echo ""

# Check TPM availability
if ! tpm2_getrandom 8 > /dev/null 2>&1; then
  echo "ERROR: TPM2 not available"
  exit 1
fi

# Enroll TPM2 PCR7 + PIN
sudo systemd-cryptenroll --tpm2-device=auto \
  --tpm2-pcrs=0+7 \
  --tpm2-with-pin=yes \
  "$DISK"

echo "TPM2 enrolled for $DISK"
echo "System will auto-unlock root on boot (with PIN)"
