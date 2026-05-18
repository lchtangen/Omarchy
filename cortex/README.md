# Cortex — Adaptive Intelligence Engine

Self-adapting system configuration that responds to hardware, environment, and usage patterns.
Smart detection, predictive tuning, and dynamic theming.

## Structure

```
cortex/
├── detection/           # Hardware/environment detection
│   ├── hardware.sh      # GPU, CPU, display detection
│   ├── environment.sh   # Laptop/desktop/VM detection
│   └── peripherals.sh   # Input device detection
├── adaptive/            # Runtime configuration adaptation
│   ├── display.fish     # Auto-resolution scaling
│   ├── power.fish       # Power mode switching
│   └── audio.fish       # Audio profile switching
├── theming-engine/      # Dynamic theme adaptation
│   ├── ambient.sh       # Time-of-day theme switching
│   ├── wallpaper-sync   # Wallpaper → theme color extraction
│   └── contrast.sh      # Auto contrast adjustment
└── predictive/          # Usage-based optimization
    ├── preload.sh       # App preloading prediction
    └── cache.conf       # Smart cache management
```
