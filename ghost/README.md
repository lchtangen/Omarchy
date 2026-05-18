# Ghost — Stealth & Privacy Mode

Instant privacy for your Omarchy desktop. Kill switches, incognito mode,
camera/mic disable, and VPN auto-activation. When you need to disappear.

## Structure

```
ghost/
├── stealth/             # Stealth activation
│   ├── engage.sh        # Full stealth mode
│   ├── disengage.sh     # Return to normal
│   └── indicator.sh     # Stealth status indicator
├── vpn/                 # VPN automation
│   ├── killswitch.sh    # Network kill switch
│   ├── mullvad.conf     # Mullvad VPN config
│   └── wireguard.sh     # WireGuard auto-connect
└── privacy/             # Privacy hardeners
    ├── camera-kill.sh   # Disable webcam
    ├── mic-kill.sh      # Disable microphone
    └── clean-traces.sh  # Wipe session traces
```
