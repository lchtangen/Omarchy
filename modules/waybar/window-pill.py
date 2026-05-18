#!/usr/bin/env python3
import os, socket, sys, json, subprocess, html, re

MAX_TITLE_LEN = 80

def hyprctl_json(command):
    try:
        return json.loads(subprocess.check_output(["hyprctl", command, "-j"], text=True))
    except Exception:
        return {}

def print_status():
    window = hyprctl_json("activewindow")
    if window and window.get("address"):
        cls = window.get("class", "Unknown") or "Unknown"
        title = window.get("title", "") or ""
        app_class = (window.get("class") or "").lower()
        if "discord" in app_class or "vesktop" in app_class:
            title = re.sub(r"^\(\d+\)\s*", "", title)
            title = re.sub(r"^Discord\s*\|\s*", "", title)
        if len(title) > MAX_TITLE_LEN:
            title = title[:MAX_TITLE_LEN - 3]
        top, bottom = cls, title
    else:
        ws = hyprctl_json("activeworkspace")
        top, bottom = f"Workspace {ws.get('id', '1')}", "\u00A0"

    top, bottom = html.escape(top), html.escape(bottom)
    text = f"<span size='small' foreground='#a6adc8' rise='-2000'>{top}</span>\n <span size='11000' weight='bold' foreground='#ffffff'>{bottom}</span>"
    print(json.dumps({"text": text, "class": "custom-window", "tooltip": f"{top}: {bottom}"}), flush=True)

print_status()
sig = os.getenv("HYPRLAND_INSTANCE_SIGNATURE")
if not sig:
    sys.exit(1)
sock = f"/tmp/hypr/{sig}/.socket2.sock"
if os.path.exists(sock):
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as c:
        c.connect(sock)
        while True:
            data = c.recv(1024).decode("utf-8", errors="ignore")
            if not data:
                break
            if "activewindow>>" in data or "workspace>>" in data:
                print_status()
