# Windows Developer Setup Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%2B-0078d4.svg)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Ready-purple.svg)](https://claude.ai/code)

A comprehensive Windows developer setup automation repository containing PowerShell scripts to install and configure development tools, IDEs, and environments for new developers. Features 7 specialized Claude Code agents with sophisticated delegation intelligence, contextual decision-making frameworks, and hierarchical documentation processing for enhanced development workflows and optimal ecosystem efficiency.

**Note:** These scripts automatically request Administrator privileges when needed - no need to "Run as Administrator" manually.

## Table of Contents

- [Quick Start](#quick-start)
- [Installed Packages](#installed-packages)
- [Configuration Files](#configuration-files)
- [Claude Code Integration](#claude-code-integration)
- [Prerequisites](#prerequisites)
- [Detailed Usage](#detailed-usage)
- [PowerShell Profile Features](#powershell-profile-features)
- [Troubleshooting](#troubleshooting)
- [File Structure](#file-structure)

## Quick Start

1. **Install tools**: Run `.\install.ps1` to install all development tools via WinGet and VSCode extensions
2. **Configure settings**: Run `.\configure.ps1` to create symbolic links for configuration files (Git, VSCode, Windows Terminal, PowerShell, Claude Code)
3. **Claude Code**: 7 specialized agents with sophisticated delegation intelligence and contextual decision-making frameworks are automatically configured for enhanced development workflows, hierarchical documentation processing, and optimal ecosystem efficiency

**💡 Tip**: You can double-click the scripts or run them from any PowerShell prompt - they'll automatically request elevation when needed.

## Installed Packages

### Windows & CLI Tools
- **WinGet** - CLI based Windows package manager
- **PowerToys** - Windows system utilities
- **Windows Terminal** - Modern terminal application with dual-location configuration support
- **PowerShell** - Latest cross-platform PowerShell
- **Oh My Posh** - Custom PowerShell prompts

### Development Environment
- **Git** - Version control system
- **Git LFS** - Large File System for Git
- **GitHub CLI** - Command-line interface for GitHub
- **.NET** - Microsoft development framework
- **fnm** - Fast Node.js version manager
- **Azure CLI** - Command-line interface for Azure
- **Claude** - Anthropic's AI assistant

### IDEs & Editors
- **Visual Studio 2022 Professional** - Full-featured IDE
- **Visual Studio Code** - Lightweight code editor
- **VSCode CLI** - Command-line interface for VSCode
- **Azure Data Studio Insiders** - Database management tool
- **SQL Server Management Studio** - SQL Server administration
- **JetBrains Toolbox** - JetBrains IDE manager

### Optional Browsers (disabled by default)
- **Microsoft Edge Beta** - Available with `-IncludeBrowsers` parameter
- **Google Chrome Beta** - Available with `-IncludeBrowsers` parameter
- **Firefox Developer Edition** - Available with `-IncludeBrowsers` parameter

### Developer Fonts
- **Cascadia Code** - Microsoft's monospaced font optimized for programming and terminal use

## Configuration Files

The setup includes pre-configured settings that get symlinked to your user directories:

- **VSCode**: Settings and keybindings optimized for development
- **Windows Terminal**: Custom terminal configuration
- **PowerShell**: Enhanced profile with Oh My Posh, fnm integration, and Unix-like aliases
- **Extensions**: Curated list of VSCode extensions for development
- **Claude Code**: Global settings with PowerShell shell configuration, specialized agents, and commands
- **Hosts file**: Custom hosts entries in settings/etc/hosts

> **Note**: Git and Visual Studio configurations are referenced in configure.ps1 but the actual configuration files are not included in the repository.

## Prerequisites

- **Windows 10/11** - Modern Windows operating system
- **PowerShell 5.1+** - Included with Windows (PowerShell 7+ will be installed)
- **Administrator Access** - User account with elevation privileges (scripts handle elevation automatically)
- **Internet Connection** - Required for downloading packages and tools

## Detailed Usage

### Main Scripts

- **`.\install.ps1`** - Main installation script with options:
  - `-SkipWinGet` - Skip WinGet and package installation
  - `-SkipExtensions` - Skip VSCode extension installation
  - Automatically installs WinGet if not present
  - Runs tool installation via WinGet with progress tracking
  - Installs Cascadia Code fonts from `fonts/CascadiaCode.zip`
  - Installs VSCode extensions from the curated list

- **`.\configure.ps1`** - Configuration script with options:
  - `-Force` - Overwrite existing configuration files
  - Creates symbolic links for available configuration files (VSCode, Windows Terminal, PowerShell, Claude Code, system hosts)
  - Supports dual-location Windows Terminal configuration (standard and Microsoft Store installations)
  - Enhanced directory removal handling with automatic confirmation bypass
  - Validates paths and provides detailed feedback

### Component Scripts

Located in the `installs/` directory:
- **`winget.ps1`** - Installs development tools via WinGet with options:
  - `-SkipPackages` - Array of package IDs to skip during installation
  - `-IncludeBrowsers` - Install optional browser packages (Edge Beta, Chrome Beta, Firefox Developer Edition)
  - Core development tools (.NET, fnm, Azure CLI, Git, Claude)
  - IDE installations (Visual Studio 2022 Professional, VSCode, JetBrains Toolbox)
  - Database tools (SQL Server Management Studio, Azure Data Studio Insiders)
  - Progress tracking with individual package installation status

- **`vscode.ps1`** - Installs VSCode extensions with options:
  - `-ExtensionsFile` - Custom path to extensions file
  - Supports comments in extensions file
  - Progress tracking and error handling per extension

- **`install-winget.ps1`** - Installs WinGet package manager:
  - Comprehensive error handling and progress tracking
  - Automatic cleanup of temporary files
  - Multiple installation methods with fallback

### Windows Terminal Configuration

- **`settings.json`** - Windows Terminal configuration file:
  - Located in `settings/windows-terminal/settings.json`
  - Supports both standard and Microsoft Store installations with dual symlink approach

## PowerShell Profile Features

The included PowerShell profile provides:
- Oh My Posh prompt integration (requires ~/.theme.omp.json)
- Fast Node Manager (fnm) integration with completions and auto-use
- Enhanced PSReadLine with history prediction and ListView
- Unix-like aliases: `ls`, `rm`, `mv`, `cp`, `touch`, `mkdir`, `rmdir`
- Navigation shortcuts: `~`, `..`, `....`, `......`, `oss`, `work`
- Enhanced utility functions:
  - `backup-vs` - Backup VSCode extensions to the extensions file
  - `sln` - Smart solution file opener with multi-file selection support
  - `which` - Find command location (Get-Command wrapper)
  - `grep` - Search text in files using Select-String
  - `find` - Find files by name using Get-ChildItem
  - `Set-GitUser` - Interactive Git user configuration with auto-detection

## Claude Code Integration

The setup includes comprehensive Claude Code configuration with 7 specialized agents featuring sophisticated delegation intelligence, contextual decision-making frameworks, and development tool integrations:

### Global Settings
- **PowerShell Shell**: Configures Claude Code to use PowerShell instead of bash for better Windows compatibility
- **Permissions**: Pre-configured permissions for common development operations
- **Environment Variables**: Sets `SHELL` and `CLAUDE_SHELL` to PowerShell

### Specialized Agents

The repository includes seven specialized agents with sophisticated delegation intelligence and contextual decision-making frameworks for enhanced development workflows:

#### 🔧 Claude Agent Specialist (`/new-agent`)
**Purpose**: Meta-agent that designs and creates other specialized agents with proper structure, validation, sophisticated delegation intelligence, and best practices for optimal ecosystem integration.

#### ☁️ Azure DevOps Specialist (`/devops`)
**Purpose**: Azure DevOps specialist for pipelines, builds, releases, and project management with intelligent delegation to .NET and testing specialists for technical accuracy and comprehensive CI/CD integration.

#### 📝 README Maintainer (`/readme`)
**Purpose**: Updates and maintains README.md files with depth-first hierarchical processing, nested documentation structures, modern documentation best practices, and intelligent delegation to markdown-specialist for optimal formatting and quality assurance.

#### 💻 C# Specialist (`/csharp`)
**Purpose**: Modern C# development specialist using latest language features, frameworks, and best practices with intelligent delegation to testing specialists for comprehensive test coverage and quality assurance.

#### 🧪 MSTest Specialist (`/mstest`)
**Purpose**: .NET unit testing specialist using MSTest.Sdk and NSubstitute for component testing with intelligent delegation to csharp-specialist for test target analysis and azure-devops-specialist for CI/CD pipeline integration.

#### 📋 Feature Prompt Specialist (`/new-feature`)
**Purpose**: Specialized agent for creating comprehensive, well-structured feature prompts for software development tasks with intelligent delegation to domain specialists for technical accuracy and automatic formatting through markdown-specialist integration.

#### 📝 Markdown Specialist (`/markdown`)
**Purpose**: Creates well-formed, linted markdown documents and reformats existing markdown files following CommonMark and GitHub Flavored Markdown standards with intelligent decision-making for complex formatting scenarios and domain-specific expertise integration.

### Quick Agent Commands

```bash
# Update README with depth-first hierarchical processing
/readme

# Create or improve agents with delegation intelligence
/new-agent

# Azure DevOps operations
/devops

# Modern C# development with latest language features
/csharp

# .NET testing and unit test generation
/mstest

# Create comprehensive feature specifications and requirements
/new-feature

# Format and lint markdown documents
/markdown
```

> **Note**: These commands are available after running `.\configure.ps1` to set up Claude Code integration. Each agent includes sophisticated delegation intelligence and contextual decision-making frameworks to automatically collaborate with other specialists for optimal results and ecosystem efficiency.

### Agent Workflow Integration

The agents are designed to work together as an integrated workflow system with sophisticated delegation intelligence and contextual decision-making frameworks, with each agent capable of calling others using intelligent collaboration patterns to ensure comprehensive, properly formatted, and optimally efficient results:

**Documentation Chain**:
- `readme-maintainer` → `markdown-specialist`: README updates automatically formatted and linted
- `claude-agent-specialist` → `readme-maintainer` → `markdown-specialist`: New agent creation triggers complete documentation update
- `feature-prompt-specialist` → `markdown-specialist`: Feature documentation properly formatted

**Development Chain**:
- `feature-prompt-specialist` → `csharp-specialist`: Requirements analysis followed by modern C# implementation
- `csharp-specialist` → `mstest-specialist`: Code implementation followed by comprehensive unit testing
- `azure-devops-specialist` → `mstest-specialist`: CI/CD pipelines with integrated testing workflows
- `csharp-specialist` → `azure-devops-specialist`: Modern .NET applications with proper CI/CD integration


### Advanced Usage

#### Script Parameters
```powershell
# Install with options
.\install.ps1 -SkipWinGet          # Skip package installation
.\install.ps1 -SkipExtensions      # Skip VSCode extensions

# Configure with options
.\configure.ps1 -Force              # Overwrite existing configs

# Component scripts with options
.\installs\winget.ps1 -IncludeBrowsers     # Install optional browsers
.\installs\winget.ps1 -SkipPackages @("Microsoft.VisualStudio.2022.Professional")  # Skip specific packages
.\installs\vscode.ps1 -ExtensionsFile "custom-extensions.txt"
```

#### Symbolic Link Mappings

The `configure.ps1` script creates the following symbolic links:

**VSCode Configuration:**
- `%APPDATA%\Code\User\settings.json` → `settings/vscode/settings.json`
- `%APPDATA%\Code\User\keybindings.json` → `settings/vscode/keybindings.json`

**Windows Terminal Configuration:**
- `%LOCALAPPDATA%\Microsoft\Windows Terminal\settings.json` → `settings/windows-terminal/settings.json`
- `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json` → `settings/windows-terminal/settings.json` (Store version)

**PowerShell Configuration:**
- `$profile` → `settings/pwsh/Microsoft.PowerShell_profile.ps1`

**Claude Code Configuration:**
- `~/.claude/settings.json` → `settings/claude/settings.json`
- `~/.claude/agents/` → `settings/claude/agents/`
- `~/.claude/commands/` → `settings/claude/commands/`

**System Configuration:**
- `C:\Windows\System32\drivers\etc\hosts` → `settings/etc/hosts`

#### Modifying Extensions

To add or remove VSCode extensions:
1. Edit `settings/vscode/extensions` (supports comments with #)
2. Use the `backup-vs` PowerShell function to update from currently installed extensions
3. Run `.\installs\vscode.ps1` to install new extensions

## Troubleshooting

### Common Issues

- **UAC Prompt**: Scripts automatically request elevation - click "Yes" when prompted
- **Execution Policy**: Scripts use `-ExecutionPolicy Bypass` during elevation
- **WinGet Issues**: Script will try multiple installation methods if primary fails
- **VSCode Extensions**: Check that VSCode is installed and `code` command is in PATH
- **Symbolic Links**: Ensure target files exist before running `configure.ps1`

### Manual Fallback

If automatic elevation fails:

```powershell
# Run PowerShell as Administrator manually, then:
.\install.ps1
.\configure.ps1
```

### Getting Help

For additional assistance:
- Review the detailed [CLAUDE.md](CLAUDE.md) file for comprehensive project documentation
- Check individual script files for inline documentation and comments
- Use PowerShell's `Get-Help` with script files for parameter information

## File Structure

```
├── install.ps1              # Main installation script (auto-elevates)
├── configure.ps1            # Configuration symbolic links (auto-elevates)
├── CLAUDE.md                # Claude Code documentation
├── fonts/
│   └── CascadiaCode.zip     # Developer fonts for installation
├── installs/
│   ├── winget.ps1           # WinGet package installations with browser options
│   ├── vscode.ps1           # VSCode extension installer
│   └── install-winget.ps1   # WinGet installer with error handling
└── settings/
    ├── vscode/
    │   ├── settings.json    # VSCode settings optimized for development
    │   ├── keybindings.json # VSCode keybindings
    │   └── extensions       # Curated extension list
    ├── windows-terminal/
    │   └── settings.json    # Windows Terminal configuration
    ├── claude/
    │   ├── README.md                       # Claude Code configuration documentation
    │   ├── settings.json                   # Claude Code global settings with PowerShell shell
    │   ├── agents/                         # Specialized Claude agents (7 agents)
    │   │   ├── azure-devops-specialist.md  # Azure DevOps operations with delegation intelligence
    │   │   ├── claude-agent-specialist.md  # Meta-agent for creating agents with collaboration patterns
    │   │   ├── csharp-specialist.md        # Modern C# development with testing integration
    │   │   ├── feature-prompt-specialist.md # Feature specification with contextual decision-making
    │   │   ├── markdown-specialist.md      # Markdown formatting and linting specialist
    │   │   ├── mstest-specialist.md        # .NET unit testing with CI/CD integration
    │   │   └── readme-maintainer.md        # Hierarchical README processing with depth-first algorithms
    │   └── commands/                       # Quick access commands for agents (7 commands)
    │       ├── csharp.md                   # /csharp command
    │       ├── devops.md                   # /devops command
    │       ├── markdown.md                 # /markdown command
    │       ├── mstest.md                   # /mstest command
    │       ├── new-agent.md                # /new-agent command
    │       ├── new-feature.md              # /new-feature command
    │       └── readme.md                   # /readme command
    ├── pwsh/
    │   └── Microsoft.PowerShell_profile.ps1  # Enhanced PowerShell profile
    └── etc/
        └── hosts            # Custom hosts file entries
```