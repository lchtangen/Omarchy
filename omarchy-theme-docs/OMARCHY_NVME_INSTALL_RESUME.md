# Omarchy NVMe Install — Resume Guide

This document covers what to do after booting into the Omarchy Arch partition on the NVMe drive (nvme0n1p3) to complete the Omarchy installation.

---

## Current State (as of 2026-05-17)

### Partition Layout

| Device | Size | FS | Label | Status |
|--------|------|----|-------|--------|
| sda1 | 512MB | vfat | ARCH-EFI | USB EFI — GRUB bootloader |
| sda2 | 59.3GB | ext4 | ARCH-USB | Running Arch USB (95% full) |
| nvme0n1p1 | 200MB | vfat | — | Shared NVMe EFI — Omarchy GRUB + Ubuntu shim |
| nvme0n1p2 | 139.7GB | ext4 | — | /data — kernel builds, dev data |
| nvme0n1p3 | 46.4GB | btrfs | omarchy | **Boot target** — Arch base, kernel ready |
| nvme0n1p4 | 52.2GB | ext4 | data | Reserved — CachyOS future install |

### What's Already Done on nvme0n1p3

- Full Arch Linux base installed (1,377 binaries)
- Kernel: `vmlinuz-linux` + `initramfs-linux.img` + `intel-ucode.img`
- Omarchy GRUB at `/EFI/Omarchy/grubx64.efi` — boots nvme0n1p3 with `rootflags=subvol=@`
- `arch` user (UID 1000) exists with passwordless sudo
- Omarchy repo cloned at `/home/arch/.local/share/omarchy` — root check patched for chroot
- Limine installed, pacman sandbox disabled
- Git configured: `lchtangen / 194328900+lchtangen@users.noreply.github.com`
- Locale: `en_US.UTF-8`
- Hostname: `omarchy`

### USB GRUB Menu (fixed)

```
1. Arch Linux - USB          ← default, boots sda2
2. Omarchy - Arch Linux (NVMe)  ← chainloads /EFI/Omarchy/grubx64.efi
3. Ubuntu - internal NVMe    ← chainloads /EFI/ubuntu/shimx64.efi (future)
4. UEFI Firmware Settings
```

---

## Step 1 — Boot into Omarchy Partition

**From USB GRUB menu:** Select `Omarchy - Arch Linux (NVMe)`

This chainloads the NVMe's own GRUB, which then boots:
```
root=UUID=1218c963-19b4-47ab-8145-a24806746439 rw rootflags=subvol=@ loglevel=3 quiet
```

You'll land at a TTY login (no Hyprland yet — Omarchy hasn't been fully installed).

**Login:** `arch` / password: `arch`

---

## Step 2 — Verify You're on the Right Partition

```bash
lsblk
cat /etc/hostname          # should say: omarchy
findmnt -n -o FSTYPE /     # should say: btrfs
ip link                    # verify network interface
```

---

## Step 3 — Connect to Network

**Wired (automatic via dhcpcd or NetworkManager):**
```bash
sudo systemctl start NetworkManager
nmcli device status
nmcli device connect <interface>
```

**WiFi:**
```bash
nmtui        # text UI for NetworkManager
# or
iwctl
  station wlan0 scan
  station wlan0 connect "SSID"
```

Verify:
```bash
ping -c 2 archlinux.org
```

---

## Step 4 — Run the Omarchy Installer

The Omarchy repo is already cloned at `~/.local/share/omarchy` with the root check patched. Run install.sh directly:

```bash
export OMARCHY_USER_NAME=lchtangen
export OMARCHY_USER_EMAIL="194328900+lchtangen@users.noreply.github.com"
export OMARCHY_ONLINE_INSTALL=true
export OMARCHY_PATH="$HOME/.local/share/omarchy"
export OMARCHY_INSTALL="$OMARCHY_PATH/install"
export OMARCHY_INSTALL_LOG_FILE="/var/log/omarchy-install.log"
export PATH="$OMARCHY_PATH/bin:$PATH"
export OMARCHY_MIRROR=stable

cd ~/.local/share/omarchy
source install.sh
```

**OR** re-run fresh via curl (this re-clones from GitHub, taking ~10 min longer):

```bash
curl -fsSL https://omarchy.org/install | bash
```

Installation takes **10–30 minutes**. It will install:
- Hyprland, Waybar, Walker, Mako, Hyprlock
- Alacritty, Neovim, Chromium, Obsidian
- All Omarchy themes and tooling
- Git, Docker, development tools

When prompted to reboot: **say yes** — you're already on the right partition.

---

## Step 5 — First Boot into Omarchy (Hyprland)

After the installer reboots, select `Omarchy - Arch Linux (NVMe)` from the USB GRUB menu again.

This time Hyprland will start automatically.

**Default hotkeys to know immediately:**
- `Super + K` — show all hotkeys
- `Super + Return` — open terminal (Alacritty)
- `Super + Alt + Space` — Omarchy Menu
- `Super + Ctrl + Shift + Space` — theme switcher

---

## Step 6 — Post-Install Setup

Run the system update first:
```bash
omarchy update
```

Set your timezone:
```bash
sudo timedatectl set-timezone America/Chicago   # or your zone
timedatectl status
```

Set up SSH keys:
```bash
ssh-keygen -t ed25519 -C "Lchtangen@gmail.com"
cat ~/.ssh/id_ed25519.pub    # add to GitHub
```

Clone your projects:
```bash
mkdir -p ~/Code
cd ~/Code
git clone git@github.com:lchtangen/Omarchy.git
```

---

## Step 7 — Make NVMe the Primary Boot Device (Optional)

Once Omarchy is working, you can set the NVMe EFI as the default boot device in BIOS so you don't need the USB GRUB menu:

1. Enter BIOS/UEFI (`F2` / `F12` / `Del` during POST)
2. Set boot order: NVMe first
3. The NVMe's own GRUB will load `Omarchy - Arch Linux` directly

The USB remains bootable as a fallback — just boot from it manually if needed.

---

## Troubleshooting

**Boots to black screen / no Hyprland after Omarchy install:**
```bash
# From TTY (Ctrl+Alt+F2), check Hyprland startup
Hyprland
journalctl -xe | grep -i hypr
```

**Network not working after boot:**
```bash
sudo systemctl enable --now NetworkManager
nmtui
```

**pacman fails (database error):**
```bash
# pacman sandbox was disabled during chroot install — should be fine
# if issues:
sudo pacman -Syy
```

**Wrong partition booted (USB instead of NVMe):**
- At GRUB: select `Omarchy - Arch Linux (NVMe)`
- Or change BIOS boot order to NVMe

**Installer fails mid-way:**
```bash
# Check log
sudo cat /var/log/omarchy-install.log | tail -50
# Re-run from where it failed or restart full install
```

---

## Reference UUIDs

| Partition | UUID | Purpose |
|-----------|------|---------|
| sda1 | `8A3D-5F1F` | USB EFI |
| sda2 | `dfd63dba-450d-4b77-b954-fdf760608240` | USB root |
| nvme0n1p1 | `5C7D-3AB3` | NVMe EFI |
| nvme0n1p2 | `bc6f23e6-a1f9-4738-a498-5f88da71527a` | /data |
| nvme0n1p3 | `1218c963-19b4-47ab-8145-a24806746439` | Omarchy root |
| nvme0n1p4 | `040f3418-a3fc-4a36-84d7-0b66926fa8c0` | CachyOS (future) |

---

## See Also

- [OMARCHY_INSTALL_GUIDE.md](OMARCHY_INSTALL_GUIDE.md) — full installation reference
- [OMARCHY_SETUP_FIRST_STEPS.md](OMARCHY_SETUP_FIRST_STEPS.md) — post-install configuration
- [OMARCHY_HYPRLAND_CONFIG.md](OMARCHY_HYPRLAND_CONFIG.md) — keybindings and window manager
