# Omarchy Install Guide

Omarchy is an opinionated Arch Linux desktop built around Hyprland (Wayland tiling compositor), created by David Heinemeier Hansson (DHH) of 37signals. It combines Arch's power with a curated, keyboard-first developer experience. Mandatory full-disk LUKS encryption, btrfs snapshots, and a single-command install path make it production-ready out of the box.

**Official resources:**
- https://omarchy.org/
- https://learn.omacom.io/2/the-omarchy-manual
- https://github.com/basecamp/omarchy

---

## Hardware Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| CPU | x86_64 compatible | Modern multi-core |
| RAM | 4 GB | 8 GB+ |
| Storage | 60 GB | 256 GB+ SSD |
| Boot mode | UEFI required | UEFI |
| USB drive | 8 GB | 16 GB+ |

**Keyboard:** Wired or 2.4 GHz dongle keyboard required during setup. Bluetooth keyboards cannot enter the LUKS password at the encrypted boot prompt — they initialize too late in the boot sequence.

**GPU:** Works with Intel, AMD, and NVIDIA. NVIDIA may require additional driver steps post-install.

---

## Method 1: Fresh Install via Omarchy ISO

### Step 1 — Download the ISO

Download the latest ISO from https://omarchy.org/ (current stable: v3.8.0+).

Verify the checksum if provided:

```bash
sha256sum omarchy-*.iso
```

### Step 2 — Create Bootable USB

**On Linux:**

```bash
# Using caligula (recommended, AUR)
caligula burn omarchy-*.iso --target /dev/sdX

# Using dd (low-level, verify device first with lsblk)
sudo dd if=omarchy-*.iso of=/dev/sdX bs=4M status=progress oflag=sync

# Using balenaEtcher (GUI)
# Download from balena.io/etcher — flash the ISO to your USB drive
```

**On macOS or Windows:** Use balenaEtcher (https://etcher.balena.io/).

Replace `/dev/sdX` with your USB device (check with `lsblk` or `lsusb`). This operation wipes the USB drive.

### Step 3 — BIOS/UEFI Configuration

1. Enter BIOS/UEFI firmware (usually `F2`, `F12`, `Del`, or `Esc` during POST)
2. Disable **Secure Boot** — Omarchy ISO is not signed
3. Disable **TPM** if it causes boot issues (some hardware)
4. Set USB as first boot device
5. Save and reboot

### Step 4 — Boot from USB

Insert the USB drive and power on the machine. The Omarchy installer will start automatically.

### Step 5 — Run the Installer

The installer will prompt for:

1. **Full name** — used for git config
2. **Email address** — used for git config
3. **Target disk** — choose carefully; installation **wipes the selected disk entirely**
4. **LUKS encryption password** — use a strong passphrase; you will enter this on every boot

Installation takes approximately **2–10 minutes** depending on hardware and connection speed.

### Step 6 — First Boot

1. Remove the USB drive when prompted
2. At the Plymouth boot screen, enter your **LUKS encryption password**
3. The system auto-logs in after decryption
4. Hyprland starts automatically

---

## Method 2: Install on Existing Arch Linux

If you already have Arch Linux running, install Omarchy with a single command:

```bash
curl -fsSL https://omarchy.org/install | bash
```

This script:
- Requests sudo access
- Prompts for your name and email (git config)
- Installs the complete Omarchy package set
- Takes 5–30 minutes depending on connection speed
- Asks permission before rebooting

After reboot, Hyprland starts automatically.

---

## Method 3: Manual Installation

For advanced users who want full control. Reference the official manual:
https://learn.omacom.io/2/the-omarchy-manual/96/manual-installation

High-level steps:
1. Install Arch Linux base system per the Arch Wiki
2. Set up UEFI boot (systemd-boot or GRUB)
3. Configure LUKS on root partition
4. Format as btrfs with subvolumes
5. Clone basecamp/omarchy and run the setup scripts

---

## Disk Layout

Omarchy configures the following partition structure automatically:

```
/dev/sdX
├── /dev/sdX1   EFI System Partition   512 MB   FAT32
└── /dev/sdX2   Root Partition         rest     LUKS → btrfs
```

**btrfs subvolumes:**
- `@` — mounted at `/`
- `@home` — mounted at `/home`
- `@snapshots` — automatic system snapshots for rollback

LUKS encryption wraps the root partition. The EFI partition is unencrypted (required for bootloader).

---

## Boot Process

```
UEFI firmware
  └── systemd-boot (EFI partition)
        └── Plymouth boot splash + LUKS password prompt
              └── btrfs root mount
                    └── auto-login → Hyprland
```

---

## Troubleshooting

**Installer fails to detect disk:**
- Verify UEFI mode is enabled (not legacy/CSM)
- Check that no existing LUKS container is blocking the target device: `cryptsetup status`

**Can't type LUKS password at boot:**
- Use a wired or 2.4 GHz dongle keyboard — Bluetooth is unavailable at the Plymouth prompt
- If password is correct but rejected, verify keyboard layout matches what you typed during setup

**NVIDIA GPU issues:**
- Post-install, install the NVIDIA proprietary driver: `sudo pacman -S nvidia nvidia-utils`
- May require adding `nvidia_drm.modeset=1` to kernel parameters

**Secure Boot error:**
- Disable Secure Boot in BIOS/UEFI firmware settings

**System won't boot after install:**
- Boot from USB again
- Mount the LUKS container: `cryptsetup open /dev/sdX2 root`
- Mount the btrfs root: `mount /dev/mapper/root /mnt`
- `arch-chroot /mnt` and inspect `/boot/loader/entries/`

**Installer hangs during package download:**
- Check network connection
- Try a different mirror by editing `/etc/pacman.d/mirrorlist` and re-running the installer

---

## Next Steps

After successful installation, continue with:
- [OMARCHY_SETUP_FIRST_STEPS.md](OMARCHY_SETUP_FIRST_STEPS.md) — post-install configuration
- [OMARCHY_HYPRLAND_CONFIG.md](OMARCHY_HYPRLAND_CONFIG.md) — window manager keybindings and config
- [OMARCHY_UI_DESIGN_THEMING.md](OMARCHY_UI_DESIGN_THEMING.md) — themes and visual customization
