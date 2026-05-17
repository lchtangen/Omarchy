# Omarchy Repos To Install After First Boot

Use this after:

```bash
./install-omarchy.sh
```

and after the Omarchy installer finishes and you reboot into the full desktop.

## First Steps

Update the system:

```bash
omarchy update
```

Install basic tools:

```bash
omarchy pkg install git curl base-devel
```

Create a workspace:

```bash
mkdir -p ~/Code/omarchy-tools ~/Code/omarchy-themes
```

## High-Value Omarchy Tools

### Omarchist

GUI app for Omarchy and theme design.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/tahayvr/omarchist.git
cd omarchist
less README.md
```

Follow the repo README for build/install commands. It is a GUI app, so check its prerequisites before running install scripts.

### Aether

Theme tooling with native Omarchy support.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/bjarneo/aether.git
cd aether
less README.md
```

Use this if you want to generate or manage Omarchy themes rather than hand-edit every file.

### Omarchy Theme Hook

Extends Omarchy theme changes to more apps.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/imbypass/omarchy-theme-hook.git
cd omarchy-theme-hook
less README.md
```

Install this after your main Omarchy desktop works. It touches theme automation, so read the README before applying.

### Hyprmon

TUI monitor configuration tool for Hyprland.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/erans/hyprmon.git
cd hyprmon
less README.md
```

Useful after you boot the real desktop, especially for laptop plus external monitor setups.

### Omarchy Cleaner

Removes preinstalled apps and webapps.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/maxart/omarchy-cleaner.git
cd omarchy-cleaner
less README.md
```

Run only after you know what you want removed. This is a cleanup/debloat tool, not a first-boot requirement.

### A La Carchy

TUI debloater and optimizer for Omarchy.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/DanielCoffey1/a-la-carchy.git
cd a-la-carchy
less README.md
```

Do not run both this and `omarchy-cleaner` blindly. Pick one debloat path after reading both.

### Omarchy Tmux

Tmux theme integration that syncs with Omarchy.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/joaofelipegalvao/omarchy-tmux.git
cd omarchy-tmux
less README.md
```

Install after tmux is installed:

```bash
omarchy pkg install tmux
```

### Omarchy Zsh

Official/community Omarchy zsh setup.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/omacom-io/omarchy-zsh.git
cd omarchy-zsh
less README.md
```

Only use this if you want zsh instead of the default shell setup.

### Omarchy Fish

Fish shell setup for Omarchy.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/omacom-io/omarchy-fish.git
cd omarchy-fish
less README.md
```

Only use this if you want fish shell. Do not install every shell customization at once.

## Voice / Annotation Tools

These are not Omarchy-only, but they ranked highly in Omarchy-related GitHub searches and fit the Hyprland/Wayland workflow.

### Hyprwhspr

Private system-wide speech-to-text.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/goodroot/hyprwhspr.git
cd hyprwhspr
less README.md
```

Check dependencies carefully. Speech-to-text tools may need model downloads, GPU/CPU choices, microphone permissions, and hotkey setup.

### Wayscriber

Wayland drawing, annotation, zoom, and screenshot overlay.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/devmobasa/wayscriber.git
cd wayscriber
less README.md
```

Good for presentations, screen notes, and visual debugging.

### OSTT

Open source voice-to-text for the terminal.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/kristoferlund/ostt.git
cd ostt
less README.md
```

Compare with `hyprwhspr` before installing both.

### Shout

Speech-to-text for Omarchy.

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/robzolkos/shout.git
cd shout
less README.md
```

Install one speech-to-text workflow first, test it, then decide if you need alternatives.

## Waybar And UI Theme Repos

### HANCORE Waybar Themes

Large collection of Waybar themes.

```bash
cd ~/Code/omarchy-themes
git clone https://github.com/HANCORE-linux/waybar-themes.git
cd waybar-themes
less README.md
```

Back up current Waybar config before applying:

```bash
cp -r ~/.config/waybar ~/.config/waybar.backup.$(date +%s)
```

Restart Waybar after changes:

```bash
omarchy restart waybar
```

### Minimal Waybar Themes

Minimal Waybar themes for Omarchy.

```bash
cd ~/Code/omarchy-themes
git clone https://github.com/atif-1402/minimal-waybar-themes.git
cd minimal-waybar-themes
less README.md
```

Also back up `~/.config/waybar` before applying.

### Adsovetzky Omarchy Waybar

Custom Omarchy Waybar setup.

```bash
cd ~/Code/omarchy-themes
git clone https://github.com/adsovetzky/Adsovetzky-Omarchy-s-Waybar.git
cd Adsovetzky-Omarchy-s-Waybar
less README.md
```

Use one Waybar setup at a time.

## Theme Repos

Omarchy themes are usually installed with:

```bash
omarchy theme install <github-url>
```

Then switch with:

```bash
omarchy theme set "<Theme Name>"
```

Recommended install folder:

```bash
mkdir -p ~/.config/omarchy/themes
```

### Lumon

```bash
omarchy theme install https://github.com/OldJobobo/omarchy-lumon-theme.git
```

### Miasma

```bash
omarchy theme install https://github.com/OldJobobo/omarchy-miasma-theme.git
```

### Aetheria

```bash
omarchy theme install https://github.com/JJDizz1L/aetheria.git
```

### Copper Night

```bash
omarchy theme install https://github.com/hembramnishant50-glitch/omarchy-coppernight-theme.git
```

### Akane

```bash
omarchy theme install https://github.com/Grenish/omarchy-akane-theme.git
```

### Ash

```bash
omarchy theme install https://github.com/bjarneo/omarchy-ash-theme.git
```

### Midnight

```bash
omarchy theme install https://github.com/JaxonWright/omarchy-midnight-theme.git
```

### IBM / ThinkPad

```bash
omarchy theme install https://github.com/DimaZbr/omarchy-ibm-theme.git
```

### Solitude

```bash
omarchy theme install https://github.com/HANCORE-linux/omarchy-solitude-theme.git
```

### BlackTurq

```bash
omarchy theme install https://github.com/HANCORE-linux/omarchy-blackturq-theme.git
```

### Futurism

```bash
omarchy theme install https://github.com/bjarneo/omarchy-futurism-theme.git
```

### BlackGold

```bash
omarchy theme install https://github.com/HANCORE-linux/omarchy-blackgold-theme.git
```

### Batou

```bash
omarchy theme install https://github.com/HANCORE-linux/omarchy-batou-theme.git
```

### Retro Fallout

```bash
omarchy theme install https://github.com/zdravkodanailov7/omarchy-retro-fallout-theme.git
```

### RetroPC

```bash
omarchy theme install https://github.com/rondilley/omarchy-retropc-theme.git
```

### Void

```bash
omarchy theme install https://github.com/vyrx-dev/omarchy-void-theme.git
```

## Curated Lists To Browse

### Awesome Omarchy

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/aorumbayev/awesome-omarchy.git
cd awesome-omarchy
less README.md
```

### Awesome Omarchy TUI

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/aorumbayev/awesome-omarchy-tui.git
cd awesome-omarchy-tui
less README.md
```

### Wheel-Smith Awesome Omarchy

```bash
cd ~/Code/omarchy-tools
git clone https://github.com/Wheel-Smith/awesome-omarchy.git
cd awesome-omarchy
less README.md
```

## System Ports / Alternate Installs

These are useful to study, but usually should not be installed on this Arch Omarchy partition.

### Omarchy Nix

```bash
git clone https://github.com/henrysipp/omarchy-nix.git
```

Use only if building a NixOS-based Omarchy-like system.

### Omarchy Mac

```bash
git clone https://github.com/malik-na/omarchy-mac.git
```

Use only for Apple Silicon / Asahi-style workflows.

### Omarchy On CachyOS

```bash
git clone https://github.com/mroboff/omarchy-on-cachyos.git
```

Use only for CachyOS.

### Omarchy CachyOS

```bash
git clone https://github.com/lentra0/omarchy-cachyos.git
```

Use only for CachyOS/Hyprland experimentation.

### Omadora

```bash
git clone https://github.com/elpritchos/omadora.git
```

Fedora Hyprland setup based on Omarchy. Do not apply directly to Arch Omarchy.

## Archived / Be Careful

These appeared in search results but are archived. Read only unless you know why you need them.

```bash
https://github.com/atif-1402/anomshell
https://github.com/28allday/W.O.P.R
```

## Safe Install Order

1. Install Omarchy and reboot.
2. Run `omarchy update`.
3. Install one visual theme using `omarchy theme install`.
4. Install one Waybar configuration only if the theme does not already include a Waybar style.
5. Install `hyprmon` if monitor setup is annoying.
6. Install `omarchist` or `aether` if you want theme creation tools.
7. Install one speech-to-text tool, not all of them.
8. Only then consider debloat tools like `omarchy-cleaner` or `a-la-carchy`.

## Recovery Commands

If a theme breaks visuals:

```bash
omarchy theme list
omarchy theme set "Tokyo Night"
```

If Waybar breaks:

```bash
omarchy refresh waybar
omarchy restart waybar
```

If Hyprland config breaks:

```bash
hyprctl configerrors
omarchy refresh hyprland
```

If terminal theme breaks:

```bash
omarchy restart terminal
```

