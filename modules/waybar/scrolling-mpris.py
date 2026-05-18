#!/usr/bin/env python3
import subprocess, json, time

GLYPH_FONT_FAMILY = "Symbols Nerd Font Mono"
GLYPHS = {"paused": "\uF08B", "playing": "\uF144", "stopped": "\uF04D"}
DEFAULT_GLYPH = "\uF144"
TEXT_WHEN_STOPPED = "\u266B silence"
SCROLL_TEXT_LENGTH = 25
REFRESH_INTERVAL = 0.4
PLAYERCTL_PATH = "/usr/bin/playerctl"

def player_status():
    try:
        r = subprocess.run([PLAYERCTL_PATH, "status"], capture_output=True, text=True)
        return r.stdout.strip().lower() if r.returncode == 0 and r.stdout.strip() else "stopped"
    except Exception:
        return "stopped"

def current_song():
    try:
        r = subprocess.run([PLAYERCTL_PATH, "metadata", "title"], capture_output=True, text=True)
        return r.stdout.strip() if r.returncode == 0 and r.stdout.strip() else None
    except Exception:
        return None

def scroll_gen(text, length=SCROLL_TEXT_LENGTH):
    text = text.ljust(length)
    combined = text + " " + text[:length]
    for i in range(len(combined) - length):
        yield combined[i:i + length]

if __name__ == "__main__":
    gen = None
    while True:
        out = {}
        try:
            status = player_status()
            song = current_song()
            glyph = GLYPHS.get(status, DEFAULT_GLYPH)
            if song:
                if len(song) > SCROLL_TEXT_LENGTH:
                    if gen is None:
                        gen = scroll_gen(song)
                    try:
                        song_text = next(gen)
                    except StopIteration:
                        gen = scroll_gen(song)
                        song_text = next(gen)
                else:
                    song_text = song.ljust(SCROLL_TEXT_LENGTH)
                    gen = None
            else:
                song_text = TEXT_WHEN_STOPPED.ljust(SCROLL_TEXT_LENGTH)
                gen = None
            out["text"] = f"<span font_family='{GLYPH_FONT_FAMILY}'>{glyph}</span> {song_text}"
        except Exception as e:
            out["text"] = f"\uF04D Error: {e}"
        print(json.dumps(out), flush=True)
        time.sleep(REFRESH_INTERVAL)
