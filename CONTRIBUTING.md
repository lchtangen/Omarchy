# Contributing

## Adding a new repository

1. Clone into the appropriate subdirectory under `repos/`:
   - `repos/themes/colorschemes/` — color themes with style files
   - `repos/themes/gui-apps/` — GUI theming applications
   - `repos/themes/waybar/` — Waybar configuration collections
   - `repos/themes/gtk/` — GTK theme engines
   - `repos/tools/` — system utilities and CLI tools
   - `repos/configs/` — full dotfiles / configuration sets
   - `repos/curated/` — curated lists and platform ports

2. Update `catalog/themes.json`, `catalog/tools.json`, or `catalog/configs.json` with the new entry.

3. Run `make extract` to verify extraction works.

## Requirements

- Repo must be Omarchy-related or Hyprland-compatible
- Themes must follow the Omarchy TOML palette convention (or be convertible)
- No unlicensed or proprietary assets
