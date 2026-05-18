#!/usr/bin/env bash
set -euo pipefail
# System health probe — run every 5 minutes via systemd timer

report="/tmp/observatory-health.json"

cpu_load=$(cut -d' ' -f1-3 /proc/loadavg)
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
disk_used=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
temp=$(sensors 2>/dev/null | grep "Package" | awk '{print $4}' | tr -d '+°C' || echo "N/A")

cat > "$report" <<EOF
{
  "timestamp": "$(date -Iseconds)",
  "host": "$(hostname)",
  "cpu": { "load": "$cpu_load" },
  "memory": { "total_mb": $mem_total, "used_mb": $mem_used },
  "disk": { "root_used_pct": $disk_used },
  "thermal": { "cpu_temp": "$temp" }
}
EOF

echo "Health report written to $report"
