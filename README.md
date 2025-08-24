# Windows Developer Setup Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%2B-0078d4.svg)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A comprehensive Windows developer setup automation repository containing PowerShell scripts to install and configure development tools, IDEs, and environments for new developers. Features modular installation scripts and symbolic link-based configuration management.

**Key Features:**
- **Automated Tool Installation**: WinGet-based package management with progress tracking
- **Configuration Management**: Symbolic links for centralized settings (Git, VSCode, PowerShell)
- **Developer Fonts**: Cascadia Code font installation for optimal coding experience
- **Modular Architecture**: Separate scripts for different installation components

**Note:** All scripts automatically request Administrator privileges when needed - no need to "Run as Administrator" manually.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Installed Packages](#installed-packages)
- [Configuration Management](#configuration-management)
- [Directory Structure](#directory-structure)
- [Detailed Documentation](#detailed-documentation)
- [Troubleshooting](#troubleshooting)
- [Repository Structure](#repository-structure)

## Prerequisites

- **Windows 10/11** - Modern Windows operating system
- **PowerShell 5.1+** - Included with Windows (PowerShell 7+ will be installed)
- **Administrator Access** - User account with elevation privileges (scripts handle elevation automatically)
- **Internet Connection** - Required for downloading packages and tools

## Quick Start

### Two-Step Setup Process

1. **Install Development Tools**
   ```powershell
   .\install.ps1
   ```
   - Installs WinGet package manager (if not present)
   - Installs development tools, IDEs, and utilities via WinGet
   - Installs Cascadia Code developer fonts
   - Installs curated VSCode extensions

2. **Configure Development Environment**
   ```powershell
   .\configure.ps1
   ```
   - Creates symbolic links for configuration files
   - Sets up Git, VSCode, Windows Terminal, and PowerShell profiles
   - Links custom hosts file and system configurations

### Architecture Overview

This repository uses a **modular architecture** with clear separation of concerns:

- **Core Scripts** (`install.ps1`, `configure.ps1`) - Main entry points with automatic elevation
- **Installation Modules** (`installs/` directory) - Specialized installation scripts for different components
- **Configuration Files** (`settings/` directory) - Centralized settings that get symlinked to user directories
- **Symbolic Link Management** - Configuration files stay in the repository and are linked to system locations

**💡 Tip**: You can run scripts from any PowerShell prompt or double-click them - they automatically request elevation when needed.

## Installed Packages

The setup installs a comprehensive suite of development tools organized by category. All packages are installed via WinGet package manager for consistency and easy updates.

### Windows & CLI Tools

| Package | Description | Purpose |
|---------|-------------|---------|
| **WinGet** | CLI-based Windows package manager | Package installation and management |
| **PowerToys** | Windows system utilities | Enhanced Windows functionality and productivity |
| **Windows Terminal** | Modern terminal application | Enhanced terminal experience with dual-location configuration support |
| **PowerShell** | Latest cross-platform PowerShell | Modern shell with enhanced scripting capabilities |
| **Oh My Posh** | Custom PowerShell prompts | Customizable prompt themes with Git integration |

### Development Environment

| Package | Description | Purpose |
|---------|-------------|---------|
| **Git** | Version control system | Source code management and collaboration |
| **Git LFS** | Large File System for Git | Handling large files in Git repositories |
| **GitHub CLI** | Command-line interface for GitHub | GitHub operations from the command line |
| **.NET** | Microsoft development framework | Cross-platform development runtime and SDK |
| **fnm** | Fast Node.js version manager | Node.js version management and switching |
| **Azure CLI** | Command-line interface for Azure | Azure cloud service management |
| **Claude** | Anthropic's AI assistant | AI-powered development assistance |

### IDEs & Editors

| Package | Description | Purpose |
|---------|-------------|---------|
| **Visual Studio 2022 Professional** | Full-featured IDE | Comprehensive development environment for .NET |
| **Visual Studio Code** | Lightweight code editor | Modern, extensible code editor |
| **VSCode CLI** | Command-line interface for VSCode | VSCode operations from the command line |
| **Azure Data Studio Insiders** | Database management tool | SQL Server and Azure database management |
| **SQL Server Management Studio** | SQL Server administration | Advanced SQL Server database administration |
| **JetBrains Toolbox** | JetBrains IDE manager | Management and installation of JetBrains IDEs |

### Optional Browsers

| Package | Description | Availability |
|---------|-------------|--------------|
| **Microsoft Edge Beta** | Beta version of Microsoft Edge | Available with `-IncludeBrowsers` parameter |
| **Google Chrome Beta** | Beta version of Google Chrome | Available with `-IncludeBrowsers` parameter |
| **Firefox Developer Edition** | Developer-focused Firefox version | Available with `-IncludeBrowsers` parameter |

### Developer Fonts

| Package | Description | Purpose |
|---------|-------------|---------|
| **Cascadia Code** | Microsoft's monospaced font | Optimized for programming and terminal use with ligatures |

## Configuration Management

The setup uses **symbolic links** to centralize configuration management, keeping all settings in the repository while linking them to their expected system locations.

### Included Configuration Files

| Component | Configuration | Target Location |
|-----------|---------------|-----------------|
| **VSCode** | Settings and keybindings | `%APPDATA%\Code\User\` |
| **Windows Terminal** | Terminal configuration | `%LOCALAPPDATA%\Microsoft\Windows Terminal\` |
| **PowerShell** | Enhanced profile with Oh My Posh and 1Password integration | `$PROFILE` |
| **System Hosts** | Custom hosts file entries | `C:\Windows\System32\drivers\etc\hosts` |

### Configuration Benefits

- **Version Control**: All configurations are tracked in Git
- **Consistency**: Same settings across multiple machines
- **Backup**: Configuration changes are automatically backed up
- **Portability**: Easy to replicate development environment
- **Centralized Management**: Update settings in one place

For detailed information about the symbolic link creation process, path validation, and multi-path support, see the [Installation Scripts documentation](installs/README.md#symbolic-link-management).

> **Note**: Git and Visual Studio configurations are referenced in configure.ps1 but the actual configuration files are not included in the repository to avoid overwriting personal settings.

## Directory Structure

The repository is organized into logical directories with specialized functionality:

```
new-windows-dev-pc/
├── README.md                     # This documentation file
├── install.ps1                  # Main installation script
├── configure.ps1                # Configuration setup script
├── installs/                    # Modular installation scripts
│   ├── README.md               # Installation scripts documentation
│   ├── install-winget.ps1      # WinGet package manager installation
│   ├── winget.ps1              # Development tools installation
│   └── vscode.ps1              # VSCode extensions installation
├── settings/                   # Configuration files for symbolic linking
│   ├── claude/                 # Claude Code AI configuration
│   ├── git/                    # Git configuration
│   ├── vscode/                 # VSCode settings and extensions
│   ├── windows-terminal/       # Terminal configuration
│   ├── pwsh/                   # PowerShell profile and themes
│   └── etc/                    # System configuration files
└── fonts/                      # Developer fonts
    └── CascadiaCode.zip        # Cascadia Code font package
```

### Key Directory Summaries

#### Installation Scripts (`installs/`)

Modular PowerShell scripts that handle installation of development tools, IDEs, and environments. Features **3 specialized scripts** with comprehensive error handling and progress tracking:

- **install-winget.ps1**: Installs WinGet package manager with dependencies
- **winget.ps1**: Installs development tools via WinGet (Core Development Tools, IDEs, Database Tools, Windows Tools, Optional Browsers)
- **vscode.ps1**: Installs VSCode extensions from centralized list

**Key Features**: Modular design, individual failure isolation, color-coded output, symbolic link management, multi-path support.

#### Settings Directory (`settings/`)

Centralized configuration files that get symlinked to system locations, providing version-controlled settings management:

##### Claude Code Configuration (`settings/claude/`)

Complete Claude Code configuration with **7 specialized agents** and **7 slash commands** for Windows development workflows:

- **Specialized Agents**: claude-agent-specialist (meta-agent creation), azure-devops-specialist (CI/CD pipelines), csharp-specialist (modern C# development), mstest-specialist (.NET unit testing), feature-prompt-specialist (requirements engineering), markdown-specialist (formatting/linting), readme-maintainer (hierarchical README processing)
- **Integration**: PowerShell as default shell, sophisticated delegation intelligence between agents, integrated workflow patterns
- **Commands**: Direct slash command access (`/readme`, `/csharp`, `/devops`, `/mstest`, `/new-agent`, `/new-feature`, `/markdown`)

##### Git Configuration (`settings/git/`)

Centralized Git configuration with VSCode integration, helpful aliases, and modern Git workflow defaults:

- **Key Features**: VSCode as default editor and merge/diff tool, Git LFS support, GitHub CLI authentication, `cm` alias for quick commits
- **Integration**: Seamless VSCode integration for editing, merging, and diffing operations

##### VSCode Configuration (`settings/vscode/`)

Comprehensive Visual Studio Code configuration with **31 extensions** optimized for modern development:

- **Visual Experience**: Cascadia Code fonts with ligatures, optimized sizing, enhanced readability
- **Extension Categories**: Development Core (8), Git & Version Control (4), Microsoft Development (6), Cloud & Containers (5), Documentation & Markdown (3), AI & Productivity (2), Utilities (3)
- **Key Tools**: Prettier for formatting, GitLens for Git visualization, GitHub Copilot for AI assistance, PowerShell 7 integration

##### Windows Terminal Configuration (`settings/windows-terminal/`)

Optimized terminal settings with enhanced themes, typography, and productivity-focused keybindings:

- **Visual Design**: CaskaydiaCove Nerd Font for programming ligatures, One Half Dark theme, enhanced productivity keybindings
- **Performance**: 95% opacity, disabled acrylic effects for better performance
- **Profiles**: PowerShell (default), Azure Cloud Shell, Command Prompt visible; legacy profiles hidden

##### PowerShell Configuration (`settings/pwsh/`)

Comprehensive PowerShell configuration with modern tooling and developer productivity features:

- **Core Features**: Oh My Posh theme with development context awareness, Unix-like aliases, 1Password integration for secure environment variable management
- **Developer Functions**: Project navigation (`oss`/`work`), Visual Studio integration (`sln`), VSCode extension backup (`backup-vs`), Git configuration (`Set-GitUser`), 1Password env vars (`Set-1PEnvVar`)
- **Integration**: Tool integration with Node.js/fnm/Git/Azure CLI, cross-platform compatibility

##### System Configuration (`settings/etc/`)

Windows hosts file management for local development, testing, and network configuration:

- **Use Cases**: Local development environments, staging testing, website blocking, internal network services, container/VM development
- **Best Practices**: Organized commenting, consistent naming conventions (`.local`, `.dev.local`, `.staging.local`), DNS cache management

## Detailed Documentation

Each directory contains comprehensive README documentation with detailed setup instructions, usage examples, and troubleshooting guides:

| Directory | Documentation | Key Topics |
|-----------|---------------|------------|
| **installs/** | [Installation Scripts README](installs/README.md) | Modular installation scripts, execution order, error handling, symbolic link management |
| **settings/claude/** | [Claude Configuration README](settings/claude/README.md) | 7 specialized agents, slash commands, delegation intelligence, workflow integration |
| **settings/git/** | [Git Configuration README](settings/git/README.md) | VSCode integration, aliases, workflow best practices, troubleshooting |
| **settings/vscode/** | [VSCode Configuration README](settings/vscode/README.md) | 31 extensions, productivity features, customization, troubleshooting |
| **settings/windows-terminal/** | [Terminal Configuration README](settings/windows-terminal/README.md) | Theme configuration, keybindings, profile management, integration |
| **settings/pwsh/** | [PowerShell Configuration README](settings/pwsh/README.md) | Oh My Posh themes, 1Password integration, developer functions, customization |
| **settings/etc/** | [Hosts File Management README](settings/etc/README.md) | Hosts file syntax, use cases, best practices, security considerations |

### Claude Code Integration

This repository includes a complete Claude Code configuration with sophisticated agent delegation patterns:

- **Quick README Updates**: Use `/readme` for hierarchical documentation processing with intelligent summarization
- **Agent Creation**: Use `/new-agent` for creating new specialized agents with delegation intelligence
- **Development Workflows**: Use `/csharp`, `/devops`, `/mstest` for modern development tasks with automatic sub-agent collaboration
- **Documentation**: Use `/markdown` and `/new-feature` for comprehensive documentation and requirements engineering



## Troubleshooting

### Common Issues and Solutions

| Issue | Symptoms | Solution |
|-------|----------|----------|
| **UAC Elevation** | Scripts fail to run with permissions error | Click "Yes" when UAC prompt appears (automatic elevation) |
| **Execution Policy** | PowerShell blocks script execution | Scripts use `-ExecutionPolicy Bypass` during elevation |
| **WinGet Installation** | Package installation fails | Script tries multiple installation methods with fallback |
| **VSCode Extensions** | Extensions fail to install | Verify VSCode is installed and `code` command is in PATH |
| **Symbolic Link Creation** | Configuration linking fails | Ensure target files exist in `settings/` directory |
| **Path Not Found** | Scripts can't find components | Run scripts from repository root directory |
