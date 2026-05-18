#!/usr/bin/env bash
# Terminal theme hook — reloads terminal configs after theme change
# Sends SIGUSR1/SIGUSR1 to running terminals to reload their config

# Ghostty — SIGUSR1 reloads config
pkill -SIGUSR1 ghostty 2>/dev/null || true

# Kitty — SIGUSR1 reloads colors
pkill -SIGUSR1 kitty 2>/dev/null || true

# Alacritty — no runtime reload, but notify the user
if pgrep -x alacritty &>/dev/null; then
    echo "Alacritty running — restart to pick up new theme"
fi

# Kitty users get automatic reload
if pgrep -x kitty &>/dev/null; then
    echo "Kitty theme reloaded via SIGUSR1"
fi

echo "Terminal theme hook applied"
