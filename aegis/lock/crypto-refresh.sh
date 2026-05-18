#!/usr/bin/env bash
set -euo pipefail
# Crypto refresh — clears cached crypto state before/after lock
# Pattern from ArchRiot hyprlock-crypto-refresh.sh

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/crypto"
rm -rf "$CACHE_DIR"/*.json 2>/dev/null || true
echo "Crypto cache cleared"
