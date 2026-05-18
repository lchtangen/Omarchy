#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.cargo/bin:$PATH"

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
REPOS="$ROOT/repos"
DIST="$ROOT/dist"

THEME_FILES=(
  colors.toml
  waybar.css
  walker.css
  mako.ini
  hyprland.conf
  hyprlock.conf
  neovim.lua
  alacritty.toml
  btop.theme
  swayosd.css
  chromium.theme
  icons.theme
  kitty.conf
  ghostty.conf
  vscode.json
)

extract_themes() {
  local src="$REPOS/themes/colorschemes"
  local dst="$DIST/themes"
  mkdir -p "$dst"

  for theme in "$src"/*/; do
    local name
    name=$(basename "$theme")
    local out="$dst/$name"
    mkdir -p "$out"

    for f in "${THEME_FILES[@]}"; do
      [ -f "$theme/$f" ] && cp "$theme/$f" "$out/"
    done

    # backgrounds/ subdir
    if [ -d "$theme/backgrounds" ]; then
      xcp -r "$theme/backgrounds" "$out/backgrounds"
    fi

    echo "  theme: $name"
  done
}

extract_wallpapers() {
  local dst="$DIST/wallpapers"
  mkdir -p "$dst"

  find "$REPOS/themes" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' -o -iname '*.webp' \) \
    -not -path '*/.git/*' \
    -not -path '*/assets/*' \
    | while read -r f; do
        local repo theme base
        # use repo+basename to avoid clobbering when names collide
        repo=$(echo "$f" | awk -F'/' '{print $(NF-1)}')
        base=$(basename "$f")
        cp "$f" "$dst/${repo}__${base}" 2>/dev/null || true
      done

  echo "  wallpapers -> $dst"
}

extract_waybar() {
  local src="$REPOS/themes/waybar"
  local dst="$DIST/waybar"
  mkdir -p "$dst"

  for repo in "$src"/*/; do
    local name
    name=$(basename "$repo")
    local out="$dst/$name"
    mkdir -p "$out"

    find "$repo" \( -name '*.css' -o -name '*.jsonc' -o -name '*.json' -o -name 'config' -o -name 'style.css' \) \
      -not -path '*/.git/*' \
      -exec cp {} "$out/" \; 2>/dev/null

    echo "  waybar: $name"
  done
}

extract_tools() {
  local dst="$DIST/tools"
  mkdir -p "$dst"

  for repo in "$REPOS/tools"/*/; do
    local name
    name=$(basename "$repo")
    local out="$dst/$name"

    [ -d "$out" ] && rm -rf "$out"
    xcp -r "$repo" "$out"
    rm -rf "$out/.git"
    echo "  tool: $name"
  done

  for repo in "$REPOS/themes/gui-apps"/*/; do
    local name
    name=$(basename "$repo")
    local out="$dst/$name"

    [ -d "$out" ] && rm -rf "$out"
    xcp -r "$repo" "$out"
    rm -rf "$out/.git"
    echo "  gui-app: $name"
  done
}

extract_implementations() {
  local dst="$DIST/implementations"
  mkdir -p "$dst"

  for repo in "$REPOS/curated"/*/; do
    local name
    name=$(basename "$repo")
    local out="$dst/$name"

    [ -d "$out" ] && rm -rf "$out"
    xcp -r "$repo" "$out"
    rm -rf "$out/.git"
    echo "  impl: $name"
  done
}

extract_related() {
  local dst="$DIST/related"
  mkdir -p "$dst"

  for repo in "$REPOS/related"/*/; do
    local name
    name=$(basename "$repo")
    local out="$dst/$name"

    [ -d "$out" ] && rm -rf "$out"
    xcp -r "$repo" "$out"
    rm -rf "$out/.git"
    echo "  related: $name"
  done
}

extract_install_scripts() {
  local dst="$DIST/install"
  mkdir -p "$dst"

  find "$REPOS" -name 'install.sh' -not -path '*/.git/*' | while read -r f; do
    local repo
    repo=$(echo "$f" | awk -F'/' '{print $(NF-1)}')
    cp "$f" "$dst/${repo}__install.sh"
    echo "  install: ${repo}__install.sh"
  done
}

extract_docs() {
  local dst="$DIST/docs"
  mkdir -p "$dst"

  find "$REPOS" -maxdepth 3 -iname 'README.md' -not -path '*/.git/*' | while read -r f; do
    local repo
    repo=$(echo "$f" | awk -F'/' '{print $(NF-1)}')
    cp "$f" "$dst/${repo}__README.md"
  done

  echo "  docs -> $dst"
}

main() {
  echo "=== Themes ==="
  extract_themes
  echo ""
  echo "=== Wallpapers ==="
  extract_wallpapers
  echo ""
  echo "=== Waybar configs ==="
  extract_waybar
  echo ""
  echo "=== Tools (full source) ==="
  extract_tools
  echo ""
  echo "=== Implementations ==="
  extract_implementations
  echo ""
  echo "=== Related dotfiles ==="
  extract_related
  echo ""
  echo "=== Install scripts ==="
  extract_install_scripts
  echo ""
  echo "=== Docs / READMEs ==="
  extract_docs
  echo ""
  echo "=== Done ==="
  echo ""
  du -sh "$DIST"/*/
}

main "$@"
