#!/usr/bin/env bash
set -euo pipefail
# Multi-device dotfile sync via git + syncthing
# Usage: matrix/sync/dotfiles.sh [push|pull]

ACTION="${1:-push}"
REPO="${OMARCHY_SYNC_REPO:-$HOME/Omarchy}"
REMOTE="${OMARCHY_REMOTE:-origin}"
BRANCH="${OMARCHY_BRANCH:-$(hostname)}"

case "$ACTION" in
  push)
    cd "$REPO"
    git add -A
    git commit --allow-empty -m "sync from $(hostname) at $(date -Iseconds)"
    git push "$REMOTE" "HEAD:$BRANCH"
    echo "Pushed to $REMOTE/$BRANCH"
    ;;
  pull)
    cd "$REPO"
    git fetch "$REMOTE"
    git reset --hard "$REMOTE/$BRANCH"
    echo "Pulled from $REMOTE/$BRANCH"
    ;;
  *)
    echo "Usage: $0 [push|pull]"
    exit 1
    ;;
esac
