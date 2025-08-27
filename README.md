# Windows Developer Setup Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-7%2B-5391FE.svg?logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-0078d4.svg?logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![WinGet](https://img.shields.io/badge/WinGet-Package%20Manager-0078d4.svg?logo=microsoft&logoColor=white)](https://github.com/microsoft/winget-cli)
[![Visual Studio Code](https://img.shields.io/badge/VSCode-Extensions%20Included-007ACC.svg?logo=visual-studio-code&logoColor=white)](https://code.visualstudio.com/)
[![Git](https://img.shields.io/badge/Git-Configuration%20Included-F05032.svg?logo=git&logoColor=white)](https://git-scm.com/)
[![Node.js](https://img.shields.io/badge/Node.js-via%20fnm-339933.svg?logo=node.js&logoColor=white)](https://nodejs.org/)
[![.NET](https://img.shields.io/badge/.NET-Included-512BD4.svg?logo=.net&logoColor=white)](https://dotnet.microsoft.com/)
[![Azure](https://img.shields.io/badge/Azure-CLI%20Included-0078d4.svg?logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Claude Code](https://img.shields.io/badge/Claude-Code%20Optimized-FF6B35.svg?logo=openai&logoColor=white)](https://claude.ai)
[![License](https://img.shields.io/badge/License-MIT-green.svg?logo=open-source-initiative&logoColor=white)](LICENSE)


A comprehensive Windows developer setup automation repository with **PowerShell 7+** and **Windows 11** optimizations. Features modular configuration scripts, interactive setup wizards, and Claude Code integration for AI-powered development.

**🚀 New Features:**
- **Interactive Configuration Wizard**: Step-by-step setup with user confirmations and explanations
- **PowerShell 7+ Required**: Modern shell features with enhanced Unicode and emoji support
- **Windows 11 Enhanced Features**: Advanced terminal themes and optimizations
- **Developer Mode Detection**: Automatic symbolic link support without admin privileges
- **Modular Configuration Architecture**: Individual configuration scripts for each tool
- **Claude Code Integration**: 10+ specialized AI agents and development commands
- **Azure Integration**: Service principal setup and secure credential management
- **1Password Integration**: Secure environment variable management

**Key Features:**
- **Automated Tool Installation**: WinGet-based package management with enhanced progress tracking
- **Advanced Configuration Management**: Modular symbolic link-based settings with interactive wizards
- **Developer Fonts**: Cascadia Code font installation for optimal coding experience
- **Professional Architecture**: Separated installation and configuration with comprehensive error handling

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Enhanced Features](#enhanced-features)
- [Installed Packages](#installed-packages)
- [Configuration Management](#configuration-management)
- [Claude Code Integration](#claude-code-integration)
- [Advanced Setup Scripts](#advanced-setup-scripts)
- [Directory Structure](#directory-structure)
- [Detailed Documentation](#detailed-documentation)
- [Troubleshooting](#troubleshooting)

## Prerequisites

- **Windows 10/11** - Windows 11 recommended for enhanced features
- **PowerShell 7+** - Required for advanced configuration wizard (auto-installed if missing)
- **Developer Mode** - Recommended for symbolic links without admin privileges
- **Administrator Access** - Scripts handle elevation automatically
- **Internet Connection** - Required for downloading packages and tools

## Quick Start

### Enhanced Two-Step Process

1. **Install Development Tools** (Enhanced with PowerShell 7+ detection)
   ```powershell
   .\install.ps1
   ```
   - Automatically detects and prefers PowerShell 7+ for better experience
   - Installs WinGet package manager with improved error handling
   - Installs development tools, IDEs, and utilities via WinGet
   - Installs Cascadia Code developer fonts with registry integration
   - Installs curated VSCode extensions with progress tracking

2. **Configure Development Environment** (New Interactive Wizard)
   ```powershell
   pwsh .\configure.ps1
   ```
   - **Interactive Configuration Wizard** with step-by-step guidance
   - **Developer Mode Detection** for admin-free symbolic links
   - **Windows 11 Enhanced Features** opt-in
   - Creates symbolic links for all configuration files
   - Sets up Git, VSCode, Windows Terminal, PowerShell, and Claude Code
   - **1Password Environment Vault** setup

### Skip Confirmations (Fast Mode)
```powershell
pwsh .\configure.ps1 -SkipConfirmation
```

## Enhanced Features

### 🆕 Interactive Configuration Wizard
- **Step-by-step guidance** with explanations for each configuration
- **What/Why descriptions** for each tool configuration
- **Skip, Continue, or Quit** options at each step
- **Progress tracking** with success/failure summaries

### 🆕 Windows 11 Optimizations
- **Enhanced Terminal Themes** with Claude Code branding
- **Advanced Color Schemes** with ligature support  
- **Optimized Environment Variables** for modern development
- **Terminal Fragments** with custom profiles

### 🆕 Developer Mode Support
- **Automatic Detection** of Windows Developer Mode
- **Symbolic Links** without Administrator privileges
- **Clear Instructions** for enabling Developer Mode
- **Fallback to Admin Mode** if needed

### 🆕 PowerShell 7+ Requirements
- **Modern Shell Features** with enhanced Unicode support
- **Better Error Handling** and progress indicators
- **Cross-Platform Compatibility** features
- **Automatic Version Detection** and guidance

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
| | Claude | Anthropic's AI assistant | **10+ specialized agents included** |
| **IDEs & Editors** | Visual Studio 2022 Professional | Full-featured IDE | Comprehensive .NET development |
| | Visual Studio Code | Lightweight code editor | **31+ curated extensions** |
| | SQL Server Management Studio | SQL Server administration | Advanced database administration |
| | JetBrains Toolbox | JetBrains IDE manager | Management of JetBrains IDEs |
| **Developer Fonts** | Cascadia Code | Microsoft's monospaced font | **Auto-registry integration** |

## Configuration Management

### 🆕 Modular Configuration Architecture

The setup now uses **individual configuration scripts** for each tool, providing:
- **Granular Control**: Configure specific tools independently
- **Better Error Handling**: Isolated failures don't affect other configurations
- **Detailed Logging**: Clear success/failure reporting per tool
- **Reusable Scripts**: Run individual configurations as needed

### Configuration Components

| Component | Configuration Script | Target Location | Features |
|-----------|---------------------|-----------------|----------|
| **Git** | `configure-git-windows.ps1` | `~/.gitconfig` | VSCode integration, aliases |
| **VSCode** | `configure-vscode-windows.ps1` | `%APPDATA%\Code\User\` | Settings and keybindings |
| **PowerShell** | `configure-pwsh-windows.ps1` | `$PROFILE` & `~/.theme.omp.json` | Enhanced profile with 1Password |
| **Windows Terminal** | `configure-windows-terminal.ps1` | Multiple locations | **Windows 11 features** |
| **NuGet** | `configure-nuget-windows.ps1` | `%APPDATA%\NuGet\` |  |
| **Markdownlint** | `configure-markdownlint-windows.ps1` | `~/.markdownlint.json` | Documentation consistency |

### 🆕 Advanced Features

- **Force Mode**: `.\configure.ps1 -Force` to overwrite existing configurations
- **Skip Confirmations**: `.\configure.ps1 -SkipConfirmation` for automated deployment
- **Windows 11 Features**: Opt-in enhanced features for modern Windows
- **1Password Integration**: Secure environment variable management

## Claude Code Integration

### 🆕 Specialized AI Agents (10+)

The repository includes comprehensive Claude Code configuration with specialized agents:

| Agent | Purpose | Capabilities |
|-------|---------|--------------|
| **agent-expert** | Creating specialized agents | Agent design patterns and best practices |
| **azure-devops-specialist** | Azure DevOps operations | Pipelines, builds, releases, project management |
| **command-expert** | CLI command creation | Command design and automation |
| **csharp-specialist** | Modern C# development | Latest language features and frameworks |
| **feature-prompt-specialist** | Creating feature prompts | Well-structured development task prompts |
| **markdown-specialist** | Markdown documentation | CommonMark and Azure DevOps standards |
| **mcp-expert** | Model Context Protocol | MCP server configurations and integration |
| **mstest-specialist** | .NET unit testing | MSTest.Sdk and NSubstitute integration |
| **readme-maintainer** | Documentation maintenance | Hierarchical README updates |

### 🆕 Development Commands (10+)

Pre-configured slash commands for common development tasks:

| Command | Purpose | Usage |
|---------|---------|-------|
| `/csharp` | C# development tasks | Modern C# features and patterns |
| `/devops` | Azure DevOps operations | Pipeline management and automation |
| `/git-workflow` | Git workflow assistance | Branching, merging, conflict resolution |
| `/markdown` | Markdown editing | Documentation formatting and linting |
| `/mstest` | Unit testing | Test creation and MSTest patterns |
| `/new-agent` | Create new agents | Agent design and implementation |
| `/new-feature` | Feature development | Structured feature implementation |
| `/nuget` | NuGet package management | Package operations and configuration |
| `/readme` | README maintenance | Documentation updates and formatting |

### 🆕 Claude Code Windows 11 Setup
```powershell
.\settings\claude\configure-claude-windows-11.ps1
```
Comprehensive Claude Code optimization script with:
- **PowerShell 7+ Integration**
- **Windows 11 Specific Features**  
- **MCP Server Configuration**
- **Environment Variable Setup**
- **WSL Integration** (optional)

## Advanced Setup Scripts

### 🆕 Azure Integration
```powershell
.\settings\az\setup-azure-service-principal.ps1
```
- **Interactive Azure CLI authentication**
- **Service principal creation** with Contributor role
- **1Password credential storage**
- **Connection testing** and validation

### 🆕 1Password Environment Vault
```powershell
.\settings\1password\setup-environment-vault.ps1
```
- **Secure environment variable management**
- **CLI integration setup**
- **Vault creation and configuration**
- **PowerShell function integration**

## Directory Structure

```
new-windows-dev-pc/
├── install.ps1                    # Enhanced installation script (PowerShell 7+ detection)
├── configure.ps1                  # Interactive configuration wizard (NEW)
├── LICENSE                        # MIT License
├── CLAUDE.md                      # Claude Code guidance (Updated)
├── fonts/
│   └── CascadiaCode.zip           # Developer fonts
├── installs/                     # Installation modules
│   ├── install-winget.ps1         # WinGet installation with fallbacks
│   ├── npm-global.ps1             # Global npm packages
│   ├── vscode.ps1                 # VSCode extensions installer
│   ├── winget.ps1                 # WinGet package installer
│   └── README.md                  # Installation documentation
├── prompts/                       # Development prompts
│   └── npm-global-packages-management.md
└── settings/                      # Configuration files and scripts
    ├── 1password/                 # 1Password integration (NEW)
    │   └── setup-environment-vault.ps1
    ├── az/                        # Azure setup scripts (NEW)
    │   └── setup-azure-service-principal.ps1
    ├── claude/                    # Claude Code configuration (Enhanced)
    │   ├── configure-claude-windows-11.ps1  # Windows 11 setup (NEW)
    │   ├── settings.json          # Claude Code settings
    │   ├── .mcp.json              # MCP configuration
    │   ├── agents/                # 10+ specialized agents
    │   ├── commands/              # 10+ development commands
    │   └── templates/             # Project templates
    ├── git/                       # Git configuration (Enhanced)
    │   ├── configure-git-windows.ps1        # Modular configuration (NEW)
    │   ├── .gitconfig             # Git settings
    │   └── README.md
    ├── markdownlint/              # Markdown linting (NEW)
    │   ├── configure-markdownlint-windows.ps1
    │   └── .markdownlint.json
    ├── npm/                       # NPM configuration
    │   └── global-packages        # Global package list
    ├── nuget/                     # NuGet configuration (NEW)
    │   ├── configure-nuget-windows.ps1
    │   └── NuGet.Config           # Package sources including TailorWell
    ├── pwsh/                      # PowerShell configuration (Enhanced)
    │   ├── configure-pwsh-windows.ps1       # Modular configuration (NEW)
    │   ├── Microsoft.PowerShell_profile.ps1 # Enhanced profile
    │   ├── .theme.omp.json        # Oh My Posh theme
    │   └── 1p-env-vars.ps1        # 1Password integration
    ├── vscode/                    # VSCode configuration (Enhanced)
    │   ├── configure-vscode-windows.ps1     # Modular configuration (NEW)
    │   ├── settings.json          # VSCode settings
    │   ├── keybindings.json       # Key bindings
    │   ├── extensions             # Extension list
    │   └── README.md
    ├── windows-terminal/          # Windows Terminal (Enhanced)
    │   ├── configure-windows-terminal.ps1   # Windows 11 features (NEW)
    │   ├── settings.json          # Terminal configuration
    │   └── README.md
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
| **installs/** | [Installation Scripts README](installs/README.md) | Modular installation, execution order, error handling |
| **settings/claude/** | [Claude Configuration README](settings/claude/README.md) | **10+ agents, commands, Windows 11 setup** |
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
| **Configuration Failures** | Individual tool setup fails | Run specific configuration script: `.\settings\[tool]\configure-*.ps1` |
| **Windows 11 Features** | Enhanced features not available | Ensure Windows 11 and opt-in during configuration |
| **1Password Integration** | Environment variables not working | Run: `.\settings\1password\setup-environment-vault.ps1` |
| **Azure Setup** | Service principal creation fails | Run: `.\settings\az\setup-azure-service-principal.ps1` |

### 🆕 Advanced Troubleshooting

- **Interactive Wizard Issues**: Use `.\configure.ps1 -SkipConfirmation` for automated runs
- **Modular Configuration**: Run individual scripts in `settings/[tool]/configure-*.ps1`  
- **Windows 11 Features**: Disable with `.\configure.ps1` and answer "N" to enhanced features
- **Force Reconfiguration**: Use `.\configure.ps1 -Force` to overwrite existing settings

---

## What's New

### Major Enhancements
- ✅ **Interactive Configuration Wizard** with step-by-step guidance
- ✅ **PowerShell 7+ Requirement** with automatic detection
- ✅ **Windows 11 Enhanced Features** and optimizations
- ✅ **Modular Configuration Architecture** with individual scripts
- ✅ **Developer Mode Detection** for admin-free symbolic links
- ✅ **Claude Code Integration** with 10+ specialized agents
- ✅ **Azure Service Principal Setup** with 1Password integration
- ✅ **1Password Environment Vault** for secure credential management
- ✅ **NuGet Configuration** with TailorWell package sources
- ✅ **Enhanced Error Handling** and user experience

### Updated Components
- ⬆️ **install.ps1**: PowerShell 7+ detection and better elevation
- ⬆️ **configure.ps1**: Complete rewrite with interactive wizard
- ⬆️ **All settings/**: Individual configuration scripts added
- ⬆️ **Documentation**: Updated READMEs with new features

---

**Ready to set up your development environment?** Run `.\install.ps1` followed by `pwsh .\configure.ps1` and follow the interactive wizard!