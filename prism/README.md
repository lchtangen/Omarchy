# Prism — Color Science & Palette Engine

Color extraction, palette generation, contrast analysis, and color space conversion.
The engine behind intelligent theming.

## Structure

```
prism/
├── palette/             # Palette generation
│   ├── extract.sh       # Extract palette from image
│   ├── generate.sh      # Generate theme from base color
│   └── harmonize.sh     # Harmonize palette colors
├── contrast/            # Accessibility tools
│   ├── wcag-check.sh    # WCAG contrast ratio checker
│   ├── simulate.sh      # Color blindness simulation
│   └── suggest.sh       # Suggests accessible alternatives
└── extraction/          # Color extraction
    ├── wallpaper.sh     # Extract from wallpaper
    ├── screenshot.sh    # Extract from screenshot
    └── dominant.sh      # Dominant color finder
```
