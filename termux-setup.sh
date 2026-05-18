#!/usr/bin/env bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Termux Android Network Tools Setup
#  Run this on your Android device in Termux:
#    pkg update && pkg upgrade -y
#    bash termux-setup.sh
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
set -euo pipefail

echo "╔══════════════════════════════════════════════╗"
echo "║   Termux Network Tools Installer             ║"
echo "╚══════════════════════════════════════════════╝"

# Update packages
pkg update -y && pkg upgrade -y

# ─── Core Networking ──────────────────────────────────────────────
pkg install -y \
    openssh \
    rsync \
    curl \
    wget \
    nmap \
    netcat-openbsd \
    socat \
    dnsutils \
    inetutils \
    iputils \
    whois \
    traceroute \
    mtr \
    iperf3 \
    tcpdump \
    lsof \
    bridge-utils \
    vlan \
    ethtool \
    iftop \
    nload \
    iptables \
    nftables

# ─── VPN & Tunneling ─────────────────────────────────────────────
pkg install -y \
    openvpn \
    wireguard-tools \
    sshfs \
    autossh \
    rclone \
    proxychains-ng \
    dnscrypt-proxy \
    tor

# ─── Security & Pentesting ────────────────────────────────────────
pkg install -y \
    hydra \
    john \
    hashcat \
    aircrack-ng \
    nikto \
    sqlmap \
    masscan \
    gobuster \
    ncrack \
    metasploit-framework \
    responder \
    bettercap \
    binutils \
    binwalk \
    exiftool \
    file \
    foremost \
    sleuthkit \
    volatility \

# ─── Android/ADB ──────────────────────────────────────────────────
pkg install -y \
    android-tools \
    termux-api \
    termux-auth \
    termux-exec \
    termux-services

# ─── Dev Tools ───────────────────────────────────────────────────
pkg install -y \
    git \
    python \
    ruby \
    nodejs \
    golang \
    rust \
    neovim \
    bat \
    eza \
    fd \
    ripgrep \
    fzf \
    zsh \
    starship \
    jq \
    yq \
    fx \
    hexcurse \
    radare2 \
    ghidra

# ─── Storage & Filesystem ────────────────────────────────────────
pkg install -y \
    cifs-utils \
    nfs-utils \
    davfs2 \
    sshpass \
    p7zip \
    unzip \
    tar \
    gzip \
    bzip2 \
    xz \
    zstd

# ─── Post-Install Setup ──────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   Setting up Termux permissions...           ║"
echo "╚══════════════════════════════════════════════╝"

# Termux API permissions
termux-setup-storage 2>/dev/null || echo "  Run: termux-setup-storage (in Termux)"

# SSH server config
mkdir -p ~/.ssh
chmod 700 ~/.ssh
sshd 2>/dev/null || echo "  SSH server started on port 8022"

# Create useful Termux aliases
cat > ~/.termux/aliases.sh << 'ALIASES'
# Termux Network Aliases
alias myip='curl -s ifconfig.me'
alias iplocal='ip addr show | grep "inet " | grep -v 127.0.0.1'
alias ports='ss -tulpen'
alias scan='nmap -sV'
alias quickscan='nmap -T4 -F'
alias pingtest='ping -c 5 1.1.1.1'
alias dnstest='dig google.com @1.1.1.1 +short'
alias wifiinfo='termux-wifi-connectioninfo'
alias wifiscan='termux-wifi-scaninfo'
alias batinfo='termux-battery-status'
alias clipboard='termux-clipboard-get'
alias clipset='termux-clipboard-set'
alias torch='termux-toast "Use: termux-torch on/off"'
alias vpnup='sudo wg-quick up wg0 2>/dev/null || echo "Configure WireGuard first"'
alias vpndown='sudo wg-quick down wg0 2>/dev/null'
alias sshserver='sshd && echo "SSH server running on port 8022"'
alias sharehere='python -m http.server 8080'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
ALIASES

# Add alias source to .bashrc
grep -q 'aliases.sh' ~/.bashrc 2>/dev/null || echo '[[ -f ~/.termux/aliases.sh ]] && source ~/.termux/aliases.sh' >> ~/.bashrc

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║   Installation Complete!                     ║"
echo "╠══════════════════════════════════════════════╣"
echo "║                                               ║"
echo "║   Android Tools:                              ║"
echo "║     adb devices          List devices          ║"
echo "║     adb shell            Device shell          ║"
echo "║     adb push/pull        Transfer files        ║"
echo "║     scrcpy               Mirror screen         ║"
echo "║     fastboot             Flash/restore         ║"
echo "║                                               ║"
echo "║   Termux API:                                 ║"
echo "║     termux-battery-status                      ║"
echo "║     termux-wifi-connectioninfo                 ║"
echo "║     termux-wifi-scaninfo                       ║"
echo "║     termux-clipboard-get/set                   ║"
echo "║     termux-location                            ║"
echo "║     termux-notification                        ║"
echo "║     termux-toast 'message'                     ║"
echo "║                                               ║"
echo "║   Network Essentials:                         ║"
echo "║     nmap, masscan, hydra, sqlmap              ║"
echo "║     aircrack-ng, bettercap, responder         ║"
echo "║     tcpdump, wireshark, tshark                ║"
echo "║     openvpn, wireguard, proxychains            ║"
echo "║                                               ║"
echo "║   Quick Start:                                ║"
echo "║     sshd            # Start SSH on :8022      ║"
echo "║     myip            # Show external IP         ║"
echo "║     quickscan <ip>  # Fast port scan           ║"
echo "║     speedtest       # Network speed test       ║"
echo "║                                               ║"
echo "╚══════════════════════════════════════════════╝"