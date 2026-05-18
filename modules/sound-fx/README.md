# Sound FX — Audio feedback for keybindings and events

Per-action sound effects for Hyprland, inspired by omarchy-config's SAO-style
sounds. Plays audio on keybinding actions, workspace switches, window events.

## Structure

```
sound-fx/
├── sounds/          # Audio files (mp3/wav)
├── bindings.conf    # Hyprland bindings with audio commands
├── events.conf      # Event-triggered audio
└── fx.sh            # Helper script to play sounds
```

## Usage

Source `bindings.conf` from your `hyprland.conf`:

```conf
source = ~/Omarchy/modules/sound-fx/bindings.conf
```

Or add audio to individual keybindings:

```conf
bind = SUPER, Return, exec, mpv --no-video ~/.config/omarchy/sounds/terminal.mp3 && alacritty
bind = SUPER, d, exec, mpv --no-video ~/.config/omarchy/sounds/menu.wav && fuzzel
```
