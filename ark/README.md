# Ark — Archival & Disaster Recovery

Backup strategies, snapshot management, system restore, and disaster recovery
for the Omarchy desktop. Because every system needs an ark.

## Structure

```
ark/
├── snapshots/           # Snapshot management
│   ├── btrfs/           # Btrfs snapshot scripts
│   │   ├── create.sh    # Auto snapshot on boot
│   │   ├── list.sh      # List available snapshots
│   │   └── rollback.sh  # Rollback to snapshot
│   └── timeshift/       # Timeshift configuration
│       └── timeshift.json
├── restore/             # Restore procedures
│   ├── full-restore.sh  # Bare-metal restoration
│   ├── config-restore.sh # Dotfiles restoration
│   └── package-restore.sh # Package reinstallation
├── strategies/          # Backup strategies
│   ├── 3-2-1.md         # 3-2-1 backup rule
│   ├── git-backup.md    # Git-based config backup
│   └── cloud.md         # Cloud sync strategy
└── disaster/            # Disaster recovery
    ├── recovery-media   # Recovery USB instructions
    └── offline.sh       # Offline recovery mode
```
