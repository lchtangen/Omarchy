# Architecture Decision Records

## ADR-001: Repository Structure

**Date:** 2026-05-18

**Status:** Accepted

**Context:** The project needed a professional structure for managing 50+ cloned
Omarchy repositories while enabling automated extraction of assets.

**Decision:**
- `repos/` for upstream mirrors (immutable, git-managed)
- `dist/` for extracted outputs (auto-generated, gitignored)
- `catalog/` for machine-readable metadata (curated JSON)
- `docs/` for human-readable documentation
- `src/` for scripts and tooling

**Consequences:**
- Clear separation between source and build artifacts
- Easy to update repos (`make update`) without losing extracted state
- Machine-readable catalog enables tooling

---

## ADR-002: Theme Subcategorization

**Date:** 2026-05-18

**Status:** Accepted

**Context:** 31 theme-related repos were all in a flat `repos/themes/` directory,
mixing GUI applications, Waybar configs, GTK themes, and pure colorschemes.

**Decision:**
- `gui-apps/` — Full applications (omarchist, aether, tema, theme-builder)
- `waybar/` — Waybar-specific configuration collections
- `colorschemes/` — Pure theme repos with style files
- `gtk/` — GTK theme engine repos

**Consequences:**
- Easier to find relevant repos by type
- Extraction scripts can target specific subdirectories
- Clearer for contributors where to add new repos

---

## ADR-003: Extraction Strategy

**Date:** 2026-05-18

**Status:** Accepted

**Context:** Assets (themes, wallpapers, configs) are embedded inside cloned repos
and need to be usable independently.

**Decision:**
- `make extract` copies theme files from repos to `dist/themes/`
- No symlinks — full copies for standalone use
- Wallpapers are flattened into `dist/wallpapers/`
- Waybar configs copied to `dist/waybar/` by repo name

**Consequences:**
- `dist/` is self-contained and can be rsync'd or packaged
- Changes to upstream repos require re-extraction
- Deduplication of wallpapers is a future concern
