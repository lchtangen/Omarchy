#!/usr/bin/env bash
set -euo pipefail
# Full restoration of dotfiles from backup
# Usage: ark/restore/config-restore.sh <backup-archive>

ARCHIVE="${1:-}"
[ -z "$ARCHIVE" ] && echo "Usage: $0 <backup.tar.gz>" && exit 1
[ ! -f "$ARCHIVE" ] && echo "File not found: $ARCHIVE" && exit 1

TMPDIR=$(mktemp -d)
tar xzf "$ARCHIVE" -C "$TMPDIR"

echo "=== Restoring configuration ==="

restore_dir() {
  local src="$TMPDIR/$1"
  local dst="$2"
  if [ -d "$src" ]; then
    mkdir -p "$dst"
    cp -r "$src"/* "$dst/"
    echo "  Restored: $dst"
  fi
}

restore_file() {
  local src="$TMPDIR/$1"
  local dst="$2"
  if [ -f "$src" ]; then
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "  Restored: $dst"
  fi
}

restore_dir "hypr" "$HOME/.config/hypr"
restore_dir "waybar" "$HOME/.config/waybar"
restore_dir "walker" "$HOME/.config/walker"
restore_dir "omarchy" "$HOME/.config/omarchy"
restore_dir "mako" "$HOME/.config/mako"
restore_dir "alacritty" "$HOME/.config/alacritty"
restore_file ".zshrc" "$HOME/.zshrc"
restore_file ".bashrc" "$HOME/.bashrc"

rm -rf "$TMPDIR"
echo "=== Restore complete ==="
