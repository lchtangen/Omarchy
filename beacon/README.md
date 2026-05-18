# Beacon — Presence Detection

Proximity-aware desktop. Unlock when you approach, lock when you leave,
switch profiles based on location or network.

## Structure

```
beacon/
├── proximity/           # Bluetooth proximity
│   ├── bt-detect.sh    # Bluetooth device scanner
│   ├── auto-unlock.sh  # Approach-based unlock
│   └── auto-lock.sh    # Leave-based lock
├── geo/                 # Geolocation profiles
│   ├── network-id.sh   # Network-based location
│   ├── work-profile    # Office configuration
│   └── home-profile    # Home configuration
└── presence/            # Presence detection
    ├── sensors.conf     # Sensor configuration
    └── idle.sh          # Advanced idle detection
```
