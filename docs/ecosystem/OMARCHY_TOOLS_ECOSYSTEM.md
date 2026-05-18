# Omarchy Tools and Ecosystem

Complete reference for Omarchy's default application stack, CLI tools, community integrations, and ecosystem resources.

---

## Default Application Stack

These applications are installed and configured by Omarchy out of the box:

### Core Developer Tools

| Tool | Purpose |
|------|---------|
| Neovim | Primary text editor |
| Alacritty | GPU-accelerated terminal emulator |
| Zsh | Default shell with git integration |
| Chromium | Web browser |
| Lazygit | TUI git client |
| fzf | Fuzzy finder (shell integration) |
| zoxide | Smarter `cd` with frecency tracking |
| ripgrep | Fast `grep` replacement |
| btop | TUI system monitor |

### Productivity

| Tool | Purpose |
|------|---------|
| Obsidian | Markdown-based knowledge base / notes |
| Typora | Focused markdown editor |
| LibreOffice | Office suite (documents, spreadsheets) |
| Zoom | Video conferencing |
| HEY | Email and calendar (37signals) |
| Basecamp | Project management (37signals) |

### Communication and AI

| Tool | Purpose |
|------|---------|
| ChatGPT | AI assistant (web app) |
| WhatsApp | Messaging (web app) |
| Claude | AI assistant (web app) |

### Gaming

| Tool | Purpose |
|------|---------|
| Steam | PC gaming platform |
| RetroArch | Retro console emulation |
| Lutris | Linux game manager |
| Xbox Cloud Gaming | Streaming (browser) |
| NVIDIA GeForce NOW | Streaming (browser) |
| Minecraft | Available via AUR |

---

## Omarchy CLI Reference

The `omarchy` command manages system-level operations:

```bash
omarchy update                           # update system packages and Omarchy
omarchy theme install <github-url>       # install a community theme
omarchy theme set "<theme-name>"         # apply an installed theme
omarchy theme remove "<theme-name>"      # remove a theme
omarchy-theme-install <github-url>       # alias for theme install
```

Access everything via the Omarchy Menu: `Super + Alt + Space`

---

## Official Hyprland Desktop Components

| Component | Binary | Purpose |
|-----------|--------|---------|
| Hyprland | `Hyprland` | Window manager / Wayland compositor |
| Waybar | `waybar` | Top status bar |
| Walker | `walker` | Application launcher / command palette |
| Mako | `mako` | Notification daemon |
| Hyprlock | `hyprlock` | Lock screen |
| Hyprpaper | `hyprpaper` | Wallpaper daemon |
| SwayOSD | `swayosd-server` | On-screen display for volume/brightness |

---

## Community Tools

Install community tools into `~/Code/omarchy-tools/` to keep them organized.

### Omarchist — GUI Theme Designer

Visual tool for creating and previewing Omarchy themes without editing TOML manually.

```bash
git clone https://github.com/tahayvr/omarchist.git ~/Code/omarchy-tools/omarchist
cd ~/Code/omarchy-tools/omarchist
less README.md
```

### Aether — Theme Tooling

Advanced theme manipulation, palette generation, and theme export utilities.

```bash
git clone https://github.com/bjarneo/aether.git ~/Code/omarchy-tools/aether
cd ~/Code/omarchy-tools/aether
less README.md
```

### Omarchy Theme Hook — Extend Theme Events

Run custom scripts when a theme changes. Useful for syncing themes to apps not natively supported by Omarchy.

```bash
git clone https://github.com/imbypass/omarchy-theme-hook.git ~/Code/omarchy-tools/omarchy-theme-hook
cd ~/Code/omarchy-tools/omarchy-theme-hook
less README.md
```

### Hyprmon — Monitor Configuration GUI

GUI tool for configuring multi-monitor layouts, refresh rates, and scaling. Writes directly to `~/.config/hypr/monitors.conf`.

```bash
git clone https://github.com/erans/hyprmon.git ~/Code/omarchy-tools/hyprmon
cd ~/Code/omarchy-tools/hyprmon
less README.md
```

Alternative: configure monitors manually — see [OMARCHY_HYPRLAND_CONFIG.md](OMARCHY_HYPRLAND_CONFIG.md).

### Omarchy Cleaner / A La Carchy — Debloat Tools

Remove pre-installed applications you don't need. Pick one — do not run both.

```bash
# Omarchy Cleaner
git clone https://github.com/maxart/omarchy-cleaner.git ~/Code/omarchy-tools/omarchy-cleaner
cd ~/Code/omarchy-tools/omarchy-cleaner
less README.md

# A La Carchy (TUI debloater, selective removal)
git clone https://github.com/DanielCoffey1/a-la-carchy.git ~/Code/omarchy-tools/a-la-carchy
cd ~/Code/omarchy-tools/a-la-carchy
less README.md
```

### Shell Integrations

**Omarchy Tmux** — tmux config styled to match Omarchy themes:
```bash
git clone https://github.com/joaofelipegalvao/omarchy-tmux.git ~/Code/omarchy-tools/omarchy-tmux
cd ~/Code/omarchy-tools/omarchy-tmux
less README.md
```

Requires tmux: `sudo pacman -S tmux`

**Omarchy Zsh** — enhanced Zsh config with Omarchy-specific aliases and prompt:
```bash
git clone https://github.com/omacom-io/omarchy-zsh.git ~/Code/omarchy-tools/omarchy-zsh
cd ~/Code/omarchy-tools/omarchy-zsh
less README.md
```

**Omarchy Fish** — Fish shell integration:
```bash
git clone https://github.com/omacom-io/omarchy-fish.git ~/Code/omarchy-tools/omarchy-fish
cd ~/Code/omarchy-tools/omarchy-fish
less README.md
```

---

## Speech-to-Text Options

| Tool | Description | Repository |
|------|-------------|------------|
| Hyprwhspr | Whisper-based private dictation for Hyprland | github.com/goodroot/hyprwhspr |
| Wayscriber | Wayland drawing, annotation, zoom, screenshot overlay | github.com/devmobasa/wayscriber |
| OSTT | Open-source voice-to-text for the terminal | github.com/kristoferlund/ostt |
| Shout | Real-time dictation with hotkey activation | github.com/robzolkos/shout |

Install one first and test it before adding others:

```bash
# Hyprwhspr (recommended starting point)
git clone https://github.com/goodroot/hyprwhspr.git ~/Code/omarchy-tools/hyprwhspr
cd ~/Code/omarchy-tools/hyprwhspr
less README.md
```

Check dependencies before running any install script — speech-to-text tools often require model downloads, GPU/CPU selection, and microphone permissions.

---

## Alternate Terminals

Alacritty is the default but others integrate well:

**Ghostty** — modern terminal with good Wayland support:
```bash
yay -S ghostty
```

Theme support: themes include a `ghostty` file in addition to `alacritty.toml`.

**Kitty** — feature-rich terminal with graphics protocol support:
```bash
sudo pacman -S kitty
```

---

## AI Coding Assistants

Several AI coding tools work well in Omarchy's Neovim-first environment:

**GitHub Copilot** (Neovim plugin):
```vim
Plug 'github/copilot.vim'
```

**Avante.nvim** — Claude/GPT in Neovim sidebar:
```vim
-- add to your Neovim plugin manager config
```

**Aider** — AI pair programming in the terminal:
```bash
pip install aider-chat
```

**Claude Code** — AI coding CLI:
```bash
npm install -g @anthropic-ai/claude-code
```

---

## Safe Install Order

When setting up a fresh Omarchy system with community tools, follow this order to avoid conflicts:

1. Run `omarchy update` (baseline system update)
2. Install shell integrations (Zsh, Fish, Tmux) — they modify shell config
3. Install Hyprmon if using multi-monitor setup — writes to Hypr config
4. Install Omarchist / Aether — theme tooling, standalone
5. Install Theme Hook — extends theme system
6. Install speech-to-text tools — system-level audio integration
7. Install debloat tools (Cleaner, A La Carchy) last — removes packages
8. Install additional themes last — no system changes

---

## Recovery Commands

**Broken theme / display corruption:**
```bash
omarchy theme set "Tokyo Night"
```

**Waybar not showing or crashed:**
```bash
om system guard
```

If the whole session feels unstable or Waybar keeps duplicating:

```bash
om system stabilize
```

**Hyprland compositor crash (terminal still accessible):**
```bash
Hyprland
```

**Full session recovery from TTY (Ctrl+Alt+F2):**
```bash
# Kill any remaining Hyprland processes
pkill -9 Hyprland
# Restart cleanly
Hyprland
```

**Package database corrupted:**
```bash
sudo pacman -Syy
sudo pacman -Suu
```

**Rollback to a btrfs snapshot:**
```bash
sudo snapper list
sudo snapper undochange <number>..0
```

---

## Community Discovery

**Curated lists:**
- https://github.com/aorumbayev/awesome-omarchy — tools, themes, workflows
- https://github.com/Wheel-Smith/awesome-omarchy — theme-focused
- https://github.com/minimallyexceptional/awesome-omarchy — tools and tips
- https://awesome-omarchy.com/

**Theme discovery:**
- https://omarchythemes.com/
- https://omarchy.deepakness.com/themes (65+ community themes, 110+ workstation setups)
- https://github.com/topics/omarchy

**Community themes directory:**
```bash
ls ~/.config/omarchy/themes/
```

---

## Related Projects (Not for Arch)

These ports are for reference only — do not install on Arch Linux:

| Project | Target |
|---------|--------|
| NixOS Omarchy port | NixOS |
| macOS Omarchy port | macOS |
| CachyOS Omarchy port | CachyOS (Arch-based, but separate config) |

---

## Official Resources

| Resource | URL |
|----------|-----|
| Website | https://omarchy.org/ |
| Manual | https://learn.omacom.io/2/the-omarchy-manual |
| GitHub | https://github.com/basecamp/omarchy |
| ISO Builder | https://github.com/omacom-io/omarchy-iso |
| Package Repo | https://github.com/omacom-io/omarchy-pkgs |
| Discord | Via https://omarchy.org/ |

---

## See Also

- [OMARCHY_SETUP_FIRST_STEPS.md](OMARCHY_SETUP_FIRST_STEPS.md) — development environment setup
- [OMARCHY_UI_DESIGN_THEMING.md](OMARCHY_UI_DESIGN_THEMING.md) — theming and visual customization
- [OMARCHY_REPOS_AFTER_INSTALL.md](OMARCHY_REPOS_AFTER_INSTALL.md) — full curated list with GitHub links
