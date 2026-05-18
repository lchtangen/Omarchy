#!/usr/bin/env python3
"""SVG glyph generator for Omarchy waybar logo module."""
import json, jsonschema

GLYPH_SVG = """
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18">
  <defs><linearGradient id="g" x1="0%" y1="0%" x2="100%" y2="100%">
    <stop offset="0%" stop-color="#7aa2f7"/><stop offset="100%" stop-color="#bb9af7"/>
  </linearGradient></defs>
  <circle cx="12" cy="12" r="10" fill="none" stroke="url(#g)" stroke-width="2"/>
  <path d="M8 12l3 3 5-5" fill="none" stroke="url(#g)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>"""

def generate(format="json"):
    if format == "json":
        print(json.dumps({"text": GLYPH_SVG, "class": "omarchy-logo", "tooltip": "Omarchy Menu"}))
    else:
        print(GLYPH_SVG)

if __name__ == "__main__":
    import sys
    generate(sys.argv[1] if len(sys.argv) > 1 else "json")
