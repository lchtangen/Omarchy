#!/usr/bin/env bash
set -euo pipefail
# Weekly security audit scanner

echo "=== Cyberdeck Security Scan ==="
echo "Date: $(date)"
echo "Host: $(hostname)"
echo "---"

# Check kernel params
echo "[*] Kernel hardening:"
sysctl kernel.kptr_restrict kernel.dmesg_restrict kernel.randomize_va_space 2>/dev/null

# Check firewall
echo "[*] Firewall rules:"
nft list ruleset 2>/dev/null | head -20 || echo "  nftables not active"

# Check listening ports
echo "[*] Listening ports:"
ss -tlnp 2>/dev/null | grep LISTEN

# Check failed logins
echo "[*] Failed SSH logins (last 24h):"
journalctl -u sshd --since "24 hours ago" 2>/dev/null | grep "Failed password" | wc -l || echo "  0"

# Check updates
echo "[*] Pending updates:"
checkupdates 2>/dev/null | wc -l || echo "  0"

echo "---"
echo "Scan complete"
