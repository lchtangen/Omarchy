# Singularity — Self-Healing Automation

Autonomous system maintenance — repair, backup, watchdog, and recovery.
The system that fixes itself before you notice.

Patterns ported from ArchRiot (debounced reload, waybar guard, suspend guard)
and omarchy-config (stabilize-session, battery monitor).

## Recommended Waybar Flow

Start Waybar from Hyprland so it inherits the correct Wayland session:

```conf
exec-once = dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
exec-once = waybar
```

Keep recovery idempotent with the Omarchy CLI:

```bash
om system guard
om system stabilize
```

For periodic self-healing, install the user timer units and enable the timer:

```bash
mkdir -p ~/.config/systemd/user
ln -sf "$HOME/Omarchy/singularity/timers/waybar-guard.service" ~/.config/systemd/user/waybar-guard.service
ln -sf "$HOME/Omarchy/singularity/timers/waybar-guard.timer" ~/.config/systemd/user/waybar-guard.timer
systemctl --user daemon-reload
systemctl --user enable --now waybar-guard.timer
```

The timer is a fallback guard. Hyprland autostart remains the primary startup path because it runs inside the compositor session.
The service intentionally does not hardcode `WAYLAND_DISPLAY`; the `dbus-update-activation-environment` line above gives systemd the active session values.

## Structure

```
singularity/
├── timers/              # systemd timer units
│   ├── omarchy-heal.service    # Health check service
│   ├── omarchy-heal.timer      # Every 30 min
│   ├── omarchy-backup.service  # Backup service
│   ├── omarchy-backup.timer    # Daily at 3am
│   ├── waybar-guard.service    # Waybar restart guard (ArchRiot)
│   ├── waybar-guard.timer      # Every 5 min
│   ├── battery-monitor.service # Battery level check (ArchRiot)
│   └── battery-monitor.timer   # Every 30 sec
├── repair/              # Auto-repair scripts
│   ├── fix-pacman.sh    # Package database repair
│   ├── fix-waybar.sh    # Waybar crash recovery
│   ├── guard-waybar.sh  # Waybar instance guard (ArchRiot)
│   ├── debounced-reload.sh # Debounced hyprctl reload (ArchRiot Go)
│   ├── suspend-guard.sh # Block suspend during critical tasks
│   ├── stabilize-session.sh # Kill runaway, restart guards (ArchRiot)
│   ├── fix-hyprland.sh  # Hyprland config errors
│   └── fix-dbus.sh      # D-Bus session recovery
├── backup/              # Backup automation
│   ├── dotfiles.sh      # Config backup
│   ├── themes.sh        # Theme export
│   └── packages.sh      # Package list export
└── watchdog/            # System monitoring daemons
    ├── monitor.sh       # Process health monitor
    └── rotate.sh        # Log rotation
```
