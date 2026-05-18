# Matrix — Multi-Device Mesh Network

Synchronize Omarchy configurations across all your machines.
Desktop, laptop, HTPC — one config to rule them all.

## Structure

```
matrix/
├── sync/                # Configuration synchronization
│   ├── dotfiles.sh      # Dotfile syncing engine
│   ├── themes.sh        # Theme distribution
│   └── packages.sh      # Package sync across hosts
├── nodes/               # Node definitions
│   ├── desktop.yml      # Workstation config
│   ├── laptop.yml       # Mobile workstation
│   ├── htpc.yml         # Home theater PC
│   └── server.yml       # Headless server
├── mesh/                # LAN mesh networking
│   ├── zerotier.conf    # ZeroTier network config
│   ├── tailscale.conf   # Tailscale overlay config
│   └── syncthing/       # Syncthing device configs
└── vault/               # Shared secrets
    ├── age-recipients   # Age encryption recipients
    └── ssh-config       # SSH multiplexing config
```
