# Configuration Overlays

Per-device configuration profiles that override or extend the base setup.
Useful for adapting Omarchy to different hardware.

## Profiles

| Profile | Target Hardware |
|---------|-----------------|
| `desktop/` | Full workstation, multi-monitor, high performance |
| `laptop/` | Single display, power saving, touchpad tuning |
| `vm-minimal/` | Virtual machine, limited resources, no GPU accel |

## Usage

```bash
# Apply a device overlay
cp -r overlays/laptop/* ~/.config/hypr/
cp -r overlays/laptop/waybar/* ~/.config/waybar/

# Or symlink for live updates
ln -sf "$PWD/overlays/laptop/monitors.conf" ~/.config/hypr/monitors.conf
```
