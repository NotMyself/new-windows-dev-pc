# Windows Developer Setup Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-7%2B-5391FE.svg?logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-0078d4.svg?logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![WSL](https://img.shields.io/badge/WSL-Ubuntu%2022.04-FF7F00.svg?logo=ubuntu&logoColor=white)](https://docs.microsoft.com/en-us/windows/wsl/)
[![WinGet](https://img.shields.io/badge/WinGet-Package%20Manager-0078d4.svg?logo=microsoft&logoColor=white)](https://github.com/microsoft/winget-cli)
[![Visual Studio Code](https://img.shields.io/badge/VSCode-Extensions%20Included-007ACC.svg?logo=visual-studio-code&logoColor=white)](https://code.visualstudio.com/)
[![Git](https://img.shields.io/badge/Git-Configuration%20Included-F05032.svg?logo=git&logoColor=white)](https://git-scm.com/)
[![Node.js](https://img.shields.io/badge/Node.js-via%20fnm-339933.svg?logo=node.js&logoColor=white)](https://nodejs.org/)
[![.NET](https://img.shields.io/badge/.NET-Included-512BD4.svg?logo=.net&logoColor=white)](https://dotnet.microsoft.com/)
[![Azure](https://img.shields.io/badge/Azure-CLI%20Included-0078d4.svg?logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Claude Code](https://img.shields.io/badge/Claude-Code%20Optimized-FF6B35.svg?logo=openai&logoColor=white)](https://claude.ai)
[![License](https://img.shields.io/badge/License-MIT-green.svg?logo=open-source-initiative&logoColor=white)](LICENSE)


A comprehensive Windows developer setup automation repository with **PowerShell 7+**, **Windows 11** optimizations, and **mandatory WSL integration**. Features streamlined configuration scripts, automated tool installation, and Claude Code integration with 9+ specialized AI agents for development workflows.

**🚀 Key Features:**
- **Streamlined Two-Step Setup**: Simple installation and configuration process
- **Mandatory WSL Integration**: WSL development environment with Ubuntu 22.04
- **Claude Code AI Integration**: 9 specialized agents with intelligent delegation
- **PowerShell 7+ Optimizations**: Modern shell features and cross-platform compatibility
- **Automated Tool Installation**: 30+ development tools via WinGet package manager
- **Secure Credential Management**: 1Password integration for environment variables
- **Professional Development Environment**: VSCode, terminals, and productivity tools

**Development Stack:**
- **Windows Tools**: PowerShell 7, Windows Terminal, PowerToys, Git, Azure CLI
- **WSL Environment**: Ubuntu 22.04 with Node.js, .NET SDK, development tools
- **IDEs & Editors**: Visual Studio 2022 Professional, VSCode with 31+ extensions
- **AI-Powered Development**: Claude Code with domain-specific expert agents

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [WSL Integration](#wsl-integration)
- [Installed Packages](#installed-packages)
- [Configuration Management](#configuration-management)
- [Claude Code Integration](#claude-code-integration)
- [Advanced Setup Scripts](#advanced-setup-scripts)
- [Directory Structure](#directory-structure)
- [Detailed Documentation](#detailed-documentation)
- [Troubleshooting](#troubleshooting)

## Prerequisites

- **Windows 10/11** - Windows 11 recommended for enhanced features
- **PowerShell 7+** - Required for configuration scripts (auto-installed if missing)
- **Developer Mode** - Recommended for symbolic links without admin privileges
- **Administrator Access** - Scripts handle elevation automatically
- **Internet Connection** - Required for downloading packages and tools

## Quick Start

### Two-Step Setup Process

1. **Install Development Tools & WSL Environment** 
   ```powershell
   .\install.ps1
   ```
   - Installs WinGet package manager with comprehensive error handling
   - Installs 30+ development tools, IDEs, and utilities via WinGet
   - **Automatically sets up WSL** (Ubuntu-22.04) with development tools
   - Configures **WSL development environment** (Node.js, .NET, Azure CLI, 1Password CLI)
   - Installs Cascadia Code developer fonts with system registry integration
   - Installs 31+ curated VSCode extensions with progress tracking
   - Sets up global npm packages using Fast Node Manager (fnm)

2. **Configure Complete Development Environment**
   ```powershell
   .\configure.ps1
   ```
   - **Configures Claude Code for WSL** with bash shell and development tools
   - **1Password integration** for secure environment variables in both Windows and WSL
   - **Separate Git identity** for Claude Code commits with user/AI attribution
   - **Interactive Configuration Wizard** with step-by-step guidance and explanations
   - **Developer Mode Detection** for admin-free symbolic link creation
   - Creates symbolic links for all configuration files (Git, VSCode, terminals)
   - Sets up PowerShell profiles with Oh My Posh themes and productivity functions

### Skip Confirmations (Automated Mode)
```powershell
.\configure.ps1 -SkipConfirmation
```

### Force Reconfiguration
```powershell
.\configure.ps1 -Force
```

## WSL Integration

### Mandatory WSL Setup

WSL integration is now mandatory for optimal development experience:

- **Ubuntu 22.04**: Automatically installed and configured
- **Development Tools**: Node.js, .NET SDK, Azure CLI, 1Password CLI
- **Claude Code Configuration**: Bash shell with prettier, markdownlint, and git tools
- **Cross-Platform Development**: Seamless Windows-WSL file system integration
- **Secure Environment**: 1Password integration for credential management

### WSL Development Environment

The WSL environment includes:

#### System Tools
- **Node.js LTS**: Latest stable version via NodeSource repository
- **.NET SDK**: Microsoft .NET development platform
- **Azure CLI**: Command-line tools for Azure development
- **1Password CLI**: Secure credential and environment variable management

#### Development Tools
- **Essential npm packages**: prettier, markdownlint-cli, typescript, eslint
- **Build tools**: make, build-essential, curl, wget
- **Git**: Version control with proper configuration

#### Claude Code Integration
- **Bash shell configuration**: Optimized for Claude Code development workflows
- **Tool permissions**: Access to prettier, markdownlint, git, dotnet, npm
- **Environment variables**: Properly configured development environment

## Installed Packages

The setup installs a comprehensive suite of development tools via WinGet package manager:

| Category | Package | Description | Notes |
|----------|---------|-------------|-------|
| **Package Management** | WinGet | Windows package manager | Enhanced installation with fallbacks |
| **Windows & CLI Tools** | PowerToys | Windows system utilities | Enhanced Windows functionality |
| | Windows Terminal | Modern terminal application | Windows 11 optimizations available |
| | PowerShell | Latest cross-platform PowerShell | **Required 7+** for configuration |
| | Oh My Posh | Custom PowerShell prompts | Custom themes with Git integration |
| **Development Environment** | Git | Version control system | Enhanced configuration with VSCode integration |
| | Git LFS | Large File System for Git | Large file handling |
| | GitHub CLI | Command-line interface for GitHub | GitHub operations from command line |
| | .NET | Microsoft development framework | Cross-platform development runtime |
| | fnm | Fast Node.js version manager | Node.js version management with npm integration |
| | Azure CLI | Command-line interface for Azure | **Service principal setup included** |
| | Claude | Anthropic's AI assistant | **9+ specialized agents included** |
| **IDEs & Editors** | Visual Studio 2022 Professional | Full-featured IDE | Comprehensive .NET development |
| | Visual Studio Code | Lightweight code editor | **31+ curated extensions** |
| | SQL Server Management Studio | SQL Server administration | Advanced database administration |
| | JetBrains Toolbox | JetBrains IDE manager | Management of JetBrains IDEs |
| **Developer Fonts** | Cascadia Code | Microsoft's monospaced font | **Auto-registry integration** |

## Configuration Management

### Streamlined Configuration Architecture

The setup uses a **streamlined, mandatory configuration approach** that:
- **Automatically configures WSL**: No optional WSL setup - it's mandatory for optimal development
- **Handles both Windows and WSL**: Single configuration script manages both environments  
- **Creates symbolic links**: Centralized configuration management through repository files
- **Interactive guidance**: Step-by-step configuration with explanations and confirmations
- **Error resilience**: Comprehensive error handling with clear recovery instructions

### Configuration Components

| Component | Configuration Script | Target Location | Features |
|-----------|---------------------|-----------------|----------|
| **Git** | `configure-git-windows.ps1` | `~/.gitconfig` | VSCode integration, aliases |
| **VSCode** | `configure-vscode-windows.ps1` | `%APPDATA%\Code\User\` | Settings and keybindings |
| **PowerShell** | `configure-pwsh-windows.ps1` | `$PROFILE` & `~/.theme.omp.json` | Enhanced profile with 1Password |
| **Windows Terminal** | `configure-windows-terminal.ps1` | Multiple locations | **Windows 11 features** |
| **NuGet** | `configure-nuget-windows.ps1` | `%APPDATA%\NuGet\` | Package sources configuration |
| **Markdownlint** | `configure-markdownlint-windows.ps1` | `~/.markdownlint.json` | Documentation consistency |
| **Claude Code** | WSL integration scripts | `~/.claude/` | **WSL-optimized configuration** |

### Enhanced Features

- **Mandatory WSL Mode**: WSL configuration is no longer optional - it's the default and recommended approach
- **Interactive Wizard**: Step-by-step configuration with detailed explanations
- **Skip Confirmations**: Use `-SkipConfirmation` for automated deployment scenarios
- **Force Mode**: Use `-Force` to overwrite existing configurations
- **1Password Integration**: Secure environment variable management across Windows and WSL

## Claude Code Integration

### 9 Specialized AI Agents

The repository includes comprehensive Claude Code configuration with specialized agents:

| Agent | Purpose | Capabilities |
|-------|---------|--------------|
| **agent-expert** | Creating specialized agents | Agent design patterns and best practices |
| **azure-devops-specialist** | Azure DevOps operations | Pipelines, builds, releases, project management |
| **command-expert** | CLI command creation | Command design and automation patterns |
| **csharp-specialist** | Modern C# development | Latest language features and frameworks |
| **feature-prompt-specialist** | Creating feature prompts | Well-structured development task prompts |
| **markdown-specialist** | Markdown documentation | CommonMark and GitHub Flavored Markdown standards |
| **mcp-expert** | Model Context Protocol | MCP server configurations and integration |
| **mstest-specialist** | .NET unit testing | MSTest.Sdk and NSubstitute integration |
| **readme-maintainer** | Documentation maintenance | Hierarchical README updates with bottom-up processing |

### Development Commands

Pre-configured slash commands for common development tasks:

| Command | Purpose | Usage |
|---------|---------|-------|
| `/csharp` | C# development tasks | Modern C# features and patterns |
| `/devops` | Azure DevOps operations | Pipeline management and automation |
| `/markdown` | Markdown editing | Documentation formatting and linting |
| `/mstest` | Unit testing | Test creation and MSTest patterns |
| `/new-agent` | Create new agents | Agent design and implementation |
| `/new-feature` | Feature development | Structured feature implementation |
| `/readme` | README maintenance | Documentation updates and formatting |

### WSL-Optimized Claude Code Setup

```json
{
  "shell": "/bin/bash",
  "env": {
    "SHELL": "/bin/bash", 
    "CLAUDE_SHELL": "/bin/bash",
    "WSL_DISTRO_NAME": "Ubuntu-22.04"
  },
  "terminal": {
    "shell": "wsl",
    "args": ["-d", "Ubuntu-22.04", "bash", "-l"]
  },
  "permissions": {
    "allow": [
      "Bash(prettier:*)",
      "Bash(markdownlint:*)", 
      "Bash(git:*)",
      "Bash(dotnet:*)",
      "Bash(npm:*)"
    ]
  }
}
```

## Advanced Setup Scripts

### Azure Integration
```powershell
.\settings\az\setup-azure-service-principal.ps1
```
- **Interactive Azure CLI authentication**
- **Service principal creation** with Contributor role
- **1Password credential storage**
- **Connection testing** and validation

### 1Password Environment Vault
```powershell
.\settings\1password\setup-environment-vault.ps1
```
- **Secure environment variable management**
- **CLI integration setup**
- **Vault creation and configuration** 
- **PowerShell and WSL integration**

### WSL Development Environment
```bash
./installs/wsl-tools.sh
```
- **Node.js, .NET SDK, Azure CLI installation** in WSL
- **Development tools setup** (prettier, markdownlint, git)
- **1Password CLI configuration** for WSL
- **Environment optimization** for development workflows

## Directory Structure

```
new-windows-dev-pc/
├── install.ps1                    # Main installation script with mandatory WSL setup
├── configure.ps1                  # Streamlined configuration script
├── LICENSE                        # MIT License
├── CLAUDE.md                      # Claude Code guidance
├── fonts/
│   └── CascadiaCode.zip           # Developer fonts
├── installs/                     # Installation modules
│   ├── install-winget.ps1         # WinGet installation with fallbacks
│   ├── npm-global.ps1             # Global npm packages
│   ├── vscode.ps1                 # VSCode extensions installer
│   ├── winget.ps1                 # WinGet package installer
│   ├── wsl-tools.sh               # WSL development environment setup
│   └── README.md                  # Installation documentation
├── prompts/                       # Development prompts
│   └── npm-global-packages-management.md
└── settings/                      # Configuration files and scripts
    ├── 1password/                 # 1Password integration
    │   └── setup-environment-vault.ps1
    ├── az/                        # Azure setup scripts
    │   └── setup-azure-service-principal.ps1
    ├── claude/                    # Claude Code configuration
    │   ├── configure-claude-windows-11.ps1  # Windows 11 setup script
    │   ├── settings-wsl.json      # WSL-optimized Claude Code settings
    │   ├── .mcp.json              # MCP configuration
    │   ├── agents/                # 9 specialized agents
    │   ├── commands/              # Development commands
    │   └── templates/             # Project templates
    ├── git/                       # Git configuration
    │   ├── configure-git-windows.ps1        # Modular configuration
    │   ├── .gitconfig             # Git settings
    │   └── README.md
    ├── markdownlint/              # Markdown linting
    │   ├── configure-markdownlint-windows.ps1
    │   └── .markdownlint.json
    ├── npm/                       # NPM configuration
    │   └── global-packages        # Global package list
    ├── nuget/                     # NuGet configuration
    │   ├── configure-nuget-windows.ps1
    │   └── NuGet.Config           # Package sources
    ├── pwsh/                      # PowerShell configuration
    │   ├── configure-pwsh-windows.ps1       # Modular configuration
    │   ├── Microsoft.PowerShell_profile.ps1 # Enhanced profile
    │   ├── .theme.omp.json        # Oh My Posh theme
    │   └── 1p-env-vars.ps1        # 1Password integration
    ├── vscode/                    # VSCode configuration
    │   ├── configure-vscode-windows.ps1     # Modular configuration
    │   ├── settings.json          # VSCode settings
    │   ├── keybindings.json       # Key bindings
    │   ├── extensions             # Extension list
    │   └── README.md
    ├── windows-terminal/          # Windows Terminal
    │   ├── configure-windows-terminal.ps1   # Windows 11 features
    │   ├── settings.json          # Terminal configuration
    │   └── README.md
    ├── wsl/                       # WSL-specific configuration
    │   ├── configure-1password-wsl.sh       # 1Password CLI setup for WSL
    │   └── 1p-env-vars.sh         # Environment variable loading
    ├── visual-studio/             # Visual Studio configuration
    │   └── .vsconfig              # Workload configuration
    └── etc/                       # System configuration
        ├── hosts                  # Custom hosts entries
        └── README.md
```

## Detailed Documentation

Each directory contains comprehensive documentation with setup instructions and troubleshooting:

| Directory | Documentation | Key Topics |
|-----------|---------------|------------|
| **installs/** | [Installation Scripts README](installs/README.md) | Modular installation, WSL setup, execution order |
| **settings/claude/** | [Claude Configuration README](settings/claude/README.md) | **9 agents, commands, WSL integration** |
| **settings/git/** | [Git Configuration README](settings/git/README.md) | VSCode integration, workflows, modular configuration |
| **settings/vscode/** | [VSCode Configuration README](settings/vscode/README.md) | **31+ extensions**, modular setup, productivity features |
| **settings/windows-terminal/** | [Terminal README](settings/windows-terminal/README.md) | **Windows 11 features**, themes, fragments |
| **settings/pwsh/** | [PowerShell README](settings/pwsh/README.md) | **1Password integration**, Oh My Posh, functions |
| **settings/etc/** | [Hosts File README](settings/etc/README.md) | Network configuration, security considerations |

## Troubleshooting

### Common Issues and Solutions

| Issue | Symptoms | Solution |
|-------|----------|----------|
| **PowerShell Version** | Configuration script won't run | Install PowerShell 7+ or run: `pwsh .\configure.ps1` |
| **Developer Mode** | Symbolic link creation fails | Enable Windows Developer Mode in Settings → For developers |
| **UAC Elevation** | Scripts fail with permissions error | Click "Yes" when UAC prompt appears (automatic) |
| **WSL Setup Issues** | WSL installation or configuration fails | Ensure WSL feature is enabled, restart if needed |
| **Configuration Failures** | Individual tool setup fails | Run specific configuration script: `.\settings\[tool]\configure-*.ps1` |
| **1Password Integration** | Environment variables not working | Run: `.\settings\1password\setup-environment-vault.ps1` |
| **Azure Setup** | Service principal creation fails | Run: `.\settings\az\setup-azure-service-principal.ps1` |
| **Claude Code WSL Issues** | Claude Code not working in WSL | Check WSL tools installation and configuration |

### Advanced Troubleshooting

- **WSL Environment Issues**: Use `wsl --list --verbose` to check WSL status
- **Tool Permissions**: Verify Claude Code permissions for bash tools
- **Configuration Validation**: Run individual configuration scripts to isolate issues
- **Force Reconfiguration**: Use `.\configure.ps1 -Force` to overwrite existing settings

---

## What's New

### Major Enhancements
- ✅ **Mandatory WSL Integration** with Ubuntu 22.04 and comprehensive development tools
- ✅ **Streamlined Configuration** with single-command setup for both Windows and WSL
- ✅ **Claude Code WSL Optimization** with bash shell and development tool integration
- ✅ **9 Specialized AI Agents** with intelligent delegation and domain expertise
- ✅ **Enhanced 1Password Integration** for secure credential management across environments
- ✅ **Simplified Workflow** with mandatory components for optimal development experience
- ✅ **Cross-Platform Development** with seamless Windows-WSL integration
- ✅ **Professional Tool Chain** with 30+ development tools and 31+ VSCode extensions

### Updated Components
- ⬆️ **install.ps1**: Mandatory WSL setup with comprehensive development environment
- ⬆️ **configure.ps1**: Streamlined configuration wizard with WSL integration
- ⬆️ **Claude Code Settings**: WSL-optimized configuration with bash shell
- ⬆️ **All Documentation**: Updated to reflect simplified, WSL-integrated workflow

---

**Ready to set up your development environment?** Run `.\install.ps1` followed by `.\configure.ps1` for a complete Windows + WSL development setup with Claude Code AI integration!