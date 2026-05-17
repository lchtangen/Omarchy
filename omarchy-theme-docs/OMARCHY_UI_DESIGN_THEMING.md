# Omarchy UI Design and Theming

Omarchy applies consistent visual theming across every component of the desktop — terminal, editor, notifications, top bar, launcher, lock screen, and Plymouth boot screen — from a single theme directory. Themes are TOML-based color palettes with per-component override files.

**Community theme resources:**
- https://omarchythemes.com/
- https://omarchy.deepakness.com/themes
- https://github.com/topics/omarchy

---

## Theme System Overview

A theme lives in `~/.config/omarchy/themes/<theme-name>/`. When you apply a theme, Omarchy reads the color palette and generates or copies component-specific config files to each application's config directory.

All 19 built-in themes are stored in the Omarchy package installation. Community themes are cloned or downloaded into the same themes directory.

---

## Theme Directory Structure

```
~/.config/omarchy/themes/<theme-name>/
├── colors.toml          # required: 16-color palette definition
├── waybar.css           # top bar styling
├── walker.css           # launcher styling
├── swayosd.css          # on-screen display (volume/brightness)
├── mako.ini             # notification daemon styling
├── neovim.lua           # Neovim colorscheme
├── vscode.json          # VS Code theme settings
├── alacritty.toml       # terminal colors
├── ghostty              # Ghostty terminal colors (optional)
├── btop.theme           # system monitor theme
├── hyprlock.conf        # lock screen styling
└── backgrounds/         # wallpaper images
    ├── default.jpg
    └── *.jpg / *.png
```

Only `colors.toml` is required for a minimum viable theme. All other files are optional overrides.

---

## Color Palette Format (`colors.toml`)

Sixteen named colors in hex format:

```toml
[colors]
background  = "#1a1b26"
foreground  = "#c0caf5"
cursor      = "#c0caf5"

# Normal colors (ANSI 0–7)
color0  = "#15161e"   # black
color1  = "#f7768e"   # red
color2  = "#9ece6a"   # green
color3  = "#e0af68"   # yellow
color4  = "#7aa2f7"   # blue
color5  = "#bb9af7"   # magenta
color6  = "#7dcfff"   # cyan
color7  = "#a9b1d6"   # white

# Bright colors (ANSI 8–15)
color8  = "#414868"   # bright black
color9  = "#f7768e"   # bright red
color10 = "#9ece6a"   # bright green
color11 = "#e0af68"   # bright yellow
color12 = "#7aa2f7"   # bright blue
color13 = "#bb9af7"   # bright magenta
color14 = "#7dcfff"   # bright cyan
color15 = "#c0caf5"   # bright white

[extra]
accent  = "#7aa2f7"
warning = "#e0af68"
error   = "#f7768e"
```

For Wayland components (Waybar, Mako, Walker) that require CSS rgba format:
```
rgba(122, 162, 247, 1.0)   # equivalent to #7aa2f7 at full opacity
rgba(122, 162, 247, 0.85)  # 85% opacity
```

---

## Built-in Themes (19)

| Theme | Style |
|-------|-------|
| Tokyo Night | Dark blue/purple, developer default |
| Catppuccin | Pastel dark, Mocha variant |
| Catppuccin Latte | Pastel light |
| Lumon | Inspired by Severance TV show |
| Ethereal | Soft blue tones |
| Everforest | Green nature-inspired dark |
| Gruvbox | Retro warm earth tones |
| Miasma | Dark muted tones |
| Hackerman | Green-on-black hacker aesthetic |
| Osaka Jade | Japanese-inspired jade green |
| Kanagawa | Japanese woodblock painting palette |
| Nord | Arctic blue-gray |
| Matte Black | Pure dark minimalist |
| Vantablack | Extreme dark with minimal color |
| Ristretto | Warm coffee tones |
| Retro 82 | Vintage 1982 terminal aesthetic |
| Flexoki Light | Light mode ink-inspired |
| Rose Pine | Muted rose and pine tones |
| White | Light / minimal white |

---

## Switching Themes

**Via hotkey:**
```
Super + Ctrl + Shift + Space
```

**Via Omarchy Menu:**
```
Super + Alt + Space  →  Style  →  Theme
```

**Via CLI:**
```bash
omarchy theme set "Tokyo Night"
omarchy theme set "Kanagawa"
```

Theme names are case-sensitive and must match the directory name exactly.

---

## Background Images

**Via hotkey:**
```
Super + Ctrl + Space
```

Opens a visual picker showing all images in the active theme's `backgrounds/` directory. Select to apply immediately.

**Via CLI:**
```bash
# backgrounds live in the theme directory
ls ~/.config/omarchy/themes/<current-theme>/backgrounds/
```

To add custom backgrounds, copy images into the active theme's `backgrounds/` folder. Supported formats: JPG, PNG.

---

## Installing Community Themes

Copy the GitHub URL of any Omarchy-compatible theme repository, then:

```bash
omarchy theme install https://github.com/<user>/<theme-repo>
```

Or via Omarchy Menu:
```
Super + Alt + Space  →  Install  →  Style  →  Theme
```

Paste the GitHub URL when prompted.

The theme appears in the theme switcher immediately after install.

Popular community themes include: Dracula, Sakura, Synthwave '84, NES, Void, Monochrome, Evergarden, Rose Pine Dawn, Tokyo Night OLED, Batman, RetroPC.

Community discovery:
- https://omarchythemes.com/
- https://omarchy.deepakness.com/themes
- https://github.com/aorumbayev/awesome-omarchy
- https://awesome-omarchy.com/

---

## Removing Themes

```bash
# Via Omarchy Menu:
# Super + Alt + Space  →  Remove  →  Style  →  Theme
```

Built-in themes cannot be removed.

---

## Creating a Custom Theme

### Minimum viable theme

Create the directory and color file:

```bash
mkdir -p ~/.config/omarchy/themes/my-theme/backgrounds
```

Create `colors.toml` with your 16-color palette (see format above).

Apply it:
```bash
omarchy theme set "my-theme"
```

### Full theme with all components

Add each optional file for complete coverage:

```bash
~/.config/omarchy/themes/my-theme/
├── colors.toml       # palette (required)
├── waybar.css        # copy and modify from an existing theme
├── walker.css
├── mako.ini
├── neovim.lua
├── alacritty.toml
└── backgrounds/
    └── wallpaper.jpg
```

Reference an existing theme's files as a starting point:
```bash
ls ~/.config/omarchy/themes/Tokyo\ Night/
cp ~/.config/omarchy/themes/Tokyo\ Night/waybar.css ~/.config/omarchy/themes/my-theme/
```

---

## Fonts

Default font: **JetBrainsMono Nerd Font**

Nerd Fonts provide icon glyphs used throughout the UI (Waybar icons, Neovim, terminal prompts).

Install a different Nerd Font:
```bash
yay -S ttf-firacode-nerd
yay -S ttf-hack-nerd
```

List installed fonts:
```bash
fc-list | grep -i nerd
```

Change the terminal font in `~/.config/alacritty/alacritty.toml`:
```toml
[font]
normal = { family = "FiraCode Nerd Font", style = "Regular" }
size = 13.0
```

---

## Waybar Theme Variants

Waybar styling is included in each theme's `waybar.css`. Community Waybar-specific theme repos offer additional layout and style variations:

```bash
# Clone a Waybar theme repo into your tools directory
git clone https://github.com/<user>/omarchy-waybar ~/Code/omarchy-tools/waybar-theme

# Follow repo install instructions, then restart Waybar
pkill waybar && waybar &
```

---

## Omarchist (GUI Theme Designer)

Omarchist is a graphical tool for designing and previewing Omarchy themes without manual file editing.

```bash
git clone https://github.com/<omarchist-repo> ~/Code/omarchy-tools/omarchist
cd ~/Code/omarchy-tools/omarchist
./install.sh
```

Launch from Walker (`Super + Space`) or the Omarchy menu after install.

---

## Theme Hook Extensions

`omarchy-theme-hook` lets you run custom scripts whenever a theme changes — useful for updating apps not natively supported by Omarchy's theme system.

```bash
git clone https://github.com/<hook-repo> ~/Code/omarchy-tools/omarchy-theme-hook
cd ~/Code/omarchy-tools/omarchy-theme-hook
./install.sh
```

Hooks run after `omarchy theme set` completes. Add your custom script in the hook's config directory.

---

## Recovery Commands

**Theme looks broken after switching:**
```bash
# Re-apply the current theme
omarchy theme set "<current-theme-name>"
```

**Waybar missing or broken after theme change:**
```bash
pkill waybar; waybar &
```

**Restore default Tokyo Night theme:**
```bash
omarchy theme set "Tokyo Night"
```

**Reset theme configs to defaults:**
```bash
omarchy update
```

---

## See Also

- [OMARCHY_HYPRLAND_CONFIG.md](OMARCHY_HYPRLAND_CONFIG.md) — window manager and display configuration
- [OMARCHY_TOOLS_ECOSYSTEM.md](OMARCHY_TOOLS_ECOSYSTEM.md) — Omarchist, Aether, and other theme tooling
- [CYBERPUNK_2077_OMARCHY_THEME.md](CYBERPUNK_2077_OMARCHY_THEME.md) — full custom theme design example
