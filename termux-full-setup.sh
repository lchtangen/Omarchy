#!/data/data/com.termux/files/usr/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Termux Full Setup — Run this IN TERMUX on your device:
#    bash /sdcard/Download/termux-full-setup.sh
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${CYAN}║   Termux Full Network Tools Setup              ║${NC}"
echo -e "${BOLD}${CYAN}║   70+ packages | Android + Arch               ║${NC}"
echo -e "${BOLD}${CYAN}╚══════════════════════════════════════════════╝${NC}"

# Storage permission
echo -e "${YELLOW}Granting storage permission...${NC}"
termux-setup-storage 2>/dev/null || echo "  Run: termux-setup-storage manually"

# Update packages
echo -e "${GREEN}[1/8] Updating packages...${NC}"
pkg update -y 2>/dev/null || apt update -y
pkg upgrade -y 2>/dev/null || apt upgrade -y

# Connectivity
echo -e "${GREEN}[2/8] Installing connectivity tools...${NC}"
pkg install -y openssh rsync curl wget nmap netcat-openbsd socat \
    dnsutils inetutils iputils whois traceroute mtr iperf3 tcpdump \
    lsof ethtool iftop nload iptables nftables 2>/dev/null

# VPN & Tunneling
echo -e "${GREEN}[3/8] Installing VPN/tunneling tools...${NC}"
pkg install -y openvpn wireguard-tools sshfs autossh rclone \
    proxychains-ng dnscrypt-proxy tor 2>/dev/null

# Security & Pentesting
echo -e "${GREEN}[4/8] Installing security tools...${NC}"
pkg install -y hydra john hashcat aircrack-ng nikto sqlmap masscan \
    gobuster ncrack binwalk 2>/dev/null

# Android & ADB
echo -e "${GREEN}[5/8] Installing Android tools...${NC}"
pkg install -y android-tools termux-api 2>/dev/null

# Dev & CLI
echo -e "${GREEN}[6/8] Installing dev tools...${NC}"
pkg install -y git python ruby nodejs neovim bat eza fd ripgrep \
    fzf zsh jq sshpass p7zip unzip tar gzip bzip2 xz zstd 2>/dev/null

# Monitoring extras
echo -e "${GREEN}[7/8] Installing monitoring tools...${NC}"
pkg install -y speedtest-cli bmon lshw cifs-utils nfs-utils davfs2 2>/dev/null

# Post-install setup
echo -e "${GREEN}[8/8] Configuring...${NC}"

# Create Termux aliases
mkdir -p ~/.termux
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
alias clipget='termux-clipboard-get'
alias clipset='termux-clipboard-set'
alias sharehere='python -m http.server 8080'
alias sshserver='sshd && echo "SSH on port 8022"'
ALIASES

grep -q 'aliases.sh' ~/.bashrc 2>/dev/null || echo '[[ -f ~/.termux/aliases.sh ]] && source ~/.termux/aliases.sh' >> ~/.bashrc
grep -q 'aliases.sh' ~/.zshrc 2>/dev/null || echo '[[ -f ~/.termux/aliases.sh ]] && source ~/.termux/aliases.sh' >> ~/.zshrc

# Start SSH server
sshd 2>/dev/null || true

# Create symlinks for common tools
ln -sf /data/data/com.termux/files/usr/bin/python3 /data/data/com.termux/files/usr/bin/python 2>/dev/null || true

echo ""
echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${GREEN}║   Installation Complete!                     ║${NC}"
echo -e "${BOLD}${GREEN}╠══════════════════════════════════════════════╣${NC}"
echo -e "${BOLD}${GREEN}║                                               ║${NC}"
echo -e "${BOLD}${CYAN}║   Quick Commands:                             ║${NC}"
echo -e "${BOLD}${CYAN}║     myip             External IP               ║${NC}"
echo -e "${BOLD}${CYAN}║     iplocal          Local IP                  ║${NC}"
echo -e "${BOLD}${CYAN}║     ports            Listening ports             ║${NC}"
echo -e "${BOLD}${CYAN}║     scan <target>    Full nmap scan              ║${NC}"
echo -e "${BOLD}${CYAN}║     quickscan <ip>  Fast port scan               ║${NC}"
echo -e "${BOLD}${CYAN}║     wifiinfo         WiFi connection info         ║${NC}"
echo -e "${BOLD}${CYAN}║     batinfo          Battery status              ║${NC}"
echo -e "${BOLD}${CYAN}║     sshserver        Start SSH on :8022          ║${NC}"
echo -e "${BOLD}${CYAN}║     sharehere        HTTP server on :8080        ║${NC}"
echo -e "${BOLD}${CYAN}║                                               ║${NC}"
echo -e "${BOLD}${GREEN}║   Android from Arch:                          ║${NC}"
echo -e "${BOLD}${GREEN}║     adb shell          Device shell              ║${NC}"
echo -e "${BOLD}${GREEN}║     adb push <file>     Push file               ║${NC}"
echo -e "${BOLD}${GREEN}║     adb pull <file>     Pull file               ║${NC}"
echo -e "${BOLD}${GREEN}║     scrcpy              Mirror screen            ║${NC}"
echo -e "${BOLD}${GREEN}║                                               ║${NC}"
echo -e "${BOLD}${GREEN}╚══════════════════════════════════════════════╝${NC}"