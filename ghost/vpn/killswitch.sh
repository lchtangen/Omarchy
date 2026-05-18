#!/usr/bin/env bash
set -euo pipefail
# Network kill switch — drops all non-VPN traffic immediately

echo "=== Ghost: Activating kill switch ==="

# Backup current rules
sudo nft list ruleset > /tmp/nft-backup-$(date +%s).nft 2>/dev/null || true

# Drop everything except VPN interface
sudo nft add table inet ghost
sudo nft add chain inet ghost input { type filter hook input priority 0\; policy drop\; }
sudo nft add chain inet ghost output { type filter hook output priority 0\; policy drop\; }
sudo nft add chain inet ghost forward { type filter hook forward priority 0\; policy drop\; }

# Allow only through VPN tunnel (tun0)
sudo nft add rule inet ghost output oif "tun0" accept
sudo nft add rule inet ghost input iif "tun0" accept

echo "  Kill switch active — only VPN tunnel allowed"
echo "  Restore: sudo nft flush ruleset"
