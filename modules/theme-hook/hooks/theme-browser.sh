#!/usr/bin/env bash
# Browser theme hook — applies OMARCHY theme color to Chromium-based browsers

THEME_NAME="${1:-unknown}"
THEME_DIR="${OMARCHY_THEME_DIR:-$HOME/.config/omarchy/themes/$THEME_NAME}"

CHROME_FILE="$THEME_DIR/chromium.theme"
[[ -f "$CHROME_FILE" ]] || exit 0

# Color format: "R,G,B" (0-255)
COLOR=$(cat "$CHROME_FILE")
R=$(echo "$COLOR" | cut -d, -f1)
G=$(echo "$COLOR" | cut -d, -f2)
B=$(echo "$COLOR" | cut -d, -f3)

for browser in chromium brave google-chrome; do
    POLICIES_DIR="$HOME/.config/$browser/policies/managed"
    mkdir -p "$POLICIES_DIR"
    cat > "$POLICIES_DIR/omarchy-theme.json" <<EOF
{
  "ExtensionSettings": {},
  "OmarchyThemeColor": { "R": $R, "G": $G, "B": $B }
}
EOF
done

echo "Browser theme hook: $THEME_NAME -> rgb($R,$G,$B)"
