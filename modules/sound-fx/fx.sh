#!/usr/bin/env bash
set -euo pipefail
# Sound FX helper — plays audio files for keybinding feedback
# Usage: fx.sh <sound-name> [--bg]

SOUNDS_DIR="${SOUNDS_DIR:-$HOME/.config/omarchy/sounds}"
SOUND_NAME="${1:-}"
BG="${2:-}"

[[ -z "$SOUND_NAME" ]] && { echo "Usage: fx.sh <sound-name> [--bg]"; exit 1; }

# Find sound file
for ext in mp3 wav ogg flac; do
    f="$SOUNDS_DIR/$SOUND_NAME.$ext"
    [[ -f "$f" ]] && break
    f=""
done

[[ -z "$f" ]] && { echo "Sound not found: $SOUND_NAME"; exit 1; }

play() {
    if command -v mpv &>/dev/null; then
        mpv --no-video --volume=100 "$f"
    elif command -v paplay &>/dev/null; then
        paplay "$f"
    elif command -v aplay &>/dev/null; then
        aplay "$f"
    fi
}

if [[ "$BG" == "--bg" ]]; then
    play &>/dev/null &
else
    play
fi
