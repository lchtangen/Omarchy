#!/usr/bin/env bash
set -euo pipefail
# Stabilize the Wayland session — kill runaway processes, restart guards
# Ported from ArchRiot stabilize-session pattern

log() { echo "[stabilize] $*"; }
notify() { log "$*"; command -v notify-send &>/dev/null && notify-send "Singularity" "$*"; }

# 1. Waybar — ensure exactly one instance
waybar_count=$(pgrep -x waybar | wc -l)
if (( waybar_count > 1 )); then
    log "Killing $(( waybar_count - 1 )) runaway waybar instances"
    pkill -x waybar
    sleep 0.5
    waybar &
    notify "Waybar restabilized (was $waybar_count instances)"
elif (( waybar_count == 0 )); then
    log "Waybar not running — starting"
    waybar &
    notify "Waybar started"
else
    log "Waybar OK (1 instance)"
fi

# 2. Hypridle — restart to clear stuck state
log "Restarting hypridle"
killall hypridle 2>/dev/null || true
sleep 0.3
hypridle &

# 3. Inhibit sleep (optional)
if [[ "${1:-}" == "--inhibit" ]]; then
    log "Starting sleep inhibitor"
    systemd-inhibit --what=sleep --why="Omarchy stabilize" sleep infinity &
    notify "Sleep inhibitor active"
fi

log "Session stabilized"
