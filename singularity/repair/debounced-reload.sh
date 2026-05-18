#!/usr/bin/env bash
set -euo pipefail
# Debounced Hyprland reload — multiple calls within 300ms coalesce into one
# Ported from ArchRiot's Go debounce pattern
# Usage: debounced-reload.sh [debounce_ms]

DEBOUNCE_MS="${1:-300}"
LOCKFILE="/tmp/omarchy-reload.lock"
LAST_PID_FILE="/tmp/omarchy-reload.pid"

# Kill any pending reload
if [[ -f "$LAST_PID_FILE" ]]; then
    old_pid=$(cat "$LAST_PID_FILE")
    kill "$old_pid" 2>/dev/null || true
fi

# Spawn delayed reload and capture its PID
(
    sleep "$(bc <<< "scale=3; $DEBOUNCE_MS / 1000")"
    hyprctl reload
    rm -f "$LOCKFILE" "$LAST_PID_FILE"
) &
new_pid=$!
echo "$new_pid" > "$LAST_PID_FILE"
echo "Hyprland reload scheduled (PID $new_pid, debounce ${DEBOUNCE_MS}ms)"
