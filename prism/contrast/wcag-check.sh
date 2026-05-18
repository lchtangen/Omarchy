#!/usr/bin/env bash
set -euo pipefail
# WCAG contrast ratio checker
# Usage: prism/contrast/wcag-check.sh #RRGGBB #RRGGBB

hex_to_srgb() {
  local hex=${1#"#"}
  printf "%d %d %d" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2}
}

relative_luminance() {
  local r=$1 g=$2 b=$3
  local sr sg sb
  for c in r g b; do
    local val=${!c}
    local s=$(echo "scale=4; $val / 255" | bc)
    if (( $(echo "$s <= 0.03928" | bc -l) )); then
      s=$(echo "scale=4; $s / 12.92" | bc)
    else
      s=$(echo "scale=4; (($s + 0.055) / 1.055) ^ 2.4" | bc)
    fi
    eval "s$c=\$s"
  done
  echo "scale=4; 0.2126 * $sr + 0.7152 * $sg + 0.0722 * $sb" | bc
}

FG_HEX="${1:-}"
BG_HEX="${2:-}"

[ -z "$FG_HEX" ] || [ -z "$BG_HEX" ] && echo "Usage: $0 #foreground #background" && exit 1

read -r r1 g1 b1 <<< "$(hex_to_srgb $FG_HEX)"
read -r r2 g2 b2 <<< "$(hex_to_srgb $BG_HEX)"
L1=$(relative_luminance $r1 $g1 $b1)
L2=$(relative_luminance $r2 $g2 $b2)

if (( $(echo "$L1 > $L2" | bc -l) )); then
  ratio=$(echo "scale=2; ($L1 + 0.05) / ($L2 + 0.05)" | bc)
else
  ratio=$(echo "scale=2; ($L2 + 0.05) / ($L1 + 0.05)" | bc)
fi

echo "=== WCAG Contrast: $FG_HEX on $BG_HEX ==="
echo "  Contrast ratio: $ratio:1"
echo "  AA Normal text: $( (( $(echo "$ratio >= 4.5" | bc -l) )) && echo PASS || echo FAIL)"
echo "  AA Large text:  $( (( $(echo "$ratio >= 3.0" | bc -l) )) && echo PASS || echo FAIL)"
echo "  AAA Normal:     $( (( $(echo "$ratio >= 7.0" | bc -l) )) && echo PASS || echo FAIL)"
