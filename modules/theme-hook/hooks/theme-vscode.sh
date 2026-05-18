#!/usr/bin/env bash
# VS Code / Cursor theme hook — sets workbench.colorTheme from theme config

THEME_NAME="${1:-unknown}"
THEME_DIR="${OMARCHY_THEME_DIR:-$HOME/.config/omarchy/themes/$THEME_NAME}"

VSCODE_FILE="$THEME_DIR/vscode.json"
[[ -f "$VSCODE_FILE" ]] || exit 0

VSCODE_THEME_NAME=$(head -1 "$VSCODE_FILE" 2>/dev/null | tr -d '\n')
[[ -z "$VSCODE_THEME_NAME" ]] && exit 0

for app in Code Cursor; do
    SETTINGS_DIR="$HOME/.config/$app/User"
    mkdir -p "$SETTINGS_DIR"
    SETTINGS_FILE="$SETTINGS_DIR/settings.json"
    if [[ -f "$SETTINGS_FILE" ]]; then
        # Update workbench.colorTheme in place
        sed -i "s/\"workbench.colorTheme\":.*/\"workbench.colorTheme\": \"$VSCODE_THEME_NAME\",/" "$SETTINGS_FILE"
    else
        echo "{\"workbench.colorTheme\": \"$VSCODE_THEME_NAME\"}" > "$SETTINGS_FILE"
    fi
    # Trigger reload via IPC if possible
    if command -v "$app" &>/dev/null; then
        "$app" --reload-window &>/dev/null &
    fi
done

echo "VSCode theme hook: $THEME_NAME -> $VSCODE_THEME_NAME"
