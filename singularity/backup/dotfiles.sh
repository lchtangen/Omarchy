#!/usr/bin/env bash
set -euo pipefail
# Config backup — snapshot dotfiles with timestamp

BACKUP_DIR="/tmp/omarchy-backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "=== Singularity Backup ==="

# Configs
[ -d ~/.config/hypr ] && cp -r ~/.config/hypr "$BACKUP_DIR/"
[ -d ~/.config/waybar ] && cp -r ~/.config/waybar "$BACKUP_DIR/"
[ -d ~/.config/walker ] && cp -r ~/.config/walker "$BACKUP_DIR/"
[ -d ~/.config/omarchy ] && cp -r ~/.config/omarchy "$BACKUP_DIR/"
[ -d ~/.config/mako ] && cp -r ~/.config/mako "$BACKUP_DIR/"
[ -d ~/.config/alacritty ] && cp -r ~/.config/alacritty "$BACKUP_DIR/"

# Shell configs
[ -f ~/.zshrc ] && cp ~/.zshrc "$BACKUP_DIR/"
[ -f ~/.bashrc ] && cp ~/.bashrc "$BACKUP_DIR/"
[ -f ~/.config/fish/config.fish ] && cp ~/.config/fish/config.fish "$BACKUP_DIR/"

echo "Backup saved to: $BACKUP_DIR"
tar czf "$BACKUP_DIR.tar.gz" -C "$BACKUP_DIR" .
echo "Archive: $BACKUP_DIR.tar.gz"
