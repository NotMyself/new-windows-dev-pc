# Windows Developer Setup Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE.svg?logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%2B-0078d4.svg?logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![WinGet](https://img.shields.io/badge/WinGet-Package%20Manager-0078d4.svg?logo=microsoft&logoColor=white)](https://github.com/microsoft/winget-cli)
[![Visual Studio Code](https://img.shields.io/badge/VSCode-Extensions%20Included-007ACC.svg?logo=visual-studio-code&logoColor=white)](https://code.visualstudio.com/)
[![Git](https://img.shields.io/badge/Git-Configuration%20Included-F05032.svg?logo=git&logoColor=white)](https://git-scm.com/)
[![Node.js](https://img.shields.io/badge/Node.js-via%20fnm-339933.svg?logo=node.js&logoColor=white)](https://nodejs.org/)
[![.NET](https://img.shields.io/badge/.NET-Included-512BD4.svg?logo=.net&logoColor=white)](https://dotnet.microsoft.com/)
[![Azure](https://img.shields.io/badge/Azure-CLI%20Included-0078d4.svg?logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?logo=open-source-initiative&logoColor=white)](LICENSE)
[![Automation](https://img.shields.io/badge/Automation-Developer%20Setup-FF6B35.svg?logo=automate&logoColor=white)](#)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen.svg?logo=github-actions&logoColor=white)](#)

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

The setup installs a comprehensive suite of development tools via WinGet package manager for consistency and easy updates:

| Category | Package | Description | Notes |
|----------|---------|-------------|-------|
| **Package Management** | WinGet | CLI-based Windows package manager | Core dependency installer |
| **Windows & CLI Tools** | PowerToys | Windows system utilities | Enhanced Windows functionality |
| | Windows Terminal | Modern terminal application | Dual-location configuration support |
| | PowerShell | Latest cross-platform PowerShell | Modern shell with enhanced scripting |
| | Oh My Posh | Custom PowerShell prompts | Customizable themes with Git integration |
| **Development Environment** | Git | Version control system | Source code management |
| | Git LFS | Large File System for Git | Handling large files in repositories |
| | GitHub CLI | Command-line interface for GitHub | GitHub operations from command line |
| | .NET | Microsoft development framework | Cross-platform development runtime |
| | fnm | Fast Node.js version manager | Node.js version management |
| | Azure CLI | Command-line interface for Azure | Azure cloud service management |
| | Claude | Anthropic's AI assistant | AI-powered development assistance |
| **IDEs & Editors** | Visual Studio 2022 Professional | Full-featured IDE | Comprehensive .NET development |
| | Visual Studio Code | Lightweight code editor | Modern, extensible editor |
| | VSCode CLI | Command-line interface for VSCode | VSCode operations from command line |
| | Azure Data Studio | Database management tool | SQL Server and Azure databases |
| | SQL Server Management Studio | SQL Server administration | Advanced database administration |
| | JetBrains Toolbox | JetBrains IDE manager | Management of JetBrains IDEs |
| **Optional Browsers** | Microsoft Edge Beta | Beta version of Microsoft Edge | Requires `-IncludeBrowsers` parameter |
| | Google Chrome Beta | Beta version of Google Chrome | Requires `-IncludeBrowsers` parameter |
| | Firefox Developer Edition | Developer-focused Firefox | Requires `-IncludeBrowsers` parameter |
| **Developer Fonts** | Cascadia Code | Microsoft's monospaced font | Programming ligatures and terminal optimization |

## Configuration Management

The setup uses **symbolic links** to centralize configuration management, keeping all settings in the repository while linking them to their expected system locations.

### Included Configuration Files

| Component | Configuration | Target Location |
|-----------|---------------|-----------------|
| **Git** | Global Git configuration | `~/.gitconfig` |
| **VSCode** | Settings and keybindings | `%APPDATA%\Code\User\settings.json` and `keybindings.json` |
| **PowerShell** | Enhanced profile with Oh My Posh and 1Password integration | `$PROFILE` |
| **Oh My Posh** | Custom theme configuration | `~/.theme.omp.json` |
| **Windows Terminal** | Terminal configuration (dual-location support) | `%LOCALAPPDATA%\Microsoft\Windows Terminal\settings.json` |
| **Claude Code** | AI assistant settings, agents, and commands | `~/.claude/` directory |
| **Markdownlint** | Markdown linting rules | `~/.markdownlint.json` |
| **System Hosts** | Custom hosts file entries | `C:\Windows\System32\drivers\etc\hosts` |

### Configuration Benefits

- **Version Control**: All configurations are tracked in Git
- **Consistency**: Same settings across multiple machines
- **Backup**: Configuration changes are automatically backed up
- **Portability**: Easy to replicate development environment
- **Centralized Management**: Update settings in one place

For detailed information about the symbolic link creation process, path validation, and multi-path support, see the [Installation Scripts documentation](installs/README.md#symbolic-link-management).

> **Note**: Git and Visual Studio configurations are referenced in configure.ps1 but the actual configuration files are not included in the repository to avoid overwriting personal settings.


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
