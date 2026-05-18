# Changelog

## Unreleased

### Added
- `templates/` — Theme skeleton and config templates for rapid theme creation
- `packages/` — Dependency manifests (core, optional, AUR) for system setup
- `wallpapers/` — Curated wallpaper directory organized by aesthetic category
- `keybindings/` — Hyprland keyboard shortcut reference
- `modules/` — Reusable config snippets for Waybar, Hyprland, Walker, Mako, Alacritty
- `notes/` — Architecture Decision Records, changelog, roadmap
- `tests/` — Validation scripts for config integrity
- `overlays/` — Per-device configuration overlays (desktop, laptop, VM)
- `patches/` — Patches for upstream compatibility

### Changed
- Restructured from flat layout to professional tiered hierarchy
- `omarchy-theme-docs/` → `docs/` with subcategories (guides, ecosystem, themes)
- `repos/themes/` split into `gui-apps/`, `waybar/`, `colorschemes/`, `gtk/`
- Added JSON manifests in `catalog/` for machine-readable metadata
- Added `Makefile` with `extract`, `status`, `update`, `lint`, `clean` targets
- Added `src/scripts/extract.sh` for automated asset extraction
