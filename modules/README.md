# Reusable Configuration Modules

Modular, composable config snippets for Hyprland ecosystem components.
Designed to be sourced/included rather than written from scratch.

## Modules

### Waybar

| Module | Description |
|--------|-------------|
| `custom-media.jsonc` | Now Playing module with playerctl |
| `custom-notifications.jsonc` | Notification indicator |
| `hyprland-workspaces.jsonc` | Workspace-aware pager |
| `system-tray.jsonc` | System tray with network/audio/battery |
| `clock.jsonc` | Date/time with calendar popup |
| `window-pill.py` | Socket-based active window pill (HANCORE) |
| `scrolling-mpris.py` | Smooth-scrolling MPRIS now-playing (HANCORE) |
| `cava.sh` | Braille audio visualizer (HANCORE) |
| `omarchy-logo.py` | SVG glyph generator for logo button (omarchy-config) |

### Hyprland

| Module | Description |
|--------|-------------|
| `animations.conf` | Smooth animations presets |
| `window-rules.conf` | App-specific window rules |
| `env-vars.conf` | Environment variables for Wayland |
| `bindings.conf` | Keybinding presets |
| `monitor-setup.conf` | Multi-monitor templates |
| `battery-monitor.sh` | Systemd-timer battery monitor (ArchRiot) |

### Hypr Animations (8 presets from omarchy-config)

| Module | Style |
|--------|-------|
| `diablo-1.conf` | Aggressive snappy, popin 80%, borderangle loop |
| `diablo-2.conf` | Popin windows, overshot workspaces |
| `dynamic.conf` | Smooth wind bezier, simple and clean |
| `end4.conf` | Material Design 3 curves, popin 60% |
| `ja.conf` | Smooth in/out, borderangle 180° loop |
| `LimeFrenzy.conf` | Soft overshot, popin 60%, 24° borderangle loop |
| `hight.conf` | Dynamic-style wind bezier, faster |
| `me.conf` | MD3 + wind, full layer/workspace, most comprehensive |

### Theme Hook System

| File | Description |
|------|-------------|
| `apply.sh` | Main theme setter — links, wallpapers, hooks, reloads |
| `hooks/theme-gtk.sh` | GTK theme + CSS generator (okimarchy pattern) |
| `hooks/theme-terminal.sh` | SIGUSR1 to Ghostty/Kitty for reload |
| `hooks/theme-browser.sh` | Chromium policy theme color (okimarchy) |
| `hooks/theme-vscode.sh` | VS Code/Cursor colorTheme setter |
| `hooks/theme-obsidian.sh` | Obsidian CSS generator (okimarchy 684-line) |

### Sound FX (omarchy-config SAO pattern)

| File | Description |
|------|-------------|
| `fx.sh` | Helper — plays mp3/wav via mpv/paplay |
| `bindings.conf` | Keybindings with audio feedback decorator |

### Walker

| Module | Description |
|--------|-------------|
| `config-plugins.toml` | Plugin configuration snippets |
| `appearance.toml` | Theme and appearance overrides |

### Mako

| Module | Description |
|--------|-------------|
| `urgency-config.ini` | Urgency level presets |
| `action-buttons.ini` | Notification action buttons |

### Alacritty

| Module | Description |
|--------|-------------|
| `font-config.toml` | Nerd Font presets |
| `key-bindings.toml` | Custom key binding presets |

## Usage

Include or copy modules into your active config:

```bash
# Example: add a waybar module
cat modules/waybar/clock.jsonc >> ~/.config/waybar/config.jsonc
```
