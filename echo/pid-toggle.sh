#!/usr/bin/env bash
set -euo pipefail
# PID-toggle pattern — start/stop a process based on PID file
# Usage: pid-toggle.sh <name> <command...>

NAME="${1:-}"; shift || { echo "Usage: pid-toggle.sh <name> <command...>"; exit 1; }
PIDFILE="/run/user/$(id -u)/omarchy-$NAME.pid"

if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    pid=$(cat "$PIDFILE")
    kill "$pid" 2>/dev/null || true
    rm -f "$PIDFILE"
    echo "Stopped $NAME (PID $pid)"
    notify-send "Echo" "Stopped $NAME" 2>/dev/null || true
else
    "$@" &
    pid=$!
    echo "$pid" > "$PIDFILE"
    echo "Started $NAME (PID $pid)"
    notify-send "Echo" "Started $NAME" 2>/dev/null || true
fi
