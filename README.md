# Windows Developer Setup Automation

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://docs.microsoft.com/en-us/powershell/)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-blue.svg)](https://www.microsoft.com/windows/)

A comprehensive Windows developer environment setup automation tool containing PowerShell scripts to install and configure development tools, IDEs, and environments for new developers. Features modular architecture, automatic privilege elevation, and comprehensive configuration management.

## Features

- **Automated Tool Installation**: WinGet-based package management with progress tracking
- **Configuration Management**: Symbolic link-based configuration with centralized settings
- **Modular Architecture**: Separate scripts for different installation components
- **Auto-Elevation**: Scripts automatically request Administrator privileges when needed
- **Claude Code Integration**: Pre-configured AI development assistant with specialized agents
- **Comprehensive Toolchain**: Complete development environment for .NET, Node.js, Azure, and more

## Quick Start

Get your Windows development environment set up in two simple commands:

```powershell
# Install all development tools
.\install.ps1

# Configure settings and create symbolic links
.\configure.ps1
```

**No manual elevation required** - scripts automatically request Administrator privileges when needed.

## Table of Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Installation Overview](#installation-overview)
- [Configuration Management](#configuration-management)
- [Prerequisites](#prerequisites)
- [Usage Guide](#usage-guide)
- [Script Reference](#script-reference)
- [VSCode Extensions](#vscode-extensions)
- [PowerShell Profile Features](#powershell-profile-features)
- [Claude Code Integration](#claude-code-integration)
- [Advanced Usage](#advanced-usage)
- [Troubleshooting](#troubleshooting)
- [Project Structure](#project-structure)
- [Contributing](#contributing)

## Installation Overview

### Core Tools & Utilities

| Tool | Purpose | Package ID |
|------|---------|------------|
| **PowerToys** | Windows system utilities and productivity tools | `Microsoft.PowerToys` |
| **Windows Terminal** | Modern, feature-rich terminal application | `Microsoft.WindowsTerminal` |
| **PowerShell 7+** | Latest cross-platform PowerShell | `Microsoft.PowerShell` |
| **Oh My Posh** | Beautiful, customizable shell prompts | `JanDeDobbeleer.OhMyPosh` |

### Version Control & GitHub

| Tool | Purpose | Package ID |
|------|---------|------------|
| **Git** | Distributed version control system | `Git.Git` |
| **Git LFS** | Large File Storage extension for Git | `GitHub.GitLFS` |
| **GitHub CLI** | Command-line interface for GitHub operations | `GitHub.cli` |

### Development Frameworks

| Tool | Purpose | Package ID |
|------|---------|------------|
| **.NET SDK** | Microsoft development framework | `Microsoft.dotnet` |
| **Fast Node Manager** | Node.js version manager | `Schniz.fnm` |
| **Azure CLI** | Command-line interface for Azure services | `Microsoft.AzureCLI` |
| **Claude AI** | Anthropic's AI development assistant | `Anthropic.Claude` |

### IDEs & Development Environments

| Tool | Purpose | Package ID |
|------|---------|------------|
| **Visual Studio 2022 Professional** | Full-featured .NET IDE with custom workloads | `Microsoft.VisualStudio.2022.Professional` |
| **Visual Studio Code** | Lightweight, extensible code editor | `Microsoft.VisualStudioCode` |
| **VSCode CLI** | Command-line interface for VSCode | `Microsoft.VisualStudioCode.CLI` |
| **SQL Server Management Studio** | SQL Server database administration | `Microsoft.SQLServerManagementStudio` |
| **Azure Data Studio** | Cross-platform database management | `Microsoft.AzureDataStudio.Insiders` |
| **JetBrains Toolbox** | JetBrains IDE manager and installer | `JetBrains.Toolbox` |

### Optional Browser Tools

| Tool | Purpose | Package ID |
|------|---------|------------|
| **Microsoft Edge Beta** | Development browser with latest features | `Microsoft.Edge.Beta` |
| **Chrome Beta** | Development browser with latest features | `Google.Chrome.Beta` |
| **Firefox Developer Edition** | Browser optimized for web development | `Mozilla.Firefox.DeveloperEdition` |

## Configuration Management

The setup uses **symbolic links** to centralize configuration files, making them easy to version control and update. All configuration files are stored in the `settings/` directory and automatically linked to their appropriate system locations.

### Git Configuration
- **Source**: `settings/git/.gitconfig`
- **Target**: `~/.gitconfig`
- **Features**: VSCode as default editor/merge tool, GitHub CLI integration, helpful aliases

### Visual Studio Code
- **Settings**: `settings/vscode/settings.json` → `%APPDATA%\Code\User\settings.json`
- **Keybindings**: `settings/vscode/keybindings.json` → `%APPDATA%\Code\User\keybindings.json`
- **Extensions**: Pre-curated extension list in `settings/vscode/extensions`

### PowerShell Profile
- **Profile**: `settings/pwsh/Microsoft.PowerShell_profile.ps1` → `$PROFILE`
- **Theme**: `settings/pwsh/.theme.omp.json` → `~/.theme.omp.json`
- **Features**: Oh My Posh integration, fnm setup, enhanced aliases, development shortcuts

### Claude Code Integration
- **Settings**: `settings/claude-code/settings.json` → `~/.claude/settings.json`
- **Agents**: `settings/claude/agents/` → `~/.claude/agents`
- **Commands**: `settings/claude/commands/` → `~/.claude/commands`
- **MCP Servers**: `settings/claude/.mcp.json` → `~/.claude/.mcp.json`

### Visual Studio Configuration
- **Workloads**: `settings/visual-studio/.vsconfig` (automatically used by VS installer)

### Development Hosts
- **Custom Domains**: `settings/etc/hosts` appended to system hosts file

## Prerequisites

| Requirement | Details |
|-------------|----------|
| **Operating System** | Windows 10 (version 1903+) or Windows 11 |
| **PowerShell** | PowerShell 5.1+ (included with Windows) |
| **User Account** | Local administrator privileges (scripts handle UAC elevation automatically) |
| **Internet Connection** | Required for downloading packages via WinGet |
| **Disk Space** | ~15GB free space for full installation |

### Optional Requirements

- **Visual Studio License**: Professional license for Visual Studio 2022 Professional
- **JetBrains License**: Valid license for JetBrains IDE usage
- **GitHub Account**: For GitHub CLI authentication and operations

## Usage Guide

### Standard Installation

```powershell
# Complete setup (recommended)
.\install.ps1
.\configure.ps1
```

### Custom Installation Options

```powershell
# Skip WinGet package installation
.\install.ps1 -SkipWinGet

# Skip VSCode extensions
.\install.ps1 -SkipExtensions

# Force overwrite existing configurations
.\configure.ps1 -Force
```

## Script Reference

### Main Scripts

#### `install.ps1` - Main Installation Script

**Purpose**: Installs all development tools and VSCode extensions

**Parameters**:
- `-SkipWinGet` (switch): Skip WinGet and package installation
- `-SkipExtensions` (switch): Skip VSCode extension installation

**Process**:
1. Auto-elevates to Administrator privileges
2. Installs WinGet if not present
3. Installs all development tools via WinGet
4. Installs VSCode extensions from curated list
5. Installs CascadiaCode font for development

#### `configure.ps1` - Configuration Management Script

**Purpose**: Creates symbolic links for all configuration files

**Parameters**:
- `-Force` (switch): Overwrite existing configuration files

**Process**:
1. Auto-elevates to Administrator privileges
2. Creates symbolic links for Git, VSCode, PowerShell configurations
3. Sets up Claude Code agent and command integration
4. Configures MCP server connections
5. Updates system hosts file with development domains

### Component Scripts

Located in the `installs/` directory for modular installation:

#### `installs/winget.ps1` - Package Installation

**Purpose**: Installs development tools via WinGet package manager

**Parameters**:
- `-SkipPackages <string[]>`: Array of package IDs to skip during installation
- `-IncludeBrowsers` (switch): Install optional development browser packages

**Features**:
- Categorized installation with progress tracking
- Individual package error handling and retry logic
- Support for custom installation overrides
- Detailed logging and status reporting

#### `installs/vscode.ps1` - VSCode Extension Management

**Purpose**: Installs VSCode extensions from curated list

**Parameters**:
- `-ExtensionsFile <string>`: Custom path to extensions file (default: `settings/vscode/extensions`)

**Features**:
- Support for comments in extensions file (lines starting with #)
- Progress tracking and error handling per extension
- Automatic VSCode CLI detection and validation
- Detailed installation reporting

#### `installs/install-winget.ps1` - WinGet Bootstrap

**Purpose**: Installs WinGet package manager if not present

**Features**:
- Comprehensive error handling and progress tracking
- Multiple installation methods with automatic fallback
- Automatic cleanup of temporary installation files
- Dependency validation and system compatibility checks

## VSCode Extensions

The setup includes a curated list of VSCode extensions optimized for Windows development. Extensions are defined in `settings/vscode/extensions` and automatically installed.

### Productivity & Navigation
- **GitLens** (`eamodio.gitlens`) - Git supercharging with blame, history, and insights
- **Path Intellisense** (`christian-kohler.path-intellisense`) - Autocomplete for file paths
- **EditorConfig** (`editorconfig.editorconfig`) - Consistent coding styles across editors
- **VSCode Icons** (`vscode-icons-team.vscode-icons`) - File and folder icons

### Development Tools
- **GitHub Copilot** (`github.copilot`) - AI-powered code completion
- **GitHub Copilot Chat** (`github.copilot-chat`) - AI chat assistant for development
- **PowerShell** (`ms-vscode.powershell`) - PowerShell language support
- **C# Dev Kit** (`ms-dotnettools.csdevkit`) - Full C# development experience
- **REST Client** (`humao.rest-client`) - HTTP request testing within VSCode

### Web Development
- **ESLint** (`dbaeumer.vscode-eslint`) - JavaScript/TypeScript linting
- **Prettier** (`esbenp.prettier-vscode`) - Code formatting
- **npm Intellisense** (`christian-kohler.npm-intellisense`) - npm module autocomplete
- **Live Server** (`ms-vscode.live-server`) - Local development server
- **Import Cost** (`wix.vscode-import-cost`) - Display import/require package sizes

### Container & Cloud Development
- **Docker** (`docker.docker`) - Docker container management
- **Remote - Containers** (`ms-vscode-remote.remote-containers`) - Development inside containers
- **Azure Tools** (`ms-azuretools.vscode-containers`) - Azure container development

### Documentation & Markup
- **Markdown Lint** (`davidanson.vscode-markdownlint`) - Markdown linting and style checking
- **Markdown Preview Enhanced** (`shd101wyy.markdown-preview-enhanced`) - Enhanced markdown preview

### Utilities
- **Version Lens** (`pflannery.vscode-versionlens`) - Package version information
- **GitIgnore Generator** (`piotrpalarz.vscode-gitignore-generator`) - Generate .gitignore files
- **dotenv** (`mikestead.dotenv`) - .env file syntax highlighting

### Managing Extensions

```powershell
# Backup currently installed extensions
backup-vs

# Install extensions from list
.\installs\vscode.ps1

# Install from custom extensions file
.\installs\vscode.ps1 -ExtensionsFile "custom-extensions.txt"
```

## PowerShell Profile Features

The PowerShell profile (`settings/pwsh/Microsoft.PowerShell_profile.ps1`) transforms your PowerShell experience with modern features and development-focused utilities.

### Core Integrations

#### Oh My Posh Theme
```powershell
# Beautiful, informative prompt with Git status
oh-my-posh init pwsh --config ~/.theme.omp.json | Invoke-Expression
```

#### Fast Node Manager (fnm)
```powershell
# Automatic Node.js version management
fnm completions --shell powershell | Out-String | Invoke-Expression
fnm env --use-on-cd | Out-String | Invoke-Expression
```

#### Enhanced PSReadLine
```powershell
# Intelligent history and autocomplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
```

### Navigation Shortcuts

| Command | Action | Example |
|---------|--------|---------|
| `~` | Navigate to home directory | `~` |
| `..` | Go up one directory | `..` |
| `....` | Go up two directories | `....` |
| `......` | Go up three directories | `......` |
| `oss` | Navigate to open source projects | `oss my-project` |
| `work` | Navigate to work projects | `work client-project` |

### File Operations (Unix-like)

| Command | PowerShell Equivalent | Purpose |
|---------|----------------------|----------|
| `touch <file>` | `New-Item -ItemType File` | Create empty file |
| `mkdir <dir>` | `New-Item -ItemType Directory` | Create directory |
| `rmdir <dir>` | `Remove-Item -Recurse -Force` | Remove directory |

### Development Utilities

#### `backup-vs` - VSCode Extension Manager
```powershell
# Export currently installed VSCode extensions to extensions file
backup-vs
```
**Features**: Validation, automatic formatting, backup creation

#### `sln` - Smart Solution Opener
```powershell
# Open solution files with intelligent selection
sln                    # List and select from multiple .sln files
sln MyProject         # Open specific solution
```
**Features**: Multi-file selection, fuzzy matching, VSCode integration

#### Search and Discovery
```powershell
which <command>       # Find command location (like Unix which)
grep <pattern> <files> # Search text in files
find <name>           # Find files by name pattern
```

### Customization

The profile is designed for easy customization:
- Modify `settings/pwsh/Microsoft.PowerShell_profile.ps1` for functionality changes
- Edit `settings/pwsh/.theme.omp.json` for prompt appearance
- Changes take effect immediately via symbolic links

## Claude Code Integration

The setup includes comprehensive Claude Code configuration with specialized agents, custom commands, and MCP server integration for enhanced AI-assisted development.

### Specialized Agents

Pre-configured agents for domain-specific development tasks:

| Agent | Command | Purpose |
|-------|---------|----------|
| **readme-maintainer** | `/readme` | Updates and maintains README files with modern best practices |
| **agent-architect** | `/agent-architect` | Designs and creates new specialized agents |
| **azure-devops-specialist** | `/azure-devops` | Azure DevOps pipelines, builds, and project management |
| **dotnet-test-specialist** | `/dotnet-test` | .NET unit testing with MSTest.Sdk and NSubstitute |
| **markdown-specialist** | `/markdown` | Markdown formatting, linting, and validation |
| **csharp-developer** | `/csharp-developer` | C# development patterns and best practices |
| **feature-prompt-specialist** | `/feature-prompt-specialist` | User story and feature requirement analysis |

### MCP Server Integration

Model Context Protocol servers for enhanced development capabilities:

```json
{
  "mcpServers": {
    "context7": "@upstash/context7-mcp",
    "nuget": "@microsoft/nuget-mcp-server",
    "package-search": "@wong2/package-registry-search",
    "dotnet-cli": "@dotnet/mcp-dotnet-cli",
    "filesystem": "@modelcontextprotocol/server-filesystem",
    "git": "@modelcontextprotocol/server-git",
    "azure-devops": "@microsoft/azure-devops-mcp",
    "azure-cli": "@azure/mcp-server",
    "mssql": "@microsoft/mcp-server-mssql"
  }
}
```

### Agent Workflow Integration

**Intelligent Chaining**: Agents automatically call related specialists for comprehensive results:
- `agent-architect` → `readme-maintainer` → `markdown-specialist`
- Ensures consistent documentation and formatting standards
- Reduces manual steps and maintains quality

### Usage Examples

```shell
# Update project documentation
/readme "Update the README with installation and usage instructions"

# Create specialized development agent
/agent-architect "Create an agent for database schema management"

# Set up Azure DevOps pipeline
/azure-devops "Create a CI/CD pipeline for this .NET application"

# Generate unit tests
/dotnet-test "Create unit tests for this service class using MSTest"
```

## Advanced Usage

### Script Parameter Examples

#### Installation Customization
```powershell
# Skip specific installation components
.\install.ps1 -SkipWinGet          # Skip package installation entirely
.\install.ps1 -SkipExtensions      # Skip VSCode extensions only

# Configuration with overrides
.\configure.ps1 -Force              # Overwrite existing configuration files
```

#### Component Script Customization
```powershell
# WinGet installation with options
.\installs\winget.ps1 -IncludeBrowsers -SkipPackages @('Git.Git', 'Microsoft.PowerShell')

# Custom VSCode extension list
.\installs\vscode.ps1 -ExtensionsFile "custom-extensions.txt"

# Install only WinGet (if missing)
.\installs\install-winget.ps1
```

#### Selective Package Installation
```powershell
# Skip packages you already have installed
$skipList = @(
    'Git.Git',                    # Already have Git
    'Microsoft.VisualStudioCode', # Already have VSCode
    'JetBrains.Toolbox'          # Don't need JetBrains tools
)
.\installs\winget.ps1 -SkipPackages $skipList
```

### Customizing VSCode Extensions

#### Method 1: Edit Extensions File
```powershell
# Edit the extensions list directly
notepad settings\vscode\extensions

# Add new extensions (one per line)
# ms-python.python
# ms-vscode.vscode-typescript-next

# Install updated list
.\installs\vscode.ps1
```

#### Method 2: Backup Current Extensions
```powershell
# Export currently installed extensions
backup-vs

# This updates settings/vscode/extensions with your current setup
```

#### Method 3: Custom Extension List
```powershell
# Create custom extensions file
echo "github.copilot`nms-python.python" > my-extensions.txt

# Install from custom file
.\installs\vscode.ps1 -ExtensionsFile "my-extensions.txt"
```

### Environment Customization

#### PowerShell Profile Modification
```powershell
# Edit profile (changes apply immediately via symbolic link)
code settings\pwsh\Microsoft.PowerShell_profile.ps1

# Add custom functions, aliases, or integrations
```

#### Git Configuration Updates
```powershell
# Modify Git settings (applies immediately via symbolic link)
code settings\git\.gitconfig

# Add custom aliases, user settings, or tool configurations
```

#### Oh My Posh Theme Customization
```powershell
# Customize prompt appearance
code settings\pwsh\.theme.omp.json

# Changes take effect on next PowerShell session
```

## Troubleshooting

### Common Issues & Solutions

#### Installation Problems

| Issue | Symptom | Solution |
|-------|---------|----------|
| **UAC Prompt Denied** | Script exits with elevation error | Click "Yes" on UAC prompt, or run PowerShell as Administrator manually |
| **Execution Policy** | "Scripts are disabled on this system" | Scripts automatically use `-ExecutionPolicy Bypass` during elevation |
| **WinGet Not Found** | "winget command not found" | Script automatically installs WinGet using multiple fallback methods |
| **Package Installation Fails** | Specific packages fail to install | Check internet connection, verify package ID, try manual installation |
| **VSCode Extensions Fail** | Extension installation errors | Ensure VSCode is installed and `code` command is in PATH |

#### Configuration Problems

| Issue | Symptom | Solution |
|-------|---------|----------|
| **Symbolic Link Creation Fails** | "Cannot create symbolic link" | Run `configure.ps1` as Administrator, ensure target files exist |
| **Git Config Not Applied** | Git settings not working | Verify symbolic link: `ls -la ~/.gitconfig` |
| **PowerShell Profile Not Loaded** | Custom functions not available | Restart PowerShell, check profile path with `$PROFILE` |
| **Oh My Posh Not Working** | Default prompt shown | Ensure Oh My Posh is installed, check theme file exists |

#### Claude Code Issues

| Issue | Symptom | Solution |
|-------|---------|----------|
| **Agents Not Found** | "Agent not available" | Ensure symbolic links created with `configure.ps1`, restart Claude Code |
| **Commands Not Working** | Custom commands don't respond | Verify `~/.claude/commands` directory exists and contains command files |
| **MCP Servers Not Connected** | MCP functionality unavailable | Check Node.js installation, verify `~/.claude/.mcp.json` exists |

### Manual Recovery Options

#### Complete Manual Installation
```powershell
# Run PowerShell as Administrator, then execute:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
cd "C:\path\to\new-windows-dev-pc"
.\install.ps1
.\configure.ps1
```

#### Individual Component Recovery
```powershell
# Install only WinGet
.\installs\install-winget.ps1

# Install only packages
.\installs\winget.ps1

# Install only VSCode extensions
.\installs\vscode.ps1

# Recreate only configuration links
.\configure.ps1 -Force
```

#### Verification Commands
```powershell
# Check WinGet installation
winget --version

# Verify symbolic links
Get-ChildItem -Path ~ -Force | Where-Object { $_.LinkType -eq "SymbolicLink" }

# Test PowerShell profile
Test-Path $PROFILE

# Verify VSCode extensions
code --list-extensions

# Check Claude Code configuration
Test-Path "~/.claude/settings.json"
```

### Getting Help

- **Windows Issues**: Check Windows Event Viewer for detailed error messages
- **PowerShell Issues**: Run with `-Verbose` flag for detailed output
- **Package Issues**: Check WinGet logs in `%LOCALAPPDATA%\Packages\Microsoft.DesktopInstaller_*\LocalState\DiagOutputDir\`
- **VSCode Issues**: Check VSCode Developer Console (Help → Toggle Developer Tools)

## Project Structure

```
new-windows-dev-pc/
├── install.ps1                    # 🚀 Main installation script (auto-elevates)
├── configure.ps1                  # ⚙️ Configuration management (auto-elevates)
├── README.md                      # 📖 This documentation
├── CLAUDE.md                      # 🤖 Claude Code integration guide
├── fonts/
│   └── CascadiaCode.zip          # 🔤 Development font package
├── installs/                      # 📦 Modular installation scripts
│   ├── install-winget.ps1        # 📥 WinGet package manager installer
│   ├── winget.ps1                # 🛠️ Development tools via WinGet
│   └── vscode.ps1                # 🎨 VSCode extension installer
└── settings/                      # ⚙️ Configuration files (symlinked)
    ├── git/
    │   └── .gitconfig            # 📂 Git configuration with VSCode integration
    ├── visual-studio/
    │   └── .vsconfig             # 🏢 Visual Studio workload configuration
    ├── vscode/
    │   ├── settings.json         # 🎛️ VSCode editor settings
    │   ├── keybindings.json      # ⌨️ Custom keyboard shortcuts
    │   └── extensions            # 📋 Curated extension list
    ├── pwsh/
    │   ├── Microsoft.PowerShell_profile.ps1  # 💻 Enhanced PowerShell profile
    │   └── .theme.omp.json       # 🎨 Oh My Posh theme configuration
    ├── claude/
    │   ├── .mcp.json             # 🔌 MCP server configuration
    │   ├── settings.json         # 🤖 Claude integration settings
    │   ├── agents/               # 🤖 Specialized AI agents
    │   │   ├── README.md         # 📖 Agent documentation
    │   │   ├── agent-architect.md
    │   │   ├── azure-devops-specialist.md
    │   │   ├── csharp-developer.md
    │   │   ├── dotnet-test-specialist.md
    │   │   ├── feature-prompt-specialist.md
    │   │   ├── markdown-specialist.md
    │   │   └── readme-maintainer.md
    │   └── commands/             # ⚡ Quick access commands
    │       ├── agent-architect.md
    │       ├── azure-devops.md
    │       ├── csharp-developer.md
    │       ├── dotnet-test.md
    │       ├── feature-prompt-specialist.md
    │       ├── markdown.md
    │       └── readme.md
    ├── claude-code/
    │   └── settings.json         # 🔧 Claude Code configuration
    └── etc/
        └── hosts                 # 🌐 Development domain mappings
```

### Configuration Flow

1. **Source Files**: All configuration stored in `settings/` directory
2. **Symbolic Links**: `configure.ps1` creates links to system locations
3. **Version Control**: Settings are tracked in Git for easy updates
4. **Centralized Management**: Single source of truth for all configurations

## Contributing

Contributions are welcome! Please follow these guidelines:

### Adding New Tools
1. Add package ID to appropriate section in `installs/winget.ps1`
2. Test installation on clean Windows environment
3. Update documentation in this README
4. Submit pull request with clear description

### Modifying Configurations
1. Edit files in `settings/` directory (never edit symlinked locations directly)
2. Test changes in isolated environment
3. Update documentation if adding new features
4. Ensure configurations work across different Windows versions

### Agent Development
1. Use `/agent-architect` command to create new specialized agents
2. Follow established naming conventions (kebab-case)
3. Include comprehensive documentation and usage examples
4. Test agents thoroughly before submission

### Pull Request Process
1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request with detailed description

---

**Made with ❤️ for Windows developers**

*This automation tool saves hours of manual setup time and ensures consistent, reproducible development environments across teams.*

---

> **💡 Pro Tip**: After running the setup, restart your terminal to ensure all configurations are loaded properly. The symbolic link approach means any changes you make to files in the `settings/` directory will immediately reflect in your development environment!
