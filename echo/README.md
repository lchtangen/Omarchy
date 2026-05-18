# Echo — Voice Command Interface

Voice-controlled Omarchy desktop. Speak commands, trigger workflows,
and control your system hands-free using Whisper + custom hotword detection.

## Structure

```
echo/
├── voice/               # Speech recognition
│   ├── whisper.conf     # Whisper.cpp configuration
│   ├── hotwords/        # Custom wake word models
│   └── languages/       # Multi-language support
├── audio/               # Audio routing
│   ├── pipewire.conf    # PipeWire voice routing
│   ├── noisegate.conf   # Noise suppression
│   └── equalizer.conf   # Voice EQ presets
└── commands/            # Voice command definitions
    ├── desktop.yml      # "open terminal", "next workspace", etc.
    ├── media.yml        # "play", "pause", "volume up"
    ├── theme.yml        # "switch to Tokyo Night"
    └── custom.yml       # User-defined commands
```

## Signal Protocol (IPC)

Waybar IPC signals via `pkill -RTMIN+N`:

| Signal | Number | Purpose | Source |
|--------|--------|---------|--------|
| Screen Recording | 8 | Toggle record indicator | HANCORE/OSTT |
| Update Check | 7 | Update available badge | ArchRiot |
| Idle Inhibit | 9 | Toggle idle indicator | omarchy-config |
| Notifications | 10 | Toggle silence indicator | omarchy-config |
| Battery | 11 | Critical battery alert | ArchRiot |
| Pomodoro | 12 | Timer tick | ArchRiot |

## Service Management

```bash
./service.sh start    # Start voice recognition daemon
./service.sh stop     # Stop voice daemon
./service.sh status   # Check if running
```

## Toggle Pattern (PID file)

```bash
./pid-toggle.sh <name> <command...>
```
Start/stops a process by PID file — used for screen recording, idle inhibit, etc.

## OSTT Integration

`ostt-config.yml` defines post-processing actions:
- **type** — wtype transcribed text at cursor
- **clipboard** — wl-copy to clipboard
- **command** — match against `commands/process.sh`
- **notify** — send as notification

## Voice Commands

```yaml
# Example: desktop.yml
commands:
  - phrase: "open terminal"
    action: "alacritty"
  - phrase: "next workspace"
    action: "hyprctl dispatch workspace +1"
  - phrase: "lock screen"
    action: "hyprlock"
  - phrase: "screenshot"
    action: "hyprshot -m region"
  - phrase: "switch to {theme}"
    action: "omarchy theme set {theme}"
```
