#!/usr/bin/env bash
set -euo pipefail
# Extract color palette from a wallpaper image
# Requires: imagemagick, color-thief (or use ImageMagick hack)

IMAGE="${1:-}"
COUNT="${2:-8}"

[ -z "$IMAGE" ] && echo "Usage: $0 <image> [colors=8]" && exit 1
[ ! -f "$IMAGE" ] && echo "File not found: $IMAGE" && exit 1

echo "=== Prism: Extracting $COUNT colors from $IMAGE ==="
echo ""

# Use ImageMagick to extract dominant colors
convert "$IMAGE" -colors "$COUNT" -depth 8 -format "%c" histogram:info: | \
  sort -rn | \
  while read -r line; do
    count=$(echo "$line" | awk '{print $1}')
    hex=$(echo "$line" | grep -oP '#\K[0-9A-Fa-f]{6}')
    if [ -n "$hex" ]; then
      echo "  #$hex  ($count pixels)"
    fi
  done

echo ""
echo "To generate a full theme: prism/palette/generate.sh $IMAGE"
