# Firejail profile — Hardened browser
# Place at /etc/firejail/chromium.local or use --profile=

netfilter
noroot
nosound
notv
nou2f
no3d
nodvd
nodbus
noshell
nonewprivs

# Filesystem restrictions
private-dev
private-tmp
private-opt none
private-etc passwd,group,resolv.conf,ca-certificates
whitelist ~/Downloads

# Memory restrictions
memory-deny-write-execute
seccomp
caps.drop all

# Disable protocols
protocol unix,inet,inet6
