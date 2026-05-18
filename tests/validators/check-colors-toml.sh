#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
errors=0
warnings=0

echo "=== Checking .git presence (all repo dirs) ==="
for dir in "$ROOT"/repos/themes/gui-apps/*/ "$ROOT"/repos/themes/waybar/*/ \
           "$ROOT"/repos/themes/colorschemes/*/ "$ROOT"/repos/themes/gtk/*/ \
           "$ROOT"/repos/tools/*/ "$ROOT"/repos/configs/*/ "$ROOT"/repos/curated/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  if [ ! -d "$dir/.git" ]; then
    echo "  MISSING .git: $name"
    errors=$((errors + 1))
  fi
done
echo "  Done."

echo "=== Checking colors.toml in colorschemes (soft) ==="
for theme in "$ROOT"/repos/themes/colorschemes/*/; do
  [ -d "$theme/.git" ] || continue
  name=$(basename "$theme")
  if [ ! -f "$theme/colors.toml" ]; then
    if ls "$theme"/*.toml 2>/dev/null | grep -q .; then
      echo "  ALT CONFIG: $name ($(ls "$theme"/*.toml 2>/dev/null | head -1 | xargs basename))"
      warnings=$((warnings + 1))
    else
      echo "  MISSING colors.toml: $name"
      warnings=$((warnings + 1))
    fi
  fi
done
echo "  Done."

echo "=== Checking foreground/background in existing colors.toml ==="
for theme in "$ROOT"/repos/themes/colorschemes/*/; do
  [ -d "$theme/.git" ] || continue
  f="$theme/colors.toml"
  name=$(basename "$theme")
  if [ -f "$f" ]; then
    if ! grep -q 'foreground' "$f" 2>/dev/null; then
      echo "  WARN (no foreground): $name"
      warnings=$((warnings + 1))
    fi
    if ! grep -q 'background' "$f" 2>/dev/null; then
      echo "  WARN (no background): $name"
      warnings=$((warnings + 1))
    fi
  fi
done
echo "  Done."

echo "=== Manifest consistency ==="
theme_count=$(find "$ROOT"/repos/themes -mindepth 3 -maxdepth 3 -name '.git' -type d | wc -l)
echo "  repos/themes total: $theme_count (gui-apps + waybar + colorschemes + gtk)"
echo "  catalog/themes.json entries: $(python3 -c "import json; d=json.load(open('$ROOT/catalog/themes.json')); print(sum(len(v) for v in d.values()))" 2>/dev/null || echo "parse error")"

echo "=== Results: $errors errors, $warnings warnings ==="
exit $errors
