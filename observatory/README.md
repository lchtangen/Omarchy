# Observatory — System Observability

Real-time monitoring, telemetry, health checks, and dashboards for Omarchy.
See everything. Know everything.

## Structure

```
observatory/
├── dashboards/          # Monitoring dashboards
│   ├── btop.json        # btop theme + layout config
│   ├── waybar-metrics/  # Waybar system indicators
│   └── cockpit/         # Cockpit dashboard integration
├── telemetry/           # Metrics collection
│   ├── prometheus/      # Prometheus node exporter configs
│   ├── stats.conf       # System statistics collection
│   └── metrics.sh       # Custom metric collector
├── alerts/              # Alerting rules
│   ├── cpu.alert        # CPU threshold alerts
│   ├── memory.alert     # Memory pressure alerts
│   ├── disk.alert       # Disk space alerts
│   └── temp.alert       # Thermal alerts
└── healthchecks/        # System health probes
    ├── kernel.sh        # Kernel health check
    ├── services.sh      # Critical service check
    └── network.sh       # Network connectivity check
```
