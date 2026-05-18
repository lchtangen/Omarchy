#!/usr/bin/env bash
set -euo pipefail
# Echo voice service — systemd-style startup for voice recognition pipeline
# Integrates hyprwhisper, OSTT-style processing, and waybar IPC signals

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/echo"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/echo"
PIDFILE="/run/user/$(id -u)/echo-service.pid"

mkdir -p "$STATE_DIR"

start() {
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        echo "Echo service already running (PID $(cat "$PIDFILE"))"
        return
    fi
    # Start whisper listener if configured
    if command -v hyprwhspr &>/dev/null; then
        hyprwhspr --config "$CONFIG_DIR/voice/whisper.conf" &
        echo $! > "$PIDFILE"
        echo "Echo service started (hyprwhspr)"
    elif command -v ostt &>/dev/null; then
        ostt daemon &
        echo $! > "$PIDFILE"
        echo "Echo service started (ostt)"
    else
        echo "No voice engine found (install hyprwhspr or ostt)"
        return 1
    fi
    # Signal waybar that service is active
    pkill -RTMIN+9 waybar 2>/dev/null || true
}

stop() {
    if [[ -f "$PIDFILE" ]]; then
        kill "$(cat "$PIDFILE")" 2>/dev/null || true
        rm -f "$PIDFILE"
        echo "Echo service stopped"
    fi
    pkill -RTMIN+9 waybar 2>/dev/null || true
}

status() {
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
        echo "Echo service running (PID $(cat "$PIDFILE"))"
    else
        echo "Echo service stopped"
    fi
}

case "${1:-status}" in
    start) start ;;
    stop) stop ;;
    restart) stop; sleep 0.5; start ;;
    status) status ;;
    *) echo "Usage: service.sh {start|stop|restart|status}" ;;
esac
