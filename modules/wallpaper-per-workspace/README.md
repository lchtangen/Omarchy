# Wallpaper per Workspace

Changes Hyprland wallpaper automatically when switching workspaces.

## Usage

```bash
# Set wallpaper directory with numbered subdirs or files
export WALLPAPER_DIR="$HOME/Pictures/wallpapers"
./listener.sh
```

## Directory format

```
wallpapers/
  workspace-1/    # Random wallpaper for workspace 1
  workspace-2/    # Random wallpaper for workspace 2
  ...
  workspace-9/    # Random wallpaper for workspace 9
```

Or fallback to flat files in `$WALLPAPER_DIR` if no workspace-specific dirs exist.

## Autostart

Add to Hyprland config:
```
exec-once = /path/to/modules/wallpaper-per-workspace/listener.sh
```
