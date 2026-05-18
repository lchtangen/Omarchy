# Omarchy

A curated collection of **top-starred Omarchy repositories** — themes, tools, configs — fused with a futuristic, self-healing, AI-augmented project infrastructure for Omarchy Arch Linux / Hyprland.

```
Omarchy/
├── catalog/           # JSON manifests + awesome-omarchy.md repo catalog
├── src/cli/           # om — CLI toolbox (like linutil)
│   ├── om             # Main entry: om <catalog|theme|system|status|update>
│   ├── om-catalog     # Subcommand: browse/search/recommend repos
│   ├── om-theme       # Subcommand: list/set/install themes
│   └── om-system      # Subcommand: info/health/stabilize/reload
├── src/catalog/       # Catalog generation scripts
├── ... (20 futuristic dirs) ...
└── Makefile           # make status | extract | update | lint | test
```

## Quick Start

```bash
# CLI Toolbox (inspired by linutil)
./src/cli/om               # Show help
./src/cli/om catalog stats # Catalog overview
./src/cli/om catalog list  # List all repos
./src/cli/om catalog search retro # Search repos
./src/cli/om system info   # System info
./src/cli/om system health # Health check
./src/cli/om theme list    # List installed themes

# Make targets
make status          # View project overview
make extract         # Extract assets from repos/ into dist/
make test            # Run config validators
make update          # Pull latest from all repos
make lint            # Check structure integrity
```

Install the CLI to PATH:
```bash
sudo ln -sf "$PWD/src/cli/om" /usr/local/bin/om
```

## Category Inventory

| Area | Count | Description |
|------|-------|-------------|
| Themes — GUI Apps | 4 | omarchist, aether, tema, theme-builder |
| Themes — Waybar | 3 | HANCORE, minimal, Adsovetzky |
| Themes — Colorschemes | ~104 | ash, futurism, retroPC, sakura, doom, dracula, synthwave, etc. |
| Themes — GTK | 1 | omarchy-gtk-theme |
| Tools | 13 | wayscriber, hyprmon, cleaner, ostt, etc. |
| Configs | 1 | omarchy-config |
| Curated | 8 | awesome lists, omarchy-hub, ports |
| Nexus (AI) | 5 | Agent configs, prompts, MCP servers, workflows |
| Cyberdeck (Security) | 5 | Kernel hardening, firewall, encryption, audit scanner |
| Observatory (Monitoring) | 4 | Dashboards, telemetry, alerts, healthchecks |
| Hologram (Visuals) | 5 | GLSL shaders, neon animations, border glow |
| Cortex (Adaptive) | 4 | Hardware detection, ambient theming, predictive preload |
| Orbital (Containers) | 4 | Distrobox, dev stack compose, container registry |
| Singularity (Self-Heal) | 5 | systemd timers, auto-repair, backup, watchdog |
| Protocol (Integration) | 4 | MCP servers, webhooks, API contracts, IPC format |
| Matrix (Mesh) | 5 | Dotfile sync, node definitions, ZeroTier mesh |
| Ark (Recovery) | 5 | Btrfs snapshots, config restore, 3-2-1 strategy |
| Synapse (Neural) | 4 | Ollama config, model manifests, inference benchmarks |
| Echo (Voice) | 4 | Whisper STT, voice commands, PipeWire routing |
| Phantom (Sandbox) | 3 | Firejail profiles, Bubblewrap, theme test sandbox |
| Drone (CI/CD) | 4 | GitHub Actions, AUR deploy, pipeline definitions |
| Ghost (Stealth) | 4 | VPN kill switch, camera/mic disable, privacy mode |
| Aegis (Access) | 4 | TPM2 LUKS unlock, TOTP 2FA, biometric auth |
| Forge (Build) | 3 | Optimized makepkg, PKGBUILD templates |
| Oracle (Predict) | 4 | Disk forecasting, app prediction, analytics |
| Beacon (Presence) | 4 | Bluetooth proximity unlock, network geofence |
| Prism (Color) | 4 | Palette extraction, WCAG contrast, wallpaper analysis |
| Templates | 1 | Theme skeleton with all component files |
| Wallpaper Categories | 9 | abstract, anime, dark, gradients, landscapes, minimal, nature, space, tech |
| Waybar Modules | 4 | clock, workspaces, media, system tray |
| Hyprland Modules | 4 | animations, window-rules, env-vars, monitor-setup |
| Overlays | 3 | desktop, laptop, vm-minimal |
| Tests | 2 | colors validation, runner |
| ADRs | 3 | Repository structure, theme categorization, extraction strategy |

**Repos: 203 cloned | Custom dirs: 32 | Total entries: ~400+**
