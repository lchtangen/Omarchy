# Cyberdeck — Security & Hardening Toolkit

Hardened security configurations for Omarchy Arch Linux.
Encryption, firewall rules, kernel hardening, and audit tooling.

## Structure

```
cyberdeck/
├── hardening/           # System hardening profiles
│   ├── kernel.conf      # sysctl security parameters
│   ├── pam.conf         # PAM hardening
│   └── apparmor/        # AppArmor profiles
├── firewall/            # nftables/iptables rules
│   ├── desktop.nft      # Desktop firewall (restrictive)
│   ├── laptop.nft       # Laptop firewall (mobile-friendly)
│   └── public.nft       # Public/hotspot firewall (locked)
├── encryption/          # Disk & file encryption
│   ├── luks.conf        # LUKS2 encryption defaults
│   ├── age-keys.yml     # age encryption keys
│   └── gpg.conf         # GPG hardening
└── audit/               # Security auditing
    ├── lynis.conf       # Lynis audit config
    └── scan.sh          # Weekly security scan
```
