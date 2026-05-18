# Nexus — AI Orchestration Hub

Central command for AI agents, prompt engineering, and MCP (Model Context Protocol) servers.
Integrates AI coding assistants, local LLMs, and automation workflows into the Omarchy desktop.

## Structure

```
nexus/
├── agents/              # AI agent configurations
│   ├── claude.json      # Claude Code agent config
│   ├── aider.yml        # Aider AI pair programmer
│   └── copilot.lua      # Neovim Copilot integration
├── prompts/             # Reusable prompt templates
│   ├── code-review.md   # Code review system prompt
│   ├── commit.md        # Commit message generator
│   └── theme-design.md  # Theme creation assistant
├── mcp-servers/         # MCP server definitions
│   ├── filesystem.json  # Filesystem access MCP
│   ├── github.json      # GitHub API MCP
│   └── custom/          # Custom MCP servers
└── workflows/           # AI-powered automation
    ├── auto-theme.sh    # AI-assisted theme tuning
    └── code-review.sh   # Automated review pipeline
```

## AI Agent Configuration

### Claude Code

```bash
# Initialize Claude Code in any project
claude

# With custom config from this dir
claude --config nexus/agents/claude.json
```

### MCP Servers

MCP servers extend AI capabilities with tools and resources:

```bash
# Start a custom MCP server
mcp-server --config nexus/mcp-servers/filesystem.json
```
