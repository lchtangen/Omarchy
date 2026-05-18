# Cyberpunk 2077 Inspired Omarchy Theme Design

Status: design and implementation spec  
Target system: Omarchy on `/dev/nvme0n1p3`  
Theme name: `night-city`  
Style goal: Cyberpunk 2077 inspired, not an official CD PROJEKT RED theme

## Research Notes

Omarchy themes are designed to live in:

```text
~/.config/omarchy/themes/<theme-name>/
```

They can be installed from GitHub with:

```bash
omarchy theme install https://github.com/<user>/<repo>.git
```

or:

```bash
omarchy-theme-install https://github.com/<user>/<repo>.git
```

The installer clones the repo into `~/.config/omarchy/themes`, derives the theme name from the repository name, and applies it with `omarchy-theme-set`.

The core theme switcher copies official and user theme files into `~/.config/omarchy/current/theme`, generates template outputs from `colors.toml`, writes `theme.name`, cycles the background, and restarts themed components including Waybar, terminals, Hyprland helpers, btop, Mako, browser, VS Code, Obsidian, GNOME, keyboard, and other integrations.

Official Omarchy themes currently use files such as:

```text
backgrounds/
btop.theme
colors.toml
icons.theme
keyboard.rgb
neovim.lua
preview.png
vscode.json
```

Community themes often add deeper overrides:

```text
alacritty.toml
chromium.theme
ghostty.config
hyprland.conf
hyprlock.conf
kitty.conf
mako.ini
obsidian.css
swayosd.css
walker.css
waybar.css
```

Recommended path: create a normal Omarchy theme directory, keep `colors.toml` as the palette source of truth, add component overrides only where they improve the Cyberpunk experience, and apply with `omarchy theme set "Night City"`.

## Sources Checked

- Omarchy theme installer: https://github.com/basecamp/omarchy/blob/master/bin/omarchy-theme-install
- Omarchy theme switcher: https://github.com/basecamp/omarchy/blob/master/bin/omarchy-theme-set
- Omarchy template generator: https://github.com/basecamp/omarchy/blob/master/bin/omarchy-theme-set-templates
- Official Tokyo Night theme example: https://github.com/basecamp/omarchy/tree/master/themes/tokyo-night
- Omarchy customization skill notes: https://github.com/basecamp/omarchy/blob/master/default/omarchy-skill/SKILL.md
- Community examples found through GitHub: `RiO7MAKK3R/omarchy-neovoid-theme`, `hoblin/omarchy-cobalt2-theme`, `vale-c/omarchy-arc-blueberry`

## Design Direction

Use the Cyberpunk 2077 visual language without copying game assets:

- High contrast black graphite panels
- Hazard yellow as the identity color
- Cyan as the action/focus color
- Magenta-red as danger, alert, and destructive action
- Thin angular borders, sharp corners, scanline accents
- Dense information surfaces, not soft rounded cards
- Neon focus states that stay readable during long sessions
- Original or generated wallpapers only, not extracted game art

Avoid:

- Official logos, copyrighted screenshots, or in-game UI assets
- Low-contrast yellow text on bright yellow panels
- Too much glow; use glow as a focus cue, not as wallpaper fog
- Rounded pill-heavy UI that fights the Cyberpunk aesthetic

## Palette

`colors.toml` format (matches Omarchy theme standard):

```toml
[colors]
background           = "#080a0f"
foreground           = "#e8f6ff"
cursor               = "#00f0ff"
selection_foreground = "#080a0f"
selection_background = "#fcee09"

# Normal colors (ANSI 0–7)
color0  = "#111318"   # black
color1  = "#ff003c"   # red
color2  = "#00ff9f"   # green
color3  = "#fcee09"   # yellow (primary accent)
color4  = "#00aaff"   # blue
color5  = "#ff2bd6"   # magenta
color6  = "#00f0ff"   # cyan (interactive)
color7  = "#c7d7e0"   # white

# Bright colors (ANSI 8–15)
color8  = "#2a2e38"   # bright black
color9  = "#ff4d6d"   # bright red
color10 = "#45ffc6"   # bright green
color11 = "#fff45c"   # bright yellow
color12 = "#39c5ff"   # bright blue
color13 = "#ff66e8"   # bright magenta
color14 = "#66fbff"   # bright cyan
color15 = "#ffffff"   # bright white

[extra]
accent  = "#fcee09"   # hazard yellow — primary identity color
warning = "#ff003c"   # danger/alert
error   = "#ff003c"   # destructive actions
```

Role map:

```text
Background:       #080a0f
Panel:            #111318
Panel raised:     #171b24
Primary accent:   #fcee09
Interactive:      #00f0ff
Danger:           #ff003c
Success:          #00ff9f
Muted text:        #8d9aa8
Foreground:       #e8f6ff
```

## Theme Directory Blueprint

Create this after Omarchy is installed:

```bash
mkdir -p ~/.config/omarchy/themes/night-city/backgrounds
```

Target structure:

```text
~/.config/omarchy/themes/night-city/
├── colors.toml          # required — palette source of truth
├── preview.png          # shown in the theme picker
├── icons.theme          # icon theme selection
├── keyboard.rgb         # keyboard RGB lighting
├── backgrounds/
│   ├── night-city-01.png
│   ├── night-city-02.png
│   └── night-city-03.png
├── waybar.css
├── walker.css
├── mako.ini
├── hyprland.conf
├── hyprlock.conf
├── swayosd.css
├── btop.theme
├── neovim.lua
├── vscode.json
└── README.md
```

Minimum viable theme (enough for `omarchy theme set` to succeed):

```text
colors.toml
preview.png
backgrounds/
```

Full theme:

Add `waybar.css`, `walker.css`, `mako.ini`, `hyprland.conf`, `hyprlock.conf`, `swayosd.css`, `btop.theme`, `neovim.lua`, `vscode.json`, and terminal-specific overrides if needed.

## UI/UX Specification

### Hyprland

Visual behavior:

- Active window border: yellow to cyan gradient
- Inactive border: dark graphite
- Urgent border: magenta-red
- Gaps: compact, workstation-like, around 6 to 8 px
- Rounding: 0 to 4 px, with a sharp industrial feel
- Animation: quick snap, no floaty easing
- Blur: subtle or off; readability wins

Suggested intent:

```text
general {
  gaps_in = 6
  gaps_out = 10
  border_size = 2
  col.active_border = rgba(fcee09ff) rgba(00f0ffff) 45deg
  col.inactive_border = rgba(2a2e38cc)
}

decoration {
  rounding = 2
  blur {
    enabled = true
    size = 3
    passes = 1
  }
  shadow {
    enabled = true
    color = rgba(00f0ff33)
  }
}
```

### Waybar

Layout:

- Dense top bar, transparent black background
- Workspace buttons as square chips
- Active workspace: yellow background with black text
- Urgent workspace: magenta-red
- CPU/RAM/network: cyan text
- Battery/power: yellow normal, red critical

UX:

- Use contrast, not huge text
- Keep module spacing tight
- Avoid decorative paragraphs or explanatory labels

### Walker

Launcher style:

- Dark command-palette surface
- Cyan caret/focus border
- Yellow selected result
- Monospace or condensed Nerd Font
- No heavy blur; search should feel instant

Interaction:

- Selected row should be obvious within 100 ms
- Result icons can be muted so names stay dominant
- Error/no-result state should be magenta-red but still readable

### Mako Notifications

Notification roles:

- Normal: graphite panel, cyan border
- Low priority: muted gray border
- Critical: magenta-red border and yellow title

UX:

- Short timeout for normal notifications
- Longer timeout for critical
- Keep text line length readable
- No giant notification panels

### Hyprlock

Lock screen:

- Original/generated Night City-style wallpaper
- Center-left time display
- Thin cyan input border
- Yellow verification/focus accent
- Magenta-red failure state

Avoid using official Cyberpunk logos or screenshots.

### Terminal

Terminal behavior:

- Background: near black
- Cursor: cyan
- Selection: yellow background with black text
- Prompt accent: yellow for user/host, cyan for path, magenta-red for failure

Fonts:

```bash
sudo pacman -S ttf-jetbrains-mono-nerd ttf-terminus-nerd
```

Recommended Omarchy font choice:

```bash
omarchy font set "JetBrainsMono Nerd Font"
```

### Btop

Metrics:

- CPU graph: yellow to cyan
- Memory graph: cyan
- Disk graph: green
- Network graph: magenta/cyan split
- Warnings: red

Keep graph characters high contrast against black.

### VS Code / Editors

Use a compatible marketplace theme rather than pretending the desktop theme can fully skin every editor by itself.

Suggested `vscode.json` intent:

```json
{
  "extensions": [
    "RobbOwen.synthwave-vscode",
    "enkia.tokyo-night"
  ],
  "settings": {
    "workbench.colorTheme": "SynthWave '84",
    "workbench.iconTheme": "material-icon-theme",
    "editor.fontFamily": "JetBrainsMono Nerd Font",
    "editor.cursorStyle": "line",
    "terminal.integrated.cursorStyle": "line"
  }
}
```

If SynthWave feels too purple, use Tokyo Night as the readable fallback and keep the Omarchy shell/desktop Cyberpunk.

## Implementation Steps After Boot

1. Boot `Omarchy`.
2. Log in as `arch` and change the temporary password.
3. Connect to Wi-Fi if needed.
4. Install Omarchy:

```bash
./install-omarchy.sh
```

5. After Omarchy finishes and reboots, create the theme:

```bash
mkdir -p ~/.config/omarchy/themes/night-city/backgrounds
```

6. Create `~/.config/omarchy/themes/night-city/colors.toml` using the palette above.
7. Add original/generated wallpapers into `backgrounds/`.
8. Add component overrides gradually:

```text
waybar.css
walker.css
mako.ini
hyprland.conf
hyprlock.conf
swayosd.css
btop.theme
neovim.lua
vscode.json
```

9. Apply:

```bash
omarchy theme set "Night City"
```

10. Validate:

```bash
hyprctl reload
hyprctl configerrors
omarchy restart waybar
omarchy restart terminal
omarchy restart mako
```

## GitHub Repo Plan

If publishing as an installable theme, name the repo:

```text
omarchy-night-city-theme
```

README checklist:

- Theme preview image
- Palette table
- Components included
- Install command
- Font recommendation
- Wallpaper licensing note
- Credits for inspiration only
- License

Install command:

```bash
omarchy theme install https://github.com/<user>/omarchy-night-city-theme.git
```

## Acceptance Checklist

- `omarchy theme set "Night City"` applies without errors
- Waybar text fits and remains readable
- Walker selection is obvious
- Mako critical notifications are clearly distinct
- Active/inactive Hyprland windows are unmistakable
- Terminal contrast passes casual readability in daylight and dark room
- No copyrighted Cyberpunk 2077 screenshots, logos, or extracted assets are shipped
- Theme can be reinstalled from GitHub with `omarchy theme install`

