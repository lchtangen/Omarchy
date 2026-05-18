# Termux — Android Tools & Features Reference
*For SSH access to Omarchy NVMe install and remote management*

GitHub: https://github.com/termux/termux-app
Packages: https://github.com/termux/termux-packages

---

## What Termux Is

Full Linux terminal environment on Android. No root required. Ships with its own
package ecosystem (1,073+ packages) built specifically for Android. Uses `pkg`
(frontend to `apt`) for package management.

Install from **F-Droid** (recommended — full features) or GitHub Releases.
Google Play version has reduced functionality on Android 12+.

---

## Package Manager

```bash
pkg update && pkg upgrade        # update all packages
pkg install <name>               # install a package
pkg search <name>                # search available packages
pkg uninstall <name>             # remove package
pkg list-installed               # show installed packages
pkg clean                        # clear package cache
```

---

## Essential Packages to Install First

```bash
pkg update && pkg upgrade
pkg install openssh git curl wget nmap python nodejs
```

---

## SSH — Connect to NVMe Arch System

```bash
# Install SSH client (included in openssh package)
pkg install openssh

# Connect to NVMe Arch (omarchy) on local network
ssh lchtangen@<IP>

# Find the IP: check router DHCP table, device will show hostname "omarchy"
# Common router addresses: 10.0.0.1 or 192.168.1.1

# Copy SSH key to remote (after generating one)
ssh-copy-id lchtangen@<IP>

# Generate SSH key on Termux (more secure than password)
ssh-keygen -t ed25519 -C "termux-android"
cat ~/.ssh/id_ed25519.pub        # copy this to remote ~/.ssh/authorized_keys
```

### SSH Config File (save typing)

Create `~/.ssh/config` in Termux to avoid typing the IP every time:

```
Host omarchy
    HostName <IP>
    User lchtangen
    IdentityFile ~/.ssh/id_ed25519
```

Then connect with just: `ssh omarchy`

### Mosh — Robust SSH for Mobile Networks

Mosh handles WiFi drops and IP changes better than plain SSH. Useful when moving between networks:

```bash
pkg install mosh

# On the remote Arch machine first:
sudo pacman -S mosh

# Connect
mosh lchtangen@<IP>
```

Mosh uses UDP and resumes automatically after reconnect. Requires the server-side `mosh-server` binary on the Arch machine.

### Run Omarchy Install Over SSH

```bash
ssh lchtangen@<IP> "curl -fsSL https://omarchy.org/install | bash"
# or connect interactively:
ssh lchtangen@<IP>
curl -fsSL https://omarchy.org/install | bash
```

---

## Termux SSH Server (use Android as SSH host)

Run an SSH server ON the Android device so you can SSH into it from PC:

```bash
pkg install openssh termux-auth
# Set password for SSH auth
passwd

# Start SSH server (Termux uses port 8022 by default, not 22)
sshd

# Connect from PC:
ssh -p 8022 <android-user>@<android-IP>

# Stop server
pkill sshd
```

---

## Networking Tools

| Package | What it does |
|---------|-------------|
| `openssh` | SSH client + server (v10.3p1) |
| `nmap` | Network scanner — find devices, open ports |
| `curl` | HTTP requests, download files |
| `wget` | File downloader |
| `netcat` | Raw TCP/UDP connections (included with nmap) |
| `socat` | Advanced socket relay |
| `aria2` | Fast multi-connection downloader |

### Find the NVMe system's IP with nmap

```bash
pkg install nmap
# Scan your local subnet for the "omarchy" host
nmap -sn 10.0.0.0/24            # adjust subnet to match your network
# or
nmap -sn 192.168.1.0/24
```

---

## Development Tools

| Package | Purpose |
|---------|---------|
| `git` | Version control |
| `python` | Python 3 interpreter |
| `nodejs` | Node.js runtime |
| `gcc` / `clang` | C/C++ compilers |
| `make` | Build system |
| `vim` / `nano` | Terminal text editors |
| `tmux` | Terminal multiplexer (persistent sessions) |
| `fzf` | Fuzzy finder |
| `ripgrep` | Fast grep replacement |
| `jq` | JSON processor |

---

## Plugin Apps (Install Separately)

All available on F-Droid or GitHub Releases. Must use same signing source as Termux app.

| Plugin | What it adds |
|--------|-------------|
| **Termux:API** | Access Android hardware (camera, GPS, SMS, contacts, clipboard, sensors) |
| **Termux:Boot** | Run scripts automatically on device boot |
| **Termux:Float** | Floating terminal window overlay |
| **Termux:Styling** | Custom fonts and color schemes |
| **Termux:Tasker** | Integration with Tasker automation app |
| **Termux:Widget** | Home screen shortcuts to Termux scripts |

### Termux:API examples

```bash
pkg install termux-api

termux-clipboard-get              # read clipboard
termux-clipboard-set "text"       # set clipboard
termux-notification --title "Done" --content "Omarchy installed"
termux-battery-status             # battery info
termux-wifi-connectioninfo        # WiFi details including IP
termux-tts-speak "text"           # text to speech
```

---

## Useful Termux Features

### Persistent SSH sessions (survive disconnect)

```bash
pkg install tmux

# Start session before SSH-ing into omarchy
ssh lchtangen@<IP>
tmux new -s omarchy

# Run Omarchy install — if SSH drops, reconnect and:
tmux attach -t omarchy
```

### Wake on LAN from Termux

```bash
pkg install netcat
# Send magic packet to wake NVMe machine if sleeping
```

### File transfer to/from NVMe

```bash
# Copy file to NVMe
scp localfile.txt lchtangen@<IP>:~/

# Copy file from NVMe
scp lchtangen@<IP>:~/file.txt ./

# Full directory sync
rsync -avz lchtangen@<IP>:~/Code/ ./Code/
```

---

## Quick Setup Sequence (for NVMe Omarchy install)

Run this in Termux on Android before attempting to connect:

```bash
# 1. Update Termux
pkg update && pkg upgrade -y

# 2. Install required tools
pkg install openssh nmap tmux

# 3. Find the NVMe host IP
nmap -sn 10.0.0.0/24 | grep -A2 omarchy

# 4. Connect with persistent session
ssh lchtangen@<found-IP>

# 5. Inside SSH session — start tmux so install survives disconnect
tmux new -s install

# 6. Run Omarchy installer
curl -fsSL https://omarchy.org/install | bash
```

---

## Finding Your Local Network Subnet in Termux

```bash
pkg install termux-api
termux-wifi-connectioninfo | grep ip
# shows your Android's IP, e.g. 10.0.0.105 → subnet is 10.0.0.0/24
```

---

## Official Resources

- App repo: https://github.com/termux/termux-app
- Packages: https://github.com/termux/termux-packages
- Full package list: https://termux-packages.ajam.dev
- Plugins: https://github.com/termux
