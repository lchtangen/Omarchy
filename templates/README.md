# Templates

Skeletons and starters for creating new Omarchy content.

## Theme Template

```
templates/theme/
├── colors.toml          # 16-color palette (required)
├── waybar.css           # Top bar styling
├── walker.css           # App launcher styling
├── hyprland.conf        # WM color overrides
├── hyprlock.conf        # Lock screen styling
├── mako.ini             # Notifications
├── neovim.lua           # Editor colorscheme
├── alacritty.toml       # Terminal colors
└── backgrounds/         # Wallpaper images
```

### Usage

```bash
cp -r templates/theme ~/.config/omarchy/themes/my-new-theme
# Edit colors.toml with your palette
# Run: omarchy theme set "my-new-theme"
```

## Config Templates

```
templates/config/
├── hyprland/            # Window manager snippets
├── waybar/              # Status bar templates
├── alacritty/           # Terminal configs
└── neovim/              # Editor configs
```
