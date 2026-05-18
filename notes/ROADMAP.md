# Roadmap

## Phase 1 — Foundation (Done)
- [x] Clone 54 top-starred Omarchy repositories
- [x] Organize into logical category structure
- [x] Add extraction automation (make extract)
- [x] Add catalog manifests (themes.json, tools.json, configs.json)
- [x] Add Makefile for common operations

## Phase 2 — Templates & Modules (Current)
- [x] Theme skeleton template
- [x] Config file templates
- [x] Reusable Waybar/Hyprland modules
- [x] Dependency manifests (pacman/Yay)
- [x] Keybinding reference

## Phase 3 — Validation & Testing
- [ ] Validate colors.toml across all 24 colorschemes
- [ ] Ensure all themes have required files (colors.toml)
- [ ] Test that extracted configs apply cleanly
- [ ] Add CI pipeline (GitHub Actions)
- [ ] Add pre-commit hooks for catalog linting

## Phase 4 — Advanced Tooling
- [ ] omarchy-inventory: CLI tool to query the catalog
- [ ] omarchy-apply: One-command theme/module installer
- [ ] omarchy-diff: Compare two theme configs
- [ ] omarchy-preview: Generate theme preview images
- [ ] Web dashboard for browsing extracted assets

## Phase 5 — Community
- [ ] Accept PRs for new repos
- [ ] Auto-generate docs from catalog
- [ ] Publish extracted themes as AUR package
- [ ] Add screenshot gallery from wallpapers
