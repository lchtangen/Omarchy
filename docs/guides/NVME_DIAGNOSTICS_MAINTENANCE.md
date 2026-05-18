# NVMe Diagnostics & Maintenance — Omarchy Arch Linux
*Last run: 2026-05-18*

---

## 1. Hardware Overview

| Item | Value |
|------|-------|
| Model | Toshiba KXG6AZNV256G 256GB |
| Serial | 31CF30KCFDJ3 |
| Firmware | 5108AGLA |
| NVMe Version | 1.3 |
| Interface | PCIe (PCI Vendor 0x1179) |
| Power-on Hours | 6,947 h |
| Power Cycles | 666 |
| Unsafe Shutdowns | **171** |

---

## 2. SMART Health Report

```
SMART overall-health: PASSED
Critical Warning:               0x00  (none)
Temperature:                    41–42 °C
Available Spare:                100%  (threshold 10%)
Percentage Used (endurance):    10%
Media/Data Integrity Errors:    0
Error Log Entries:              0
Warning Comp. Temp. Time:       0
Critical Comp. Temp. Time:      0
```

**Status: HEALTHY.** Drive has consumed 10% of rated write endurance.
At current write pace (~11.88 TB total written over ~6,947 h) the drive
has significant remaining life. Temperature is nominal.

### Unsafe Shutdowns
171 unsafe shutdowns recorded. This is elevated — likely from force-reboots
during install sessions. No data integrity errors resulted, but continued
hard power-offs will accelerate NAND wear. Prefer `systemctl reboot` / `poweroff`.

---

## 3. Partition Map

```
Device         Size    FS      Mount Point(s)              Label / Notes
─────────────────────────────────────────────────────────────────────────
nvme0n1p1     200 MB  FAT32   /mnt/target/boot            Omarchy EFI (boot,esp)
nvme0n1p2     139.7G  ext4    /data                       kernel builds / workspace
nvme0n1p3     46.4 GB btrfs   /mnt/nvme  /mnt/target      Omarchy root (btrfs subvols)
nvme0n1p4     52.2 GB ext4    *** UNMOUNTED ***            label="data"
```

Partition table: GPT.

---

## 4. Filesystem Status

### 4a. nvme0n1p2 — ext4 /data

```
State:        clean
Block size:   4096
Free blocks:  30,058,661  (~114 GB free / 139.7 GB total = 16% used)
Mount count:  8
Last check:   2026-05-17 (at creation)
```

Mount options in `/etc/fstab`:
```
rw,noatime,nodiratime,commit=30,discard,errors=remount-ro,nofail
```
`noatime` + `discard` (TRIM) are correct for NVMe.

### 4b. nvme0n1p3 — btrfs (Omarchy)

```
Label:            omarchy
UUID:             1218c963-19b4-47ab-8145-a24806746439
Total size:       46.38 GiB
FS bytes used:    2.83 GiB
Allocated:        4.52 GiB
```

**Subvolumes:**
| ID | Path | Purpose |
|----|------|---------|
| 256 | @ | root |
| 257 | @home | /home |
| 258 | @log | /var/log |
| 259 | @pkg | /var/cache/pacman/pkg |
| 260 | @/var/lib/portables | systemd portables |
| 261 | @/var/lib/machines | systemd-nspawn |

**Scrub result (2026-05-17):**
```
Duration:  0:00:01
Scrubbed:  2.91 GiB
Rate:      2.91 GiB/s
Errors:    NONE
```

Mount options active:
```
ssd, discard=async, space_cache=v2, relatime
```
All correct for SSD/NVMe btrfs.

### 4c. nvme0n1p4 — ext4 (UNMOUNTED)

```
UUID:       040f3418-a3fc-4a36-84d7-0b66926fa8c0
Label:      data
State:      clean
Created:    2026-05-17 03:17
Last mount: 2026-05-17 17:28 (mount count: 1)
Size:       52.2 GB
```

This partition is formatted and labeled but **has no fstab entry** and is
not automounted. 52 GB is sitting idle.

---

## 5. Running System Disk Usage (sda — USB flash root)

```
/           58.0 GB total  |  52.2 GB used  |  2.8 GB free  |  90%  ← CRITICAL
/boot/efi   511 MB total   |  336 KB used   |  510.7 MB free |  0.1%
/data       136.4 GB total |  21.8 GB used  |  107.7 GB free |  16%
/mnt/nvme   46.4 GB total  |  2.9 GB used   |  43.1 GB free  |  6.3%
```

### Root consumer breakdown

```
/home       30 GB
  └─ dev/   20 GB
       ├─ projects/cyberpunk-2077/   17 GB
       │    └─ 01-DEVELOPMENT/repos  12 GB  (git clones)
       │    └─ 07-KERNEL-PACKAGE     2.6 GB
       ├─ projects/multi-platform    2.5 GB
       └─ ricing/                    783 MB
/usr        17 GB
/var        2.9 GB
/opt        1.6 GB
/mnt        1.2 GB
```

**Root is at 90% — 2.8 GB remaining. This is the top priority maintenance item.**

---

## 6. Issues & Priority Actions

### CRITICAL — Root filesystem nearly full

**Root (sda2) has only 2.8 GB free at 90% capacity.**

`/home/arch/dev/projects/` contains ~19.5 GB of project data that lives on the
USB flash drive root instead of the NVMe `/data` partition (107.7 GB free).

**Recommended fix — move projects to /data:**
```bash
# Move large project trees to NVMe /data
sudo mv /home/arch/dev/projects /data/projects

# Symlink back so paths stay consistent
ln -s /data/projects /home/arch/dev/projects
```

This alone reclaims ~19.5 GB, dropping root usage to ~35 GB (~60%).

Alternatively, move the entire `~/dev` tree:
```bash
sudo mv /home/arch/dev /data/dev
ln -s /data/dev /home/arch/dev
```

### MODERATE — nvme0n1p4 (52.2 GB) unused

The `data` partition on nvme0n1p4 is formatted but never mounted.
Options:
1. Add to `/etc/fstab` for a dedicated purpose (e.g. `/backup`, `/vm`, `/archive`)
2. Wipe and merge into nvme0n1p2 using `parted` resize if ext4 space is needed

To mount persistently, add to `/etc/fstab`:
```
UUID=040f3418-a3fc-4a36-84d7-0b66926fa8c0  /mnt/data2  ext4  rw,noatime,nodiratime,discard,nofail,x-systemd.device-timeout=0  0 2
```

Then: `sudo mkdir -p /mnt/data2 && sudo mount -a`

### LOW — Orphan packages (2 found)

```bash
# Review and remove
pacman -Qdt
sudo pacman -Rns $(pacman -Qdtq)
```

### LOW — Pacman cache (484 MB, normal)

Trim old cached package versions (keep last 2):
```bash
sudo paccache -r
```

---

## 7. Services Cleanup (2026-05-18)

Stopped and disabled on the USB running system to reduce resource usage:

| Service | Reason |
|---------|--------|
| `ollama` | AI inference server — not needed on USB |
| `tor` | Not in use |
| `clamav-freshclam` | Antivirus updater — resource hog |
| `docker` + `containerd` + `docker.socket` | Not in use |
| `vnstat` | Not critical |

Network cleanup:
- `docker0` bridge IP (172.17.0.1) removed
- `enp0s20f0u5` = Android USB tethering (10.63.84.x) — keep, do NOT disable

**Running services: 25 (was 30)**
**Active IPs: 10.0.0.98 (WiFi), 10.63.84.158 (Android USB tether)**

---

## 8. Network Map (2026-05-18)

| IP | Device | OS | Open Ports |
|----|--------|----|-----------|
| 10.0.0.1 | Router/AP (Ampak) | Linux 3–4.x | 80, 7000 (Sonos), UPnP |
| 10.0.0.2 | Android device | Android 9–11 | 8008–9000, 49153 (DLNA) |
| 10.0.0.108 | Unknown (stealth) | Unknown | port 7 filtered |
| 10.0.0.131 | Android (Termux) | Android 9–11 | 8022 (SSH), 8080 (HTTP) |
| 10.0.0.138 | Zyxel gateway | Linux 4–6.x | 53 (DNS), 80/443, 5000 |
| 10.0.0.98 | This PC | Arch Linux | 22 (SSH) |

NVMe Omarchy system will get a new 10.0.0.x lease after first boot.

---

## 9. Maintenance Commands Reference

### NVMe health check
```bash
sudo smartctl -a /dev/nvme0n1
sudo nvme smart-log /dev/nvme0n1
```

### Btrfs scrub (run monthly)
```bash
sudo btrfs scrub start /mnt/nvme
sudo btrfs scrub status /mnt/nvme
```

### TRIM / discard (run weekly if not using discard=async)
```bash
sudo fstrim -av
```
Not strictly needed here — `discard=async` on btrfs and `discard` on ext4
partitions handle this at the kernel level.

### Check ext4 health
```bash
sudo tune2fs -l /dev/nvme0n1p2 | grep -E "state|errors|Mount count"
sudo tune2fs -l /dev/nvme0n1p4 | grep -E "state|errors|Mount count"
```

### Force fsck on next boot (unmounted partition)
```bash
sudo tune2fs -C 0 -T now /dev/nvme0n1p4
sudo e2fsck -f /dev/nvme0n1p4
```

### List all block devices with UUIDs
```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,UUID
```

### Disk usage at a glance
```bash
duf -only local
```

---

## 10. fstab Reference

### Current `/etc/fstab` (running system on sda)

```fstab
# Root (USB flash)
UUID=dfd63dba-450d-4b77-b954-fdf760608240  /        ext4  rw,noatime,nodiratime,commit=30,discard,errors=remount-ro  0 1

# EFI (USB flash)
UUID=8A3D-5F1F  /boot/efi  vfat  rw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,errors=remount-ro  0 2

# NVMe data/workspace (nvme0n1p2)
UUID=bc6f23e6-a1f9-4738-a498-5f88da71527a  /data  ext4  rw,noatime,nodiratime,commit=30,discard,errors=remount-ro,nofail,x-systemd.device-timeout=0  0 2

# tmpfs
tmpfs  /tmp  tmpfs  rw,nosuid,nodev,noatime,size=4G  0 0
```

### NVMe UUID Reference

| Partition | UUID | FS | Role |
|-----------|------|----|------|
| nvme0n1p1 | 5C7D-3AB3 | FAT32 | Omarchy EFI |
| nvme0n1p2 | bc6f23e6-a1f9-4738-a498-5f88da71527a | ext4 | /data |
| nvme0n1p3 | 1218c963-19b4-47ab-8145-a24806746439 | btrfs | Omarchy root |
| nvme0n1p4 | 040f3418-a3fc-4a36-84d7-0b66926fa8c0 | ext4 | unmounted |

---

## 11. Omarchy Install State (nvme0n1p3 btrfs)

Base Arch Linux installed via `pacstrap` on 2026-05-18. State:

- btrfs subvolumes: `@`, `@home`, `@log`, `@pkg` — all present
- `/etc/fstab` generated with all subvolumes + EFI
- systemd-boot installed on nvme0n1p1, UEFI entry registered (Boot0005, first in order)
- User `omarchy` (UID 1000), sudo, password set
- `sshd` + `NetworkManager` enabled
- Omarchy install script **not yet run** — pending first boot + SSH from Android

Current btrfs usage: 2.83 GiB / 46.38 GiB (6%).

---

## 12. Scheduled Maintenance

| Task | Frequency | Command |
|------|-----------|---------|
| btrfs scrub | Monthly | `sudo btrfs scrub start /mnt/nvme` |
| SMART check | Monthly | `sudo smartctl -H /dev/nvme0n1` |
| Pacman cache trim | Weekly | `sudo paccache -r` |
| Orphan packages | Monthly | `sudo pacman -Rns $(pacman -Qdtq)` |
| Journal vacuum | Monthly | `sudo journalctl --vacuum-size=200M` |
| ext4 check log | Monthly | `sudo tune2fs -l /dev/nvme0n1p2 \| grep errors` |
