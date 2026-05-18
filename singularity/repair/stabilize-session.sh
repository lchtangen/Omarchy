#!/usr/bin/env bash
set -euo pipefail
# Stabilize the Wayland session — kill runaway processes, restart guards
# Ported from ArchRiot stabilize-session pattern

log() { echo "[stabilize] $*"; }
notify() { log "$*"; command -v notify-send &>/dev/null && notify-send "Singularity" "$*"; }

# 1. Waybar — ensure exactly one instance
waybar_count=$(pgrep -cx waybar 2>/dev/null) || waybar_count=0
if (( waybar_count > 1 )); then
    command -v waybar &>/dev/null || { log "ERROR: waybar command not found"; exit 1; }
    log "Killing $(( waybar_count - 1 )) runaway waybar instances"
    pkill -x waybar
    sleep 0.5
    waybar &>/dev/null &
    notify "Waybar restabilized (was $waybar_count instances)"
elif (( waybar_count == 0 )); then
    command -v waybar &>/dev/null || { log "ERROR: waybar command not found"; exit 1; }
    log "Waybar not running — starting"
    waybar &>/dev/null &
    notify "Waybar started"
else
    log "Waybar OK (1 instance)"
fi

# 2. Hypridle — restart to clear stuck state
if command -v hypridle &>/dev/null; then
    log "Restarting hypridle"
    killall hypridle 2>/dev/null || true
    sleep 0.3
    hypridle &>/dev/null &
else
    log "WARN: hypridle command not found"
fi

# 3. Inhibit sleep (optional)
if [[ "${1:-}" == "--inhibit" ]]; then
    command -v systemd-inhibit &>/dev/null || { log "ERROR: systemd-inhibit command not found"; exit 1; }
    log "Starting sleep inhibitor"
    systemd-inhibit --what=sleep --why="Omarchy stabilize" sleep infinity &
    notify "Sleep inhibitor active"
fi

log "Session stabilized"
