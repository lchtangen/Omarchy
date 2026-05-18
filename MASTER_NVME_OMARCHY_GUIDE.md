# Master Guide: NVMe Arch Linux to Omarchy

Updated: 2026-05-18

This is the single starting point for the Arch Linux NVMe partition named
`omarchy`. It explains what is installed, what was fixed, how to boot, and what
to do next to finish installing Omarchy.

## Current Known State

- Target disk: `nvme0n1`
- EFI partition: `nvme0n1p1`
- Data/work partition: `nvme0n1p2`, mounted as `/data` from the USB system
- Arch root partition: `nvme0n1p3`
- Root filesystem: btrfs, label `omarchy`
- Bootloader: Limine
- Boot menu entry: `Arch Linux (Omarchy)`
- Login user on the NVMe Arch system: `arch`
- Password: `arch`
- Desktop: none yet; this is a clean vanilla Arch base for running the Omarchy installer
- Network services enabled: `NetworkManager`, `sshd`

Important: a black screen before the repair was not a desktop crash. There was
no desktop installed yet. The root directory permissions were wrong and the boot
line hid the useful console output.

## Repairs Already Done

The installed NVMe root had bad permissions:

```text
/ = 750
```

That was fixed to:

```text
/ = 755
```

Related mountpoint placeholder directories were also normalized:

```text
/boot = 755
/home = 755
/run  = 755
/dev  = 755
/data = 755
```

The system default target was set to text mode:

```bash
systemctl set-default multi-user.target
```

Limine was changed from a silent boot line:

```text
quiet loglevel=3 rd.udev.log_level=3 splash
```

to a visible text boot line:

```text
loglevel=7 systemd.unit=multi-user.target
```

So the next boot should show kernel/systemd text and land at a TTY login.

## Next Boot Steps

1. Reboot.

   ```bash
   systemctl reboot
   ```

2. In Limine, select:

   ```text
   Arch Linux (Omarchy)
   ```

3. Wait for verbose boot text.

4. Log in at the text prompt:

   ```text
   login: arch
   password: arch
   ```

5. Confirm you are on the NVMe Arch system:

   ```bash
   hostnamectl
   findmnt -n -o SOURCE,FSTYPE,OPTIONS /
   lsblk -f
   cat /etc/arch-release
   ```

Expected:

- `/` is mounted from `nvme0n1p3`
- filesystem type is `btrfs`
- `/etc/arch-release` exists

## Connect Network

If Ethernet is plugged in, DHCP should work automatically through
NetworkManager.

Check:

```bash
nmcli device status
ping -c 3 archlinux.org
```

For WiFi:

```bash
nmtui
```

Choose `Activate a connection`, select your WiFi, enter the password, then test:

```bash
ping -c 3 archlinux.org
```

## Run the Omarchy Installer

Once network works:

```bash
bash <(curl -fsSL https://omarchy.org/install)
```

If process substitution gives trouble in a minimal shell, use:

```bash
curl -fsSL https://omarchy.org/install -o /tmp/omarchy-install
bash /tmp/omarchy-install
```

The installer may ask for your name and email for git configuration. After it
finishes, reboot when prompted.

## If the Screen Looks Black Again

Try switching TTYs:

```text
Ctrl+Alt+F2
Ctrl+Alt+F3
Ctrl+Alt+F1
```

If that works, log in and inspect:

```bash
journalctl -b -p err --no-pager
systemctl --failed
```

If nothing appears at all, boot back into the USB fallback and inspect the NVMe
journal:

```bash
sudo mkdir -p /mnt/omarchy-nvme
sudo mount -o subvol=/ /dev/nvme0n1p3 /mnt/omarchy-nvme
sudo journalctl --directory /mnt/omarchy-nvme/@log/journal --list-boots
sudo journalctl --directory /mnt/omarchy-nvme/@log/journal -b -0 -p warning --no-pager
sudo umount /mnt/omarchy-nvme
```

## If the Installer Fails

Collect these first:

```bash
cat /etc/os-release
findmnt -n -o SOURCE,FSTYPE,OPTIONS /
lsblk -f
systemctl --failed
journalctl -b -p err --no-pager
pacman -Q gnome-shell plasma-desktop limine btrfs-progs 2>/dev/null
```

The intended pre-install conditions are:

- Arch Linux base system
- btrfs root
- no GNOME or KDE Plasma desktop
- Limine installed
- network working

## SSH Option

If you prefer controlling the install from another device:

```bash
ip addr
sudo systemctl status sshd
```

From another machine:

```bash
ssh arch@<NVME-IP>
```

Then run the installer inside `tmux` if available:

```bash
tmux new -s omarchy-install
bash <(curl -fsSL https://omarchy.org/install)
```

If SSH drops:

```bash
ssh arch@<NVME-IP>
tmux attach -t omarchy-install
```

## After Omarchy Installs

After reboot, Omarchy should start Hyprland.

Useful keys:

| Key | Action |
| --- | --- |
| `Super + Return` | Terminal |
| `Super + Space` | App launcher |
| `Super + Alt + Space` | Omarchy menu |
| `Super + K` | Hotkey help |
| `Super + Ctrl + Shift + Space` | Theme switcher |

First maintenance commands:

```bash
omarchy update
timedatectl status
git config --global user.name
git config --global user.email
```

Create SSH key if needed:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
cat ~/.ssh/id_ed25519.pub
```

## Where Supporting Docs Are Copied

The support bundle should be copied to:

```text
/home/arch/OMARCHY_GUIDE
```

Start here:

```bash
less ~/OMARCHY_GUIDE/MASTER_NVME_OMARCHY_GUIDE.md
```

Other useful files in the bundle:

- `docs/guides/OMARCHY_INSTALL_GUIDE.md`
- `docs/guides/OMARCHY_SETUP_FIRST_STEPS.md`
- `docs/guides/NVME_DIAGNOSTICS_MAINTENANCE.md`
- `docs/ecosystem/OMARCHY_TOOLS_ECOSYSTEM.md`
- `docs/ecosystem/OMARCHY_HYPRLAND_CONFIG.md`
- `docs/ecosystem/OMARCHY_UI_DESIGN_THEMING.md`

## Golden Rule

Do not force power off unless the machine is truly stuck. Prefer:

```bash
systemctl reboot
systemctl poweroff
```

The NVMe SMART report showed many unsafe shutdowns, though no media errors.
Keeping shutdowns clean protects the filesystem and saves time.
