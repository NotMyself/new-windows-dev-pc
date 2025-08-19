# Windows Developer Setup Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%2B-0078d4.svg)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Ready-purple.svg)](https://claude.ai/code)

A comprehensive Windows developer setup automation repository containing PowerShell scripts to install and configure development tools, IDEs, and environments for new developers. Features modular installation scripts, symbolic link-based configuration management, and integrated Claude Code setup with 7 specialized agents for enhanced development workflows.

**Key Features:**
- **Automated Tool Installation**: WinGet-based package management with progress tracking
- **Configuration Management**: Symbolic links for centralized settings (Git, VSCode, PowerShell, Claude Code)
- **Developer Fonts**: Cascadia Code font installation for optimal coding experience
- **Claude Code Integration**: 7 specialized agents with intelligent delegation capabilities
- **Modular Architecture**: Separate scripts for different installation components

**Note:** All scripts automatically request Administrator privileges when needed - no need to "Run as Administrator" manually.

## Table of Contents

- [Quick Start](#quick-start)
- [Installed Packages](#installed-packages)
- [Configuration Management](#configuration-management)
- [Claude Code Integration](#claude-code-integration)
- [Documentation Structure](#documentation-structure)
- [Prerequisites](#prerequisites)
- [Detailed Usage](#detailed-usage)
- [PowerShell Profile Features](#powershell-profile-features)
- [Troubleshooting](#troubleshooting)
- [Repository Structure](#repository-structure)

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
   - Configures Claude Code with 7 specialized agents
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
| **Claude Code** | 7 specialized agents and commands | `~/.claude/` |
| **System Hosts** | Custom hosts file entries | `C:\Windows\System32\drivers\etc\hosts` |

### Configuration Benefits

- **Version Control**: All configurations are tracked in Git
- **Consistency**: Same settings across multiple machines
- **Backup**: Configuration changes are automatically backed up
- **Portability**: Easy to replicate development environment
- **Centralized Management**: Update settings in one place

For detailed information about the symbolic link creation process, path validation, and multi-path support, see the [Installation Scripts documentation](installs/README.md#symbolic-link-management).

> **Note**: Git and Visual Studio configurations are referenced in configure.ps1 but the actual configuration files are not included in the repository to avoid overwriting personal settings.

## Prerequisites

- **Windows 10/11** - Modern Windows operating system
- **PowerShell 5.1+** - Included with Windows (PowerShell 7+ will be installed)
- **Administrator Access** - User account with elevation privileges (scripts handle elevation automatically)
- **Internet Connection** - Required for downloading packages and tools

## Detailed Usage

### Main Scripts

#### `.\install.ps1` - Development Tools Installation

**Purpose**: Installs all development tools, fonts, and VSCode extensions

**Parameters**:
- `-SkipWinGet` - Skip WinGet package manager and package installation
- `-SkipExtensions` - Skip VSCode extension installation

**Process**:
1. **WinGet Installation**: Automatically installs WinGet if not present
2. **Tool Installation**: Runs WinGet package installation with progress tracking
3. **Font Installation**: Installs Cascadia Code fonts from `fonts/CascadiaCode.zip`
4. **Extension Installation**: Installs VSCode extensions from curated extensions list

**Example Usage**:
```powershell
# Full installation
.\install.ps1

# Skip package installation, only install extensions
.\install.ps1 -SkipWinGet

# Skip extensions, only install packages
.\install.ps1 -SkipExtensions
```

#### `.\configure.ps1` - Configuration Environment Setup

**Purpose**: Creates symbolic links for all configuration files

**Parameters**:
- `-Force` - Overwrite existing configuration files and directories

**Process**:
1. **Path Validation**: Validates all target paths before creating links
2. **Symbolic Link Creation**: Creates links for VSCode, Windows Terminal, PowerShell, Claude Code
3. **Multi-Path Support**: Handles multiple installation locations (e.g., Windows Terminal standard vs. Store)
4. **System Configuration**: Links hosts file and other system-level configurations

**Example Usage**:
```powershell
# Standard configuration setup
.\configure.ps1

# Force overwrite existing configurations
.\configure.ps1 -Force
```

### Component Scripts

The `installs/` directory contains modular installation scripts for specific components:

#### `winget.ps1` - Package Manager Installation

**Purpose**: Installs development tools and utilities via WinGet package manager

**Parameters**:
- `-SkipPackages` - Array of package IDs to skip during installation
- `-IncludeBrowsers` - Install optional browser packages (Edge Beta, Chrome Beta, Firefox Developer Edition)

**Tool Categories**:
- **Core Development Tools**: .NET SDK, Fast Node Manager (fnm), Azure CLI, Git, Claude AI
- **IDEs and Editors**: Visual Studio 2022 Professional, VSCode, JetBrains Toolbox
- **Database Tools**: SQL Server Management Studio, Azure Data Studio Insiders
- **Windows Tools**: PowerToys, Windows Terminal, PowerShell 7+, Oh My Posh
- **Optional Browsers**: Available with `-IncludeBrowsers` parameter

**Example Usage**:
```powershell
# Install all packages
.\installs\winget.ps1

# Install packages with optional browsers
.\installs\winget.ps1 -IncludeBrowsers

# Skip specific packages
.\installs\winget.ps1 -SkipPackages @("Microsoft.VisualStudio.2022.Professional")
```

#### `vscode.ps1` - VSCode Extensions Installation

**Purpose**: Installs curated VSCode extensions for development

**Parameters**:
- `-ExtensionsFile` - Custom path to extensions file (default: `settings/vscode/extensions`)

**Features**:
- Supports comments in extensions file (lines starting with `#`)
- Progress tracking and error handling per extension
- Automatic retry logic for failed installations
- Integration with `backup-vs` PowerShell function for extension management

#### `install-winget.ps1` - WinGet Bootstrap

**Purpose**: Installs WinGet package manager if not present

**Features**:
- Multiple installation methods with automatic fallback
- Comprehensive error handling and progress tracking
- Automatic cleanup of temporary installation files
- Validation of WinGet installation success


## PowerShell Profile Features

The included PowerShell profile (`settings/pwsh/Microsoft.PowerShell_profile.ps1`) provides a comprehensive enhancement to the PowerShell experience:

### Core Integrations

- **Oh My Posh Prompt**: Custom prompt themes and Git integration (requires `~/.theme.omp.json`)
- **Fast Node Manager (fnm)**: Automatic Node.js version management with completions and auto-use
- **Enhanced PSReadLine**: History prediction, ListView mode, and improved editing experience

### Unix-like Aliases

Common Unix commands mapped to PowerShell equivalents:
```powershell
ls, rm, mv, cp, touch, mkdir, rmdir
```

### Navigation Shortcuts

Quick directory navigation:
```powershell
~         # Navigate to home directory
..        # Go up one directory
....      # Go up two directories  
......    # Go up three directories
oss       # Navigate to open source projects
work      # Navigate to work projects
```

### Enhanced Utility Functions

| Function | Purpose | Usage |
|----------|---------|-------|
| `backup-vs` | Backup currently installed VSCode extensions to extensions file | `backup-vs` |
| `sln` | Smart solution file opener with multi-file selection | `sln [pattern]` |
| `which` | Find command location (Get-Command wrapper) | `which git` |
| `grep` | Search text in files using Select-String | `grep "pattern" *.txt` |
| `find` | Find files by name using Get-ChildItem | `find "*.cs"` |
| `Set-GitUser` | Interactive Git user configuration with auto-detection | `Set-GitUser` |

### Profile Benefits

- **Consistent Experience**: Unix-like commands for cross-platform familiarity
- **Enhanced Productivity**: Smart shortcuts and utility functions
- **Development Focus**: Git integration, solution file management, and extension backup
- **Modern Shell Features**: Improved history, completion, and navigation

## Claude Code Integration

The setup includes comprehensive Claude Code configuration optimized for Windows development workflows with **7 specialized agents** that provide intelligent delegation capabilities and seamless development tool integration.

### Key Features

- **7 Specialized Agents**: Expert agents for Azure DevOps, C# development, testing, documentation, and agent creation
- **Intelligent Delegation**: Sophisticated decision-making frameworks for optimal collaboration between agents
- **PowerShell Integration**: Optimized for Windows development workflows with PowerShell as the default shell
- **Quick Access Commands**: Slash commands (`/readme`, `/csharp`, `/devops`, etc.) for direct agent invocation
- **Workflow Automation**: Seamless integration patterns that prevent duplication and maximize efficiency

### Available Agents

| Agent | Command | Purpose |
|-------|---------|---------|
| **README Maintainer** | `/readme` | Documentation hierarchy management with bottom-up processing |
| **C# Specialist** | `/csharp` | Modern C# development with latest language features |
| **MSTest Specialist** | `/mstest` | .NET unit testing with MSTest.Sdk and NSubstitute |
| **Azure DevOps Specialist** | `/devops` | CI/CD pipelines and Azure DevOps operations |
| **Feature Prompt Specialist** | `/new-feature` | Comprehensive feature specification creation |
| **Markdown Specialist** | `/markdown` | Markdown formatting and linting compliance |
| **Claude Agent Specialist** | `/new-agent` | Meta-agent for creating specialized agents |

### Setup and Usage

After running `.\configure.ps1`, use slash commands for direct access to specialized agents:

```powershell
/readme          # Update README hierarchy with intelligent processing
/csharp          # Modern C# development assistance  
/mstest          # .NET unit testing and test generation
/devops          # Azure DevOps and CI/CD operations
/new-feature     # Create comprehensive feature specifications
/markdown        # Format and lint markdown documents
/new-agent       # Create or improve specialized agents
```

For detailed information about agent capabilities, workflow integration patterns, and advanced usage, see the [complete Claude Code documentation](settings/claude/README.md).

## Documentation Structure

This repository uses a modular documentation approach with component-specific README files:

### Main Documentation
- **[README.md](README.md)** (this file) - Main project overview and quick start guide
- **[CLAUDE.md](CLAUDE.md)** - Comprehensive project architecture and development notes

### Component Documentation
- **[Claude Code Setup](settings/claude/README.md)** - Complete documentation for the 7 specialized agents, workflow integration, and Claude Code configuration
- **[Installation Scripts](installs/README.md)** - Detailed documentation for all installation components and options  
- **[VSCode Configuration](settings/vscode/README.md)** - VSCode settings, extensions, and customization details
- **[PowerShell Profile](settings/pwsh/README.md)** - Enhanced PowerShell profile features and customizations
- **[Windows Terminal](settings/windows-terminal/README.md)** - Terminal configuration and appearance settings
- **[Git Configuration](settings/git/README.md)** - Git setup and configuration details
- **[System Configuration](settings/etc/README.md)** - System-level configuration and hosts file management

Each component README provides detailed setup instructions, configuration options, and usage examples specific to that component. This modular approach ensures you can find detailed information without overwhelming the main README with implementation details.

## Advanced Usage

### Script Parameter Reference

**Main Installation Script**:
```powershell
# Complete installation with all components
.\install.ps1

# Selective installation options
.\install.ps1 -SkipWinGet          # Skip package installation, only fonts and extensions
.\install.ps1 -SkipExtensions      # Skip VSCode extensions, only packages and fonts
```

**Configuration Script**:
```powershell
# Standard configuration setup
.\configure.ps1

# Force overwrite existing configurations
.\configure.ps1 -Force             # Overwrites existing symlinks and directories
```

**Component Script Options**:
```powershell
# WinGet package installation with options
.\installs\winget.ps1 -IncludeBrowsers                    # Include optional browser packages
.\installs\winget.ps1 -SkipPackages @("Microsoft.VisualStudio.2022.Professional")  # Skip specific packages

# VSCode extension installation with custom list
.\installs\vscode.ps1 -ExtensionsFile "custom-extensions.txt"
```

### Symbolic Link Reference

The `configure.ps1` script creates symbolic links from system locations to repository files:

| Component | System Location | Repository Location |
|-----------|-----------------|---------------------|
| **VSCode Settings** | `%APPDATA%\Code\User\settings.json` | `settings/vscode/settings.json` |
| **VSCode Keybindings** | `%APPDATA%\Code\User\keybindings.json` | `settings/vscode/keybindings.json` |
| **Windows Terminal** | `%LOCALAPPDATA%\Microsoft\Windows Terminal\settings.json` | `settings/windows-terminal/settings.json` |
| **Windows Terminal (Store)** | `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json` | `settings/windows-terminal/settings.json` |
| **PowerShell Profile** | `$PROFILE` | `settings/pwsh/Microsoft.PowerShell_profile.ps1` |
| **Claude Settings** | `~/.claude/settings.json` | `settings/claude/settings.json` |
| **Claude Agents** | `~/.claude/agents/` | `settings/claude/agents/` |
| **Claude Commands** | `~/.claude/commands/` | `settings/claude/commands/` |
| **System Hosts** | `C:\Windows\System32\drivers\etc\hosts` | `settings/etc/hosts` |

**Multi-Path Support**: The script automatically detects and creates links for multiple installation paths (e.g., Windows Terminal standard vs. Microsoft Store versions).

### VSCode Extension Management

**Adding/Removing Extensions**:
1. **Manual Edit**: Update `settings/vscode/extensions` file (supports comments with `#`)
2. **Backup Current**: Use `backup-vs` PowerShell function to sync from installed extensions
3. **Install New**: Run `.\installs\vscode.ps1` to install newly added extensions

**Extension File Format**:
```
# Core Extensions
ms-vscode.vscode-typescript-next
ms-vscode.vscode-json

# C# Development
ms-dotnettools.csharp
ms-dotnettools.vscode-dotnet-runtime
```

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

### Manual Recovery

**If Automatic Elevation Fails**:
```powershell
# Open PowerShell as Administrator manually, then navigate to repository:
cd "C:\path\to\new-windows-dev-pc"
.\install.ps1
.\configure.ps1
```

**If WinGet Installation Fails**:
```powershell
# Try installing WinGet manually first:
.\installs\install-winget.ps1
# Then run main installation:
.\install.ps1
```

### Getting Help

**Documentation Resources**:
- **[CLAUDE.md](CLAUDE.md)** - Comprehensive project documentation and architecture
- **Component Documentation** - Detailed README files for each major component:
  - [Claude Code Configuration](settings/claude/README.md) - Complete agent documentation and workflow integration
  - [Installation Scripts](installs/README.md) - Detailed installation component documentation
  - [VSCode Settings](settings/vscode/README.md) - VSCode configuration and extension management
  - [PowerShell Profile](settings/pwsh/README.md) - Enhanced PowerShell profile features
  - [Windows Terminal](settings/windows-terminal/README.md) - Terminal configuration details
- **Script Comments** - Individual script files contain inline documentation
- **PowerShell Help** - Use `Get-Help .\script-name.ps1` for parameter information
- **Claude Code Agents** - Use `/readme` command for documentation assistance

**Log Analysis**:
- Scripts provide timestamped output for troubleshooting
- Check error messages for specific package or configuration failures
- Verify Administrator privileges are granted when prompted

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
    ├── 📁 claude/                    # Claude Code configuration (7 agents + commands)
    │   ├── 📄 README.md              # Claude Code configuration documentation
    │   ├── 📄 settings.json          # Global settings with PowerShell shell configuration
    │   ├── 📁 agents/                # Specialized agent definitions
    │   │   ├── 📄 azure-devops-specialist.md      # Azure DevOps and CI/CD operations
    │   │   ├── 📄 claude-agent-specialist.md      # Meta-agent for creating agents
    │   │   ├── 📄 csharp-specialist.md            # Modern C# development
    │   │   ├── 📄 feature-prompt-specialist.md    # Feature specification creation
    │   │   ├── 📄 markdown-specialist.md          # Markdown formatting and linting
    │   │   ├── 📄 mstest-specialist.md            # .NET unit testing
    │   │   └── 📄 readme-maintainer.md            # Documentation hierarchy management
    │   └── 📁 commands/              # Quick access slash commands
    │       ├── 📄 csharp.md          # /csharp command
    │       ├── 📄 devops.md          # /devops command
    │       ├── 📄 markdown.md        # /markdown command
    │       ├── 📄 mstest.md          # /mstest command
    │       ├── 📄 new-agent.md       # /new-agent command
    │       ├── 📄 new-feature.md     # /new-feature command
    │       └── 📄 readme.md          # /readme command
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
- **Claude Code Integration**: 7 specialized agents with intelligent delegation capabilities
- **Enhanced PowerShell**: Custom profile with modern tooling and Unix-like aliases