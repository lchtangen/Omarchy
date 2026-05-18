#!/usr/bin/env bash
set -euo pipefail
# Disk growth forecaster — predict when disk will fill up

MOUNT="${1:-/}"
DAYS="${2:-30}"

echo "=== Oracle: Disk Growth Forecast ==="
echo "Mount: $MOUNT | Horizon: ${DAYS}d"
echo ""

# Collect history
LOG="/tmp/oracle-disk-history.log"
for d in $(seq 0 $DAYS); do
  ts=$(date -d "-$d days" +%s 2>/dev/null)
  echo "Need: logs from last $DAYS days"
done

# Current usage
current=$(df "$MOUNT" | awk 'NR==2 {print $3}')
total=$(df "$MOUNT" | awk 'NR==2 {print $2}')
pct=$(df "$MOUNT" | awk 'NR==2 {print $5}' | tr -d '%')
echo "Current: ${current}K / ${total}K (${pct}%)"

if [ "$pct" -gt 85 ]; then
  echo "WARNING: Disk usage exceeds 85% threshold"
  echo "ACTION: Consider cleaning pacman cache: sudo pacman -Sc"
fi
