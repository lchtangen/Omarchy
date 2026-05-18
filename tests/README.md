# Tests

Validation and integrity checks for the Omarchy repo collection.

## Validators

| Script | Purpose |
|--------|---------|
| `check-colors-toml.sh` | Verify all colorschemes have valid colors.toml |
| `check-wallpapers.sh` | Verify wallpaper files are valid images |
| `check-catalog.sh` | Verify catalog JSON matches actual repo state |
| `check-dir-structure.sh` | Verify expected directories exist |

## Running Tests

```bash
# Run all validators
bash tests/validators/run-all.sh

# Individual checks
bash tests/validators/check-colors-toml.sh
```

## Adding Tests

Place shell scripts in `tests/validators/` and test fixtures in `tests/fixtures/`.
