#!/usr/bin/env bash
set -euo pipefail
# Systemd timer unit files for self-healing

cat > /tmp/omarchy-heal.service <<'SERVICE'
[Unit]
Description=Omarchy Singularity Health Check
Wants=omarchy-heal.timer

[Service]
Type=oneshot
ExecStart=/home/arch/Omarchy/singularity/repair/fix-waybar.sh
Environment=HOME=/home/arch

[Install]
WantedBy=multi-user.target
SERVICE

cat > /tmp/omarchy-heal.timer <<'TIMER'
[Unit]
Description=Run Omarchy health check every 30 minutes

[Timer]
OnBootSec=2min
OnUnitActiveSec=30min

[Install]
WantedBy=timers.target
TIMER

echo "Timer units generated at /tmp/omarchy-heal.*"
echo "Install: sudo cp /tmp/omarchy-heal.* /etc/systemd/system/ && sudo systemctl daemon-reload && sudo systemctl enable --now omarchy-heal.timer"
