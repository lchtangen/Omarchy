# Protocol — Integration Layer

API contracts, webhook handlers, MCP (Model Context Protocol) servers,
and inter-process communication bridges for the Omarchy ecosystem.

## Structure

```
protocol/
├── mcp/                 # Model Context Protocol
│   ├── servers.json     # MCP server registry
│   └── tools/           # Custom MCP tool definitions
├── webhooks/            # Webhook endpoints
│   ├── theme-hook.sh    # Theme change webhook
│   └── alert-hook.sh    # Observatory alert webhook
├── apis/                # API integrations
│   ├── github.rest       # GitHub API queries
│   ├── weather.api       # Weather data for cortex
│   └── omarchy.api       # Omarchy CLI REST wrapper
└── ipc/                 # Inter-process communication
    ├── waybar-ipc.json   # Waybar IPC message format
    └── mako-ipc.sh       # Mako notification IPC
```
