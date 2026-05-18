#!/usr/bin/env bash
set -euo pipefail
# Suspend guard — checks for critical processes before allowing suspend
# Returns non-zero if suspend should be blocked

CRITICAL_TASKS=("rsync" "pacman" "yay" "paru" "makepkg" "dd" "cp" "mv")
BLOCK=false

for task in "${CRITICAL_TASKS[@]}"; do
    if pgrep -x "$task" > /dev/null 2>&1; then
        echo "BLOCK: $task is running"
        BLOCK=true
    fi
done

# Check for active network transfers
if command -v ifstat &>/dev/null; then
    activity=$(ifstat 1 1 | tail -1 | awk '{print $1+$2}')
    if (( $(echo "$activity > 1" | bc -l 2>/dev/null || echo 0) )); then
        echo "BLOCK: network activity detected ($activity KB/s)"
        BLOCK=true
    fi
fi

if $BLOCK; then
    notify-send -u critical "Suspend Guard" "Blocking suspend — critical tasks running" 2>/dev/null || true
    exit 1
fi

echo "OK: no blocking tasks"
exit 0
