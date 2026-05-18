# Orbital — Container Orchestration

Portable development environments, containerized applications, and service orchestration
using Podman, Distrobox, and Docker. Launch isolated workspaces from your Omarchy desktop.

## Structure

```
orbital/
├── containers/          # Container definitions
│   ├── dev.yml          # Full dev environment
│   ├── arch-box         # Arch Linux toolbox
│   ├── fedora-box       # Fedora compatibility box
│   └── nix-box          # Nix package manager box
├── distrobox/           # Distrobox configurations
│   ├── omarchy-box.ini  # Omarchy-themed distrobox
│   └── export.sh        # Export apps from containers
├── registries/          # Container registry configs
│   ├── docker.conf      # Docker Hub mirror
│   └── ghcr.conf        # GitHub Container Registry
└── compose/             # Multi-service stacks
    ├── dev-stack.yml    # Dev tools stack
    └── media-stack.yml  # Media server stack
```
