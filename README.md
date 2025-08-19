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
| **PowerShell** | Enhanced profile with Oh My Posh | `$PROFILE` |
| **System Hosts** | Custom hosts file entries | `C:\Windows\System32\drivers\etc\hosts` |

### Configuration Benefits

- **Version Control**: All configurations are tracked in Git
- **Consistency**: Same settings across multiple machines
- **Backup**: Configuration changes are automatically backed up
- **Portability**: Easy to replicate development environment
- **Centralized Management**: Update settings in one place

For detailed information about the symbolic link creation process, path validation, and multi-path support, see the [Installation Scripts documentation](installs/README.md#symbolic-link-management).

> **Note**: Git and Visual Studio configurations are referenced in configure.ps1 but the actual configuration files are not included in the repository to avoid overwriting personal settings.



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


## Repository Structure

```
new-windows-dev-pc/
├── 📄 install.ps1                    # Main installation script (auto-elevates)
├── 📄 configure.ps1                  # Configuration symbolic links (auto-elevates)  
├── 📄 README.md                      # This documentation file
├── 📄 CLAUDE.md                      # Claude Code project documentation
│
├── 📁 fonts/
│   └── 📦 CascadiaCode.zip           # Developer fonts for installation
│
├── 📁 installs/                      # Modular installation scripts
│   ├── 📄 README.md               # Installation components documentation
│   ├── 📄 winget.ps1              # WinGet package installations with browser options
│   ├── 📄 vscode.ps1              # VSCode extension installer with progress tracking
│   └── 📄 install-winget.ps1      # WinGet installer with error handling and fallback
│
└── 📁 settings/                      # Configuration files (symlinked to system locations)
    ├── 📁 vscode/
    │   ├── 📄 README.md              # VSCode configuration documentation
    │   ├── 📄 settings.json          # VSCode settings optimized for development
    │   ├── 📄 keybindings.json       # VSCode keybindings and shortcuts
    │   └── 📄 extensions             # Curated VSCode extension list
    │
    ├── 📁 windows-terminal/
    │   ├── 📄 README.md              # Windows Terminal configuration documentation
    │   └── 📄 settings.json          # Windows Terminal configuration
    │
    ├── 📁 claude/                    # Claude Code configuration
    │   ├── 📄 README.md              # Claude Code configuration documentation
    │   ├── 📄 settings.json          # Global settings with PowerShell shell configuration
    │   ├── 📁 agents/                # Specialized agent definitions
    │   └── 📁 commands/              # Quick access slash commands
    │
    ├── 📁 git/
    │   └── 📄 README.md              # Git configuration documentation
    │
    ├── 📁 pwsh/
    │   ├── 📄 README.md              # PowerShell profile documentation
    │   └── 📄 Microsoft.PowerShell_profile.ps1   # Enhanced PowerShell profile
    │
    └── 📁 etc/
        ├── 📄 README.md              # System configuration documentation
        └── 📄 hosts                  # Custom hosts file entries
```

### Key Components

- **Core Scripts**: Main entry points with automatic elevation handling
- **Modular Installs**: Specialized installation scripts for different components  
- **Configuration Management**: Centralized settings with symbolic link automation
- **Enhanced PowerShell**: Custom profile with modern tooling and Unix-like aliases