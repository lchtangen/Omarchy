# Omarchy Hyprland Configuration

Hyprland is a dynamic tiling Wayland compositor written in C++. It powers Omarchy's entire visual desktop layer — window management, animations, multi-monitor, workspace handling, and input. Config auto-reloads on file save with no restart required.

**Upstream references:**
- https://hyprland.org/
- https://wiki.hyprland.org/
- https://github.com/hyprwm/Hyprland

---

## Config File Locations

| File | Purpose |
|------|---------|
| `~/.config/hypr/hyprland.conf` | Main Hyprland config |
| `~/.config/hypr/bindings.conf` | Keyboard and mouse bindings |
| `~/.config/hypr/monitors.conf` | Monitor layout and scaling |
| `~/.config/waybar/config` | Top bar configuration |
| `~/.config/waybar/style.css` | Top bar styling |
| `~/.config/walker/` | Application launcher config |
| `~/.config/mako/config` | Notification daemon config |
| `~/.config/hypr/hyprlock.conf` | Lock screen config |

All configs support live reload. Save the file and changes apply immediately.

---

## Modifier Key

The default modifier is `SUPER` (Windows/Meta key). It can be changed to `ALT` or any other key in `hyprland.conf`.

Throughout this doc, `Super` = the modifier key.

---

## Hotkey Reference

### Getting Help

| Hotkey | Action |
|--------|--------|
| `Super + K` | Show all current hotkeys overlay |
| `Super + Alt + Space` | Open Omarchy Menu (all settings) |

### Workspaces

| Hotkey | Action |
|--------|--------|
| `Super + 1` | Switch to workspace 1 |
| `Super + 2` | Switch to workspace 2 |
| `Super + 3` | Switch to workspace 3 |
| `Super + 4` | Switch to workspace 4 |
| `Super + Shift + 1–4` | Move focused window to workspace N |

### Application Launching

| Hotkey | Action |
|--------|--------|
| `Super + Space` | Open Walker (application launcher) |
| `Super + Return` | Open Alacritty terminal |
| `Super + Shift + Return` | Open Chromium browser |
| `Super + Shift + N` | Open Neovim |
| `Super + Shift + O` | Open Obsidian |
| `Super + E` | Open file manager |

### Window Management

| Hotkey | Action |
|--------|--------|
| `Super + W` | Close focused window |
| `Super + F` | Fullscreen |
| `Super + Alt + F` | Full-width (pseudo-fullscreen) |
| `Super + Ctrl + F` | Fullscreen within a group/container |
| `Super + T` | Toggle tiling / floating mode |
| `Super + J` | Stack windows horizontally |
| `Super + Shift + Arrow` | Swap window with adjacent |
| `Super + Arrow` | Move focus in direction |

### Window Grouping

| Hotkey | Action |
|--------|--------|
| `Super + G` | Group focused window with adjacent |
| `Super + Ctrl + Arrows` | Navigate between grouped windows |
| `Super + Alt + G` | Ungroup window from current group |

### System Controls

| Hotkey | Action |
|--------|--------|
| `Super + Ctrl + A` | Audio controls |
| `Super + Ctrl + W` | WiFi settings |
| `Super + Ctrl + L` | Lock screen (hyprlock) |
| `Print Screen` | Screenshot (full screen) |
| `Super + Ctrl + C` | Screenshot / capture menu |

### Visual Customization

| Hotkey | Action |
|--------|--------|
| `Super + Ctrl + Space` | Background image picker |
| `Super + Ctrl + Shift + Space` | Theme switcher |

### Clipboard

| Hotkey | Action |
|--------|--------|
| `Super + C` | Copy (universal, works outside file manager) |
| `Super + X` | Cut |
| `Super + V` | Paste |

---

## Adding Custom Keybindings

Edit `~/.config/hypr/bindings.conf`. Hyprland keybinding syntax:

```conf
bind = SUPER, Return, exec, alacritty
bind = SUPER SHIFT, Return, exec, chromium
bind = SUPER, W, killactive,
bind = SUPER, F, fullscreen, 0
```

Syntax: `bind = <MODIFIERS>, <KEY>, <DISPATCHER>, <PARAMS>`

Common dispatchers:
- `exec` — run a command
- `killactive` — close focused window
- `fullscreen` — fullscreen (0 = full, 1 = maximize)
- `workspace` — switch workspace
- `movetoworkspace` — move window to workspace
- `togglefloating` — toggle float mode
- `layoutmsg, togglesplit` — toggle dwindle split direction on Hyprland 0.54+

Modifier aliases: `SUPER`, `ALT`, `CTRL`, `SHIFT`, and combinations like `SUPER SHIFT`.

Key names follow xkb conventions: `Return`, `space`, `F1`–`F12`, `left`, `right`, `up`, `down`, letter keys are lowercase.

---

## Window Animations

Hyprland supports smooth animations with configurable bezier curves. In `hyprland.conf`:

```conf
animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}
```

Set `enabled = false` to disable all animations for performance.

---

## Blur and Transparency

Control in `hyprland.conf`:

```conf
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 8
        passes = 2
    }
    shadow {
        enabled = true
        range = 4
        render_power = 3
    }
}
```

Note: older Hyprland configs used `drop_shadow = true` / `shadow_range` / `shadow_render_power` as flat keys. Hyprland 0.40+ moved these into a `shadow { }` block. Use the block form on current Omarchy installs.

- `rounding` — window corner radius in pixels (0 = square)
- `blur.size` — blur radius
- `blur.passes` — blur passes (higher = smoother, more GPU cost)

---

## Trackpad Gestures

```conf
input {
    touchpad {
        natural_scroll = true
        disable_while_typing = true
        tap-to-click = true
    }
}
```

Omarchy enables natural scroll and tap-to-click by default. Adjust in `hyprland.conf`.

---

## Multi-Monitor Setup

Use `hyprmon` (community tool) for a GUI monitor configurator, or edit `~/.config/hypr/monitors.conf` directly:

```conf
monitor = DP-1, 2560x1440@144, 0x0, 1
monitor = HDMI-A-1, 1920x1080@60, 2560x0, 1
```

Format: `monitor = <name>, <resolution>@<hz>, <offset-x>x<offset-y>, <scale>`

List connected monitors:
```bash
hyprctl monitors
```

---

## Waybar (Top Bar)

Waybar displays workspaces, clock, system tray, and status indicators.

Recommended startup is Hyprland-owned autostart. Add this to the `# === AUTOSTART === #` section in `~/.config/hypr/hyprland.conf`:

```conf
exec-once = waybar
```

Use the Omarchy guard when Waybar is missing, duplicated, or crashed:

```bash
om system guard
```

Restart or refresh after config changes:

```bash
om system reload
```

Config: `~/.config/waybar/config`
Style: `~/.config/waybar/style.css`

Avoid repeatedly launching raw `waybar &` from a terminal. It works as a quick one-off, but it can leave duplicate bars behind; `om system guard` keeps exactly one instance running.

Community Waybar themes can be installed independently — see [OMARCHY_TOOLS_ECOSYSTEM.md](OMARCHY_TOOLS_ECOSYSTEM.md).

---

## Walker (Application Launcher)

Walker opens with `Super + Space`. It supports:
- Application launching
- File search
- Custom commands
- Plugin extensions

Config directory: `~/.config/walker/`

---

## Mako (Notifications)

Mako is the Wayland notification daemon. Config: `~/.config/mako/config`

Dismiss a notification: click it or press `Escape`.
Dismiss all: `makoctl dismiss --all`

Themes style Mako automatically via `mako.ini` in the theme directory.

---

## Hyprlock (Lock Screen)

Lock the screen:
```bash
hyprlock
```

Or bind a hotkey in `bindings.conf`:
```conf
bind = SUPER CTRL, L, exec, hyprlock
```

Config: `~/.config/hypr/hyprlock.conf`

---

## Querying Hyprland State

```bash
hyprctl clients          # list open windows
hyprctl workspaces       # list workspaces
hyprctl monitors         # list monitors
hyprctl activewindow     # info on focused window
hyprctl dispatch <cmd>   # run a dispatcher programmatically
```

---

## Restarting Hyprland

If Hyprland becomes unresponsive:
```bash
hyprctl reload          # reload config without restart
```

Hard restart (drops back to TTY):
```bash
pkill Hyprland
```

Log back in and Hyprland will start automatically via the auto-login configuration.

---

## See Also

- [OMARCHY_UI_DESIGN_THEMING.md](OMARCHY_UI_DESIGN_THEMING.md) — theme system and visual customization
- [OMARCHY_TOOLS_ECOSYSTEM.md](OMARCHY_TOOLS_ECOSYSTEM.md) — Waybar themes, monitor tools, shell integrations
