#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob
# Generate exhaustive repo catalog from repos/ on disk
# Outputs catalog/all.json with complete metadata

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
REPOS="$ROOT/repos"
OUT="$ROOT/catalog/all.json"

total=$(find -L "$REPOS" -mindepth 3 -maxdepth 4 -name '.git' -type d | wc -l)
echo "{\"generated\": \"$(date -Iseconds)\", \"total\": $total, \"categories\": {" > "$OUT"

first_cat=true
for cat in themes tools configs curated related; do
  $first_cat || echo "," >> "$OUT"
  first_cat=false
  echo "  \"$cat\": {" >> "$OUT"
  first_sub=true

  case $cat in
    themes)
      for sub in gui-apps waybar colorschemes gtk; do
        $first_sub || echo "," >> "$OUT"
        first_sub=false
        echo "    \"$sub\": [" >> "$OUT"
        first_repo=true
        for dir in "$REPOS/themes/$sub"/*/; do
          [[ -d "$dir/.git" ]] || continue
          name=$(basename "$dir")
          $first_repo || echo "," >> "$OUT"
          first_repo=false
          echo "      {\"name\": \"$name\", \"path\": \"repos/themes/$sub/$name\"}" >> "$OUT"
        done
        echo "    ]" >> "$OUT"
      done
      ;;
    tools)
      echo "    \"all\": [" >> "$OUT"
      first_repo=true
      for dir in "$REPOS/tools"/*/; do
        [[ -d "$dir/.git" ]] || continue
        name=$(basename "$dir")
        $first_repo || echo "," >> "$OUT"
        first_repo=false
        echo "      {\"name\": \"$name\", \"path\": \"repos/tools/$name\"}" >> "$OUT"
      done
      echo "    ]" >> "$OUT"
      ;;
    configs)
      echo "    \"all\": [" >> "$OUT"
      first_repo=true
      for dir in "$REPOS/configs"/*/; do
        [[ -d "$dir/.git" ]] || continue
        name=$(basename "$dir")
        $first_repo || echo "," >> "$OUT"
        first_repo=false
        echo "      {\"name\": \"$name\", \"path\": \"repos/configs/$name\"}" >> "$OUT"
      done
      echo "    ]" >> "$OUT"
      ;;
    curated)
      echo "    \"all\": [" >> "$OUT"
      first_repo=true
      for dir in "$REPOS/curated"/*/; do
        [[ -d "$dir/.git" ]] || continue
        name=$(basename "$dir")
        $first_repo || echo "," >> "$OUT"
        first_repo=false
        echo "      {\"name\": \"$name\", \"path\": \"repos/curated/$name\"}" >> "$OUT"
      done
      echo "    ]" >> "$OUT"
      ;;
    related)
      echo "    \"all\": [" >> "$OUT"
      first_repo=true
      for dir in "$REPOS/related"/*/; do
        [[ -d "$dir/.git" ]] || continue
        name=$(basename "$dir")
        $first_repo || echo "," >> "$OUT"
        first_repo=false
        echo "      {\"name\": \"$name\", \"path\": \"repos/related/$name\"}" >> "$OUT"
      done
      echo "    ]" >> "$OUT"
      ;;
  esac
  echo "  }" >> "$OUT"
done

echo "}}" >> "$OUT"
echo "Catalog generated: $OUT ($(grep -oP '"total": \K\d+' "$OUT") repos)"
