# Omarchy NVMe Deployment Plan

## Hardware Overview

| Device | Size | FS | Label | Mount | Status |
|--------|------|----|-------|-------|--------|
| sda2 | 59.3G | ext4 | — | / | Running dev system |
| nvme0n1p1 | 200M | vfat | — | /boot | Shared EFI |
| nvme0n1p2 | 139.7G | ext4 | — | /data | repos/ + dist/ |
| nvme0n1p3 | 46.4G | btrfs | omarchy | — | **Fresh Arch target** |
| nvme0n1p4 | 52.2G | ext4 | data | — | **Empty — to be merged** |

## Phase 1: Resize nvme0n1p3 (NVMe Arch partition)

nvme0n1p4 is empty and immediately follows p3. Delete p4, extend p3.

**Run from the SSD system (sda2) while NVMe partitions are unmounted.**

```bash
# 1. Confirm p4 is unmounted and empty
sudo umount /dev/nvme0n1p4 2>/dev/null
sudo parted /dev/nvme0n1 print

# 2. Delete p4 and extend p3 to fill the disk
sudo parted /dev/nvme0n1 ---pretend-input-tty <<EOF
rm 4
resizepart 3 100%
Yes
EOF

# 3. Grow the btrfs filesystem to fill the new partition size
sudo mount -o subvol=@ /dev/nvme0n1p3 /mnt/omarchy-nvme
sudo btrfs filesystem resize max /mnt/omarchy-nvme
sudo umount /mnt/omarchy-nvme

# 4. Verify
sudo parted /dev/nvme0n1 print
```

Result: nvme0n1p3 grows from 46.4G → ~98.6G.

## Phase 2: Configure Boot

The fresh Arch on nvme0n1p3 needs a bootloader entry. The EFI partition (nvme0n1p1) is already mounted at /boot on the fresh Arch (see fstab). Add a systemd-boot or GRUB entry.

```bash
# Mount the Arch system for chroot
sudo mount -o subvol=@ /dev/nvme0n1p3 /mnt/omarchy-nvme
sudo mount -o subvol=@home /dev/nvme0n1p3 /mnt/omarchy-nvme/home
sudo mount -o subvol=@log /dev/nvme0n1p3 /mnt/omarchy-nvme/var/log
sudo mount -o subvol=@pkg /dev/nvme0n1p3 /mnt/omarchy-nvme/var/cache/pacman/pkg
sudo mount /dev/nvme0n1p1 /mnt/omarchy-nvme/boot

# Bind mounts for chroot
sudo mount --bind /dev /mnt/omarchy-nvme/dev
sudo mount --bind /proc /mnt/omarchy-nvme/proc
sudo mount --bind /sys /mnt/omarchy-nvme/sys
sudo mount --bind /run /mnt/omarchy-nvme/run

# Chroot in
sudo chroot /mnt/omarchy-nvme

# Inside chroot — check bootloader
bootctl status 2>/dev/null || grub-install --version
```

## Phase 3: Install Omarchy

The basecamp/omarchy installer is cloned at `repos/curated/omarchy/`.

**Boot into the fresh Arch on nvme0n1p3, then:**

```bash
# Option A: Official one-liner (from fresh Arch, logged in as non-root user)
bash <(curl -fsSL https://omarchy.org/install)

# Option B: From our local clone (no network needed for installer)
bash /path/to/repos/curated/omarchy/install
```

The installer:
1. Installs all packages via pacman/yay
2. Deploys configs to ~/.config
3. Sets up Hyprland, Waybar, Walker, etc.

## Phase 4: Deploy Themes & Tools from dist/

After Omarchy is installed, deploy from our extracted dist/:

```bash
DIST=/data/Omarchy/dist

# Install a theme
cp $DIST/themes/omarchy-catppuccin-mocha-theme/* ~/.config/omarchy/theme/

# Or use the awesome-omarchy-tui to browse and pick
awesome-omarchy-tui

# Build and install a tool (example: Pacsea - Rust TUI)
cd $DIST/tools/Pacsea
cargo build --release
sudo cp target/release/pacsea /usr/local/bin/

# Build a Go tool (example: omarchy-migrate)
cd $DIST/tools/omarchy-migrate
go build -o omarchy-migrate .
sudo cp omarchy-migrate /usr/local/bin/

# Run an install script
bash $DIST/install/omarchy-ai__install.sh
```

## Phase 5: awesome-omarchy-tui — Browse All Repos

```bash
# Launch the TUI (installed via cargo or yay)
awesome-omarchy-tui

# Controls:
# j/k or arrows — navigate
# / — search
# Enter — open in browser
# q — quit
```

Use this to pick which themes/tools to keep and which to skip.

## Build Matrix — Tools by Language

| Tool | Language | Build Command |
|------|----------|---------------|
| Pacsea | Rust | `cargo build --release` |
| hyprmarker | Rust | `cargo build --release` |
| hypruler | Rust | `cargo build --release` |
| omarchy-migrate | Go | `go build -o omarchy-migrate .` |
| omarchy-ai | Python | `pip install -r requirements.txt` |
| flutter_omarchy | Flutter/Dart | `flutter build linux` |
| omarchist | Rust/Tauri | `cargo tauri build` |
| aether | (check repo) | see README |
| tema | (check repo) | see README |

## Install Scripts Available

All install.sh scripts are in `dist/install/`:

```bash
ls /data/Omarchy/dist/install/
# Run any of them:
bash /data/Omarchy/dist/install/omarchy-ai__install.sh
```

## Space Planning (nvme0n1p3 after resize)

| Item | Estimated Size |
|------|---------------|
| Fresh Arch base | ~2.5G |
| Omarchy install (packages) | ~8-12G |
| Themes deployed | ~500MB |
| Tools built | ~2G |
| Home/data | ~5G |
| **Total** | **~20G of ~98G** |

Plenty of headroom.

## Order of Execution

1. `[ ]` Phase 1: Resize nvme0n1p3 (delete p4, extend p3, btrfs resize)
2. `[ ]` Phase 2: Configure bootloader entry for nvme0n1p3
3. `[ ]` Phase 3: Boot into fresh Arch, run Omarchy installer
4. `[ ]` Phase 4: Post-install — deploy themes, build tools
5. `[ ]` Phase 5: Use awesome-omarchy-tui to curate repo selection
6. `[ ]` Phase 6: Test all themes via theme switcher
