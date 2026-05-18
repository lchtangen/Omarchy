# Patches

Upstream patches for Omarchy ecosystem repositories.
Each patch targets a specific repo and version.

## Naming Convention

```
patches/
├── <repo-name>/
│   ├── <short-description>.patch
│   └── README.md        # What each patch does
```

## Applying Patches

```bash
cd repos/themes/colorschemes/omarchy-ash-theme
git apply ../../../patches/omarchy-ash-theme/fix-colors-toml-typo.patch
```

## Creating Patches

```bash
cd repos/themes/colorschemes/omarchy-ash-theme
git diff > ../../../patches/omarchy-ash-theme/my-fix.patch
```
