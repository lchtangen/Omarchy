# Forge — Build & Compilation System

Custom PKGBUILDs, kernel builds, theme packaging, and toolchain optimization
for the Omarchy ecosystem. Build from source, optimize for your hardware.

## Structure

```
forge/
├── pkgbuilds/           # Custom PKGBUILD templates
│   ├── omarchy-themes/  # Theme collection package
│   ├── omarchy-tools/   # Tool collection package
│   └── PKGBUILD.tpl     # PKGBUILD template
├── kernel/              # Custom kernel builds
│   ├── linux-omarchy/   # Omarchy-optimized kernel
│   │   ├── config       # Kernel .config
│   │   └── PKGBUILD     # Kernel PKGBUILD
│   └── patches/         # Kernel patches
└── toolchain/           # Compiler optimization
    ├── makepkg.conf     # Optimized makepkg flags
    └── gcc.conf         # GCC optimization flags
```
