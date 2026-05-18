# Aegis — Access Control & Authentication

Hardware-backed authentication for Omarchy. TPM, smartcard, biometric,
and multi-factor access control for your desktop.

## Structure

```
aegis/
├── auth/                # Authentication modules
│   ├── pam-2fa.conf     # PAM 2FA configuration
│   ├── smartcard.conf   # Smartcard/PIV login
│   └── totp.sh          # TOTP generator
├── biometric/           # Biometric auth
│   ├── fingerprint/     # fprintd configs
│   └── face/            # Howdy face auth config
└── tpm/                 # Trusted Platform Module
    ├── tpm2.conf        # TPM2 tools configuration
    ├── disk-unlock.sh   # TPM2 LUKS unlock
    └── key-rotate.sh    # Automatic key rotation
```
