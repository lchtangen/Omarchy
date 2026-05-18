# Omarchy Setup: First Steps

Post-installation configuration reference. Run through these steps after first boot into Hyprland.

See [OMARCHY_INSTALL_GUIDE.md](OMARCHY_INSTALL_GUIDE.md) if you haven't completed installation yet.

---

## First Boot Checklist

- [ ] Entered LUKS password at Plymouth screen
- [ ] Auto-logged into Hyprland
- [ ] Network connection active
- [ ] Run system update
- [ ] Configure git identity (if not set by installer)
- [ ] Set up SSH keys
- [ ] Create workspace directories

---

## System Update

Update immediately after install:

```bash
omarchy update
```

This updates the Omarchy packages, system packages, and any Omarchy-specific configurations. Run this before installing anything else.

For manual package updates:

```bash
sudo pacman -Syu
```

---

## The `omarchy` CLI

The `omarchy` command is your primary interface for system-level tasks:

```bash
omarchy update                          # update system
omarchy theme install <github-url>      # install a community theme
omarchy theme set "<theme-name>"        # apply a theme
omarchy theme remove "<theme-name>"     # remove a theme
```

Open the full Omarchy menu at any time with `Super + Alt + Space`.

---

## Update Channels

Omarchy supports multiple release channels. Switch via the Omarchy menu or config:

| Channel | Description |
|---------|-------------|
| `stable` | Default. Tested releases. |
| `rc` | Release candidate. Near-stable. |
| `edge` | Latest features, less testing. |
| `dev` | Bleeding edge, may break. |

Most users stay on `stable`. Switch only if you want early access to features.

---

## Git Configuration

The installer sets your name and email from the prompts. Verify:

```bash
git config --global user.name
git config --global user.email
```

Override if needed:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
```

---

## SSH Key Setup

Generate an SSH key and add to GitHub/GitLab/etc.:

```bash
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub
```

Copy the output and add it to your git hosting account.

Start the SSH agent:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

To persist across reboots, add to `~/.zshrc`:

```bash
# start ssh-agent if not running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi
```

---

## Workspace Directories

Create a consistent directory structure:

```bash
mkdir -p ~/Code ~/Projects ~/Documents ~/Downloads
```

The Omarchy community convention is `~/Code` for cloned repositories and development projects.

---

## Package Management

Omarchy uses three package sources:

**pacman** — Arch official repositories:
```bash
sudo pacman -S <package>
sudo pacman -Rs <package>        # remove with unused deps
sudo pacman -Ss <search-term>    # search
```

**yay** — AUR (Arch User Repository):
```bash
yay -S <aur-package>
yay -Ss <search-term>
```

**Omarchy package repo** — Omarchy-specific packages, managed via `omarchy update`.

Check if a package exists before installing:
```bash
pacman -Ss <name>
yay -Ss <name>
```

---

## Docker Setup

Docker is included in Omarchy with an integrated firewall configuration. Start and enable the service:

```bash
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

Log out and back in for group membership to take effect. Verify:

```bash
docker run hello-world
```

Docker Compose is available as `docker compose` (plugin, not standalone binary).

---

## Development Environments

### Ruby on Rails

Ruby and Rails are part of the default Omarchy stack:

```bash
ruby --version
rails --version
gem install bundler
```

For version management:
```bash
# rbenv is available
rbenv install 3.3.0
rbenv global 3.3.0
```

### Node.js

Node.js included by default:

```bash
node --version
npm --version
```

For version management, install `nvm` or `fnm` via yay:

```bash
yay -S fnm
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
```

### PHP

```bash
sudo pacman -S php php-fpm composer
```

### Database (PostgreSQL)

```bash
sudo pacman -S postgresql
sudo -u postgres initdb -D /var/lib/postgres/data
sudo systemctl enable --now postgresql
```

---

## System Snapshots

Omarchy configures btrfs with automatic snapshots via `snapper`. Snapshots allow rollback if an update breaks something.

List snapshots:
```bash
sudo snapper list
```

Roll back to a snapshot:
```bash
sudo snapper undochange <number>..0
```

Create a manual snapshot before major changes:
```bash
sudo snapper create --description "before major upgrade"
```

---

## Voice Dictation

Omarchy supports multiple speech-to-text options. See [OMARCHY_TOOLS_ECOSYSTEM.md](OMARCHY_TOOLS_ECOSYSTEM.md) for the full list. Quick setup with `hyprwhspr`:

```bash
git clone https://github.com/goodroot/hyprwhspr.git ~/Code/omarchy-tools/hyprwhspr
cd ~/Code/omarchy-tools/hyprwhspr
less README.md
```

Check dependencies before running any install script — the tool requires whisper model downloads and microphone permissions.

---

## OCR Text Extraction

Tesseract OCR is available for extracting text from images:

```bash
sudo pacman -S tesseract tesseract-data-eng
```

Some Omarchy setups include a screenshot-to-clipboard OCR hotkey. Check Omarchy menu under Tools.

---

## Bluetooth Keyboard (Post-Boot)

Bluetooth keyboards cannot enter the LUKS password at boot, but work normally once logged in.

Pair via the Omarchy menu or CLI:

```bash
bluetoothctl
power on
scan on
pair <MAC>
connect <MAC>
trust <MAC>
```

Or use the GUI: `Super + Alt + Space` > System > Bluetooth.

---

## Firewall

Omarchy includes firewall configuration integrated with Docker. The firewall is managed by `nftables` with rules that prevent Docker from accidentally exposing ports to the network.

Check status:
```bash
sudo systemctl status nftables
```

---

## Next Steps

- [OMARCHY_HYPRLAND_CONFIG.md](OMARCHY_HYPRLAND_CONFIG.md) — learn the keybindings and window manager
- [OMARCHY_UI_DESIGN_THEMING.md](OMARCHY_UI_DESIGN_THEMING.md) — customize themes and appearance
- [OMARCHY_TOOLS_ECOSYSTEM.md](OMARCHY_TOOLS_ECOSYSTEM.md) — explore the full application and tool ecosystem
- [OMARCHY_REPOS_AFTER_INSTALL.md](OMARCHY_REPOS_AFTER_INSTALL.md) — community tools and theme repositories
