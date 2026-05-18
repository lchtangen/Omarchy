# Phantom — Sandbox & Isolation Engine

Run untrusted applications, test configurations, and isolate workloads
with Firejail, Bubblewrap, and custom sandbox profiles for Omarchy.

## Structure

```
phantom/
├── firejail/            # Firejail security profiles
│   ├── browser.profile  # Hardened browser sandbox
│   ├── media.profile    # Media player sandbox
│   └── dev.profile      # Development tools sandbox
├── bwrap/               # Bubblewrap configurations
│   ├── minimal.sh       # Minimal rootfs sandbox
│   └── build.sh         # Build isolation sandbox
└── sandboxes/           # Pre-configured sandbox environments
    ├── test-theme/      # Theme testing sandbox
    ├── browse/          # Isolated browsing
    └── untrusted/       # Run untrusted binaries
```

## Usage

```bash
# Run a browser with maximum isolation
firejail --profile=phantom/firejail/browser.profile chromium

# Test a theme in a sandbox
phantom/sandboxes/test-theme/run.sh

# Isolate a build process
bwrap --ro-bind /usr /usr --ro-bind /nix /nix --proc /proc --dev /dev bash
```
