# Omarchy NVMe Install — Resume Guide
*Updated: 2026-05-18*

This document covers what to do after rebooting into the NVMe Arch base system
to complete the Omarchy installation.

---

## Current State (as of 2026-05-18)

### Partition Layout

| Device | Size | FS | Label | Status |
|--------|------|----|-------|--------|
| sda1 | 512MB | vfat | ARCH-EFI | USB EFI (fallback only) |
| sda2 | 59.3GB | ext4 | ARCH-USB | Running USB Arch — 90% full |
| nvme0n1p1 | 200MB | vfat | — | NVMe EFI — systemd-boot installed |
| nvme0n1p2 | 139.7GB | ext4 | — | /data — kernel builds, dev workspace |
| nvme0n1p3 | 46.4GB | btrfs | omarchy | **Boot target** — base Arch installed |
| nvme0n1p4 | 52.2GB | ext4 | data | Empty — reserved for future use |

### What's Already Done on nvme0n1p3

- Base Arch Linux installed via `pacstrap` from USB system
- Kernel: `vmlinuz-linux` + `initramfs-linux.img`
- Bootloader: **systemd-boot** on nvme0n1p1
- UEFI boot entry `Arch Linux (Omarchy)` registered — **already first in boot order**
- User: `omarchy` (UID 1000), wheel/sudo group, password set
- No LUKS encryption — boots directly to TTY login
- `sshd` enabled on port 22, password authentication on
- `NetworkManager` enabled
- Timezone: `Europe/Oslo`
- Locale: `en_US.UTF-8`
- Hostname: `omarchy`
- Omarchy installer not yet run — fresh base Arch only

### Boot Order (UEFI NVRAM)

```
Boot0005  Arch Linux (Omarchy)   ← NVMe systemd-boot  [FIRST]
Boot0004  Omarchy                ← old GRUB entry (ignore)
Boot001F  USB HDD                ← USB fallback
```

The machine will boot NVMe automatically. No USB GRUB menu needed.

---

## Step 1 — Reboot into NVMe

```bash
systemctl reboot
```

The machine boots straight into the NVMe base Arch system (no menu, 3 second
timeout). No keyboard input needed — no LUKS encryption.

**Do NOT touch the USB drive.** It stays plugged in but the NVMe boots first.

---

## Step 2 — SSH in from Android (Termux)

You have no physical keyboard. Use Termux on Android (10.0.0.131) to SSH in.

```bash
# In Termux — install tools if not already done
pkg update && pkg upgrade -y
pkg install openssh nmap tmux

# Find the NVMe system's IP (hostname: omarchy)
nmap -sn 10.0.0.0/24
# Look for host named "omarchy" — will be a 10.0.0.x address

# Connect
ssh omarchy@<IP>

# Start persistent tmux session so install survives if SSH drops
tmux new -s install
```

If SSH drops mid-install, reconnect and run:
```bash
ssh omarchy@<IP>
tmux attach -t install
```

---

## Step 3 — Verify You're on the Right System

```bash
cat /etc/hostname          # omarchy
findmnt -n -o FSTYPE /     # btrfs
lsblk                      # nvme0n1p3 mounted at /
uname -r                   # kernel version
```

---

## Step 4 — Connect to Network

NetworkManager is enabled and starts automatically. WiFi:

```bash
sudo systemctl start NetworkManager
nmtui                      # text UI — select WiFi, enter password
```

Or wired (auto via DHCP):
```bash
nmcli device status
```

Verify:
```bash
ping -c 2 archlinux.org
```

---

## Step 5 — Run the Omarchy Installer

Inside the tmux session:

```bash
curl -fsSL https://omarchy.org/install | bash
```

The installer will prompt for:
- **Full name** — enter your name
- **Email** — `Lchtangen@gmail.com`

Installation takes **10–30 minutes**. Installs:
- Hyprland, Waybar, Walker, Mako, Hyprlock
- Alacritty, Neovim, Chromium, Obsidian
- Git, Docker, development tools
- All Omarchy themes and tooling

When prompted to reboot — **say yes**.

---

## Step 6 — First Boot into Omarchy (Hyprland)

After reboot the NVMe boots again automatically. This time Hyprland starts.

**Essential hotkeys:**
| Hotkey | Action |
|--------|--------|
| `Super + K` | Show all hotkeys |
| `Super + Return` | Terminal (Alacritty) |
| `Super + Alt + Space` | Omarchy Menu |
| `Super + Space` | App launcher (Walker) |
| `Super + Ctrl + Shift + Space` | Theme switcher |

---

## Step 7 — Post-Install Setup

```bash
# Update everything first
omarchy update

# Correct timezone (set during base install but verify)
sudo timedatectl set-timezone Europe/Oslo
timedatectl status

# Set up SSH keys
ssh-keygen -t ed25519 -C "Lchtangen@gmail.com"
cat ~/.ssh/id_ed25519.pub    # add to GitHub

# Create workspace
mkdir -p ~/Code
cd ~/Code
git clone git@github.com:lchtangen/Omarchy.git
```

---

## Step 8 — Pair Bluetooth Keyboard (After Login)

Bluetooth works fine after Hyprland is running — just not at boot (no LUKS so
no boot-time prompt needed anyway).

```bash
bluetoothctl
power on
scan on
pair <MAC>
connect <MAC>
trust <MAC>
```

Or via Omarchy Menu: `Super + Alt + Space` → System → Bluetooth.

---

## Troubleshooting

**Machine boots USB instead of NVMe:**
```bash
# Check UEFI boot order from USB system
efibootmgr | grep BootOrder
# Boot0005 should be first — if not:
sudo efibootmgr --bootorder 0005,$(efibootmgr | grep BootOrder | cut -d: -f2 | tr -d ' ')
```

**SSH refused after reboot into NVMe:**
```bash
# sshd should auto-start — if not, you need physical keyboard or serial
# Verify from chroot (from USB):
sudo arch-chroot /mnt/target systemctl status sshd
```

**Can't find NVMe IP with nmap:**
```bash
# Check router DHCP table at 10.0.0.138 or 10.0.0.1
# Or scan broader:
nmap -sn 10.0.0.0/24 -oG - | grep omarchy
```

**Omarchy install fails mid-way:**
```bash
sudo tail -50 /var/log/omarchy-install.log
# Re-run:
curl -fsSL https://omarchy.org/install | bash
```

**No network after NVMe boot:**
```bash
sudo systemctl enable --now NetworkManager
nmtui
```

**pacman database errors:**
```bash
sudo pacman -Syy
sudo pacman -Suu
```

---

## Reference UUIDs

| Partition | UUID | Purpose |
|-----------|------|---------|
| sda1 | `8A3D-5F1F` | USB EFI |
| sda2 | `dfd63dba-450d-4b77-b954-fdf760608240` | USB root |
| nvme0n1p1 | `5C7D-3AB3` | NVMe EFI (systemd-boot) |
| nvme0n1p2 | `bc6f23e6-a1f9-4738-a498-5f88da71527a` | /data |
| nvme0n1p3 | `1218c963-19b4-47ab-8145-a24806746439` | Omarchy root (btrfs) |
| nvme0n1p4 | `040f3418-a3fc-4a36-84d7-0b66926fa8c0` | Reserved |

## Network Reference

| IP | Device |
|----|--------|
| 10.0.0.1 | Router / AP |
| 10.0.0.2 | Android device |
| 10.0.0.108 | Unknown device |
| 10.0.0.131 | Your Android (Termux SSH on :8022) |
| 10.0.0.138 | Zyxel gateway (DNS, DHCP) |
| 10.0.0.98 | This PC (USB Arch) |
| 10.63.84.x | Android USB tethering subnet |

NVMe system will appear as a new `10.0.0.x` lease after first boot.

---

## See Also

- [OMARCHY_INSTALL_GUIDE.md](OMARCHY_INSTALL_GUIDE.md) — full install reference
- [TERMUX_ANDROID_TOOLS.md](TERMUX_ANDROID_TOOLS.md) — Termux SSH and tools
- [NVME_DIAGNOSTICS_MAINTENANCE.md](NVME_DIAGNOSTICS_MAINTENANCE.md) — drive health
- [OMARCHY_SETUP_FIRST_STEPS.md](OMARCHY_SETUP_FIRST_STEPS.md) — post-install config
- [OMARCHY_HYPRLAND_CONFIG.md](OMARCHY_HYPRLAND_CONFIG.md) — keybindings
