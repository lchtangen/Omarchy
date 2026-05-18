# Hologram Shaders

GLSL fragment shaders for Hyprland screen-space effects.
Load with `hyprctl keyword decoration:screen_shader /path/to/shader.glsl`.

## Shader Collection

| Shader | Description |
|--------|-------------|
| `cyber-grid.glsl` | Holographic grid overlay with pulsing glow |
| `scanlines.glsl` | CRT monitor scanlines with vignette |
| `aurora.glsl` | Aurora borealis ambient waves |
| `matrix.glsl` | Stylized matrix rain effect |
| `glitch-wave.glsl` | Digital distortion wave effect |
| `cyberpunk-neon.glsl` | Neon glow edges (install from Aether shaders) |
| `vaporwave.glsl` | Vaporwave pink/blue gradient (install from Aether) |
| `thermal.glsl` | Thermal vision effect (install from Aether) |
| `desaturate.glsl` | Full desaturation toggle (install from Aether) |

## Aether Shader Collection

89 additional shaders available from the Aether collection.
Symlink from `/usr/share/aether/shaders/` when installed:

```bash
# Install Aether shader pack
# Then symlink into hologram:
ln -sf /usr/share/aether/shaders/*.glsl hologram/shaders/aether/
```

## Usage

```bash
# Apply shader
hyprctl keyword decoration:screen_shader ~/Omarchy/hologram/shaders/cyber-grid.glsl

# Remove shader
hyprctl keyword decoration:screen_shader ""
```

Toggle with keybind:
```conf
bind = SUPER, F10, exec, hyprctl keyword decoration:screen_shader ~/Omarchy/hologram/shaders/cyber-grid.glsl
bind = SUPER, F11, exec, hyprctl keyword decoration:screen_shader ""
```
