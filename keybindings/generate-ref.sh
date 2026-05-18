#!/usr/bin/env bash
set -euo pipefail
# Keybinding reference generator — creates a markdown reference from hyprctl binds
# Inspired by okimarchy's omarchy-menu-keybindings pattern

OUTPUT="${1:-keybindings/REFERENCE.md}"
mkdir -p "$(dirname "$OUTPUT")"

cat > "$OUTPUT" <<EOF
# Omarchy Keybinding Reference
Generated: $(date)

EOF

# Resolve modifier names
modname() {
    local m=$1
    [[ $((m & 4)) -ne 0 ]] && printf "SUPER+"
    [[ $((m & 1)) -ne 0 ]] && printf "SHIFT+"
    [[ $((m & 8)) -ne 0 ]] && printf "CTRL+"
    [[ $((m & 2)) -ne 0 ]] && printf "ALT+"
}

hyprctl binds -j 2>/dev/null | python3 -c "
import json, sys

data = json.load(sys.stdin)

# Group by category
categories = {}
for b in data:
    mod = b.get('modmask', 0)
    key = b.get('key', '?')
    dispatcher = b.get('dispatcher', '')
    arg = b.get('arg', '')

    # Decode modifier mask
    mods = ''
    if mod & 4: mods += 'SUPER+'
    if mod & 1: mods += 'SHIFT+'
    if mod & 8: mods += 'CTRL+'
    if mod & 2: mods += 'ALT+'

    bind_str = f'{mods}{key}'
    desc = f'{dispatcher} {arg}'.strip()

    # Categorize
    cat = 'General'
    if 'workspace' in dispatcher:
        cat = 'Workspaces'
    elif 'window' in dispatcher or 'move' in dispatcher or 'resize' in dispatcher:
        cat = 'Windows'
    elif 'exec' in dispatcher:
        cat = 'Applications'
    elif 'kill' in dispatcher or 'exit' in dispatcher:
        cat = 'System'

    categories.setdefault(cat, []).append((bind_str, desc))

for cat in sorted(categories.keys()):
    print(f'## {cat}')
    print()
    items = categories[cat]
    for bind, desc in sorted(items):
        print(f'| \`{bind}\` | {desc} |')
    print()
" >> "$OUTPUT" 2>/dev/null || {
    # Fallback: static reference from hyprland.conf
    cat >> "$OUTPUT" <<'STATIC'
## Default Bindings

| Key | Action |
|-----|--------|
| `SUPER+Return` | Open terminal |
| `SUPER+d` | Application launcher |
| `SUPER+q` | Close active window |
| `SUPER+Shift+q` | Kill active window |
| `SUPER+1-9` | Switch to workspace 1-9 |
| `SUPER+Shift+1-9` | Move window to workspace 1-9 |
| `SUPER+Space` | Toggle floating |
| `SUPER+f` | Toggle fullscreen |
| `SUPER+l` | Lock screen |
| `SUPER+Shift+l` | Logout |
| `SUPER+Shift+e` | Exit Hyprland |
| `SUPER+Shift+s` | Screenshot region |
| `SUPER+Alt+s` | Screenshot screen |
| `SUPER+v` | Toggle split |
| `SUPER+m` | Toggle layout (dwindle/master) |
| `SUPER+h/j/k/l` | Focus window (vim keys) |
| `SUPER+Shift+h/j/k/l` | Move window (vim keys) |
| `ALT+Tab` | Cycle windows |
| `SUPER+Ctrl+r` | Reload Hyprland |
STATIC
}

echo "Keybinding reference generated: $OUTPUT"
