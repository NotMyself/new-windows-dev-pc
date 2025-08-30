# Windows Developer Setup Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-7%2B-5391FE.svg?logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-0078d4.svg?logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![WSL](https://img.shields.io/badge/WSL-Ubuntu%2022.04-FF7F00.svg?logo=ubuntu&logoColor=white)](https://docs.microsoft.com/en-us/windows/wsl/)
[![WinGet](https://img.shields.io/badge/WinGet-Package%20Manager-0078d4.svg?logo=microsoft&logoColor=white)](https://github.com/microsoft/winget-cli)
[![Visual Studio Code](https://img.shields.io/badge/VSCode-31%2B%20Extensions-007ACC.svg?logo=visual-studio-code&logoColor=white)](https://code.visualstudio.com/)
[![Git](https://img.shields.io/badge/Git-Configuration%20Included-F05032.svg?logo=git&logoColor=white)](https://git-scm.com/)
[![Node.js](https://img.shields.io/badge/Node.js-via%20fnm-339933.svg?logo=node.js&logoColor=white)](https://nodejs.org/)
[![.NET](https://img.shields.io/badge/.NET-SDK%20Included-512BD4.svg?logo=.net&logoColor=white)](https://dotnet.microsoft.com/)
[![Azure](https://img.shields.io/badge/Azure-CLI%20%26%20DevOps-0078d4.svg?logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Claude Code](https://img.shields.io/badge/Claude-9%2B%20AI%20Agents-FF6B35.svg?logo=anthropic&logoColor=white)](https://claude.ai/code)
[![1Password](https://img.shields.io/badge/1Password-Secure%20Secrets-0094F5.svg?logo=1password&logoColor=white)](https://1password.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?logo=open-source-initiative&logoColor=white)](LICENSE)

A comprehensive Windows developer setup automation repository featuring **PowerShell 7+**, **Windows 11** optimizations, and **mandatory WSL integration**. Provides streamlined two-step installation, automated tool deployment, and **Claude Code integration** with 9+ specialized AI agents for modern development workflows.

## 🚀 Key Features

- **⚡ Two-Step Setup**: Simple `install.ps1` → `configure.ps1` process
- **🐧 Mandatory WSL Integration**: Ubuntu 22.04 development environment 
- **🤖 9 Claude Code AI Agents**: Specialized experts for domain-specific development
- **📦 30+ Development Tools**: Automated WinGet package installation
- **🔐 1Password Integration**: Secure credential and environment variable management
- **💻 Professional IDE Setup**: VSCode (31+ extensions) + Visual Studio 2022 Professional
- **🎨 Enhanced Terminal Experience**: Windows Terminal + PowerShell 7 + Oh My Posh themes
- **🔗 Symbolic Link Management**: Centralized configuration with live updates

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Installation and Setup](#installation-and-setup)
- [Architecture and Components](#architecture-and-components)
- [Configuration Details](#configuration-details)
- [Claude Code Integration](#claude-code-integration)
- [Usage Examples](#usage-examples)
- [Directory Structure](#directory-structure)
- [Troubleshooting](#troubleshooting)
- [Contributing Guidelines](#contributing-guidelines)

## 🔧 Prerequisites

| Requirement | Details | Installation |
|-------------|---------|--------------|
| **Windows 10/11** | Windows 11 recommended for enhanced features | Pre-installed |
| **Administrator Access** | Required for system-level installations | Scripts handle elevation automatically |
| **PowerShell 7+** | Modern cross-platform PowerShell | Auto-installed if missing |
| **Internet Connection** | Required for package downloads | Ensure stable connection |
| **Developer Mode** | Optional but recommended for symbolic links | Settings → For developers |

## 🚀 Installation and Setup

### Two-Step Setup Process

#### Step 1: Install Development Tools & WSL Environment
```powershell
# Run as Administrator (auto-elevation handled)
.\install.ps1
```

**What this installs:**
- ✅ **WinGet Package Manager** - Windows package management with comprehensive error handling
- ✅ **30+ Development Tools** - IDEs, utilities, and development environments via WinGet
- ✅ **WSL Environment** - Ubuntu 22.04 with Node.js, .NET SDK, Azure CLI, 1Password CLI
- ✅ **Cascadia Code Fonts** - Programming fonts with ligatures and registry integration
- ✅ **VSCode Extensions** - 31+ curated extensions for full-stack development
- ✅ **Global NPM Packages** - Essential development packages via Fast Node Manager (fnm)

#### Step 2: Configure Complete Development Environment
```powershell
# Interactive configuration wizard
.\configure.ps1
```

**What this configures:**
- ✅ **Claude Code for WSL** - Bash shell optimization with development tools
- ✅ **1Password Integration** - Secure environment variables for Windows and WSL
- ✅ **Git Identity Management** - Separate identities for user and Claude Code commits
- ✅ **Symbolic Link Creation** - Centralized configuration management
- ✅ **PowerShell Profile** - Oh My Posh themes and productivity functions
- ✅ **Interactive Guidance** - Step-by-step explanations and confirmations

### Advanced Configuration Options

```powershell
# Automated deployment (skip confirmations)
.\configure.ps1 -SkipConfirmation

# Force overwrite existing configurations
.\configure.ps1 -Force

# Selective installation options
.\install.ps1 -SkipWinGet          # Skip package installation
.\install.ps1 -SkipExtensions      # Skip VSCode extensions
.\install.ps1 -SkipNpmPackages     # Skip global npm packages
```

## 🏗️ Architecture and Components

### Development Stack Overview

| Layer | Windows Environment | WSL Environment |
|-------|-------------------|------------------|
| **Shell** | PowerShell 7 with Oh My Posh | Bash with development tools |
| **Terminal** | Windows Terminal with themes | WSL terminal integration |
| **Development** | Visual Studio 2022 Professional | .NET SDK, Node.js |
| **Code Editor** | VSCode with 31+ extensions | WSL extension integration |
| **AI Assistant** | Claude Code with 9 agents | Bash-optimized Claude Code |
| **Package Management** | WinGet, Chocolatey | APT, NPM |
| **Version Control** | Git with VSCode integration | Git with Claude Code identity |
| **Credential Management** | 1Password CLI | 1Password WSL integration |

### WSL Development Environment

The **mandatory WSL integration** provides a comprehensive Linux development environment:

#### System Tools
- **Node.js LTS**: Latest stable version via NodeSource repository
- **.NET SDK**: Microsoft .NET development platform for cross-platform development
- **Azure CLI**: Complete Azure command-line tools and authentication
- **1Password CLI**: Secure credential retrieval and environment variable management

#### Development Tools
- **Essential NPM Packages**: prettier, markdownlint-cli, typescript, eslint
- **Build Tools**: make, build-essential, curl, wget, git
- **Claude Code Integration**: Bash shell with tool permissions and environment optimization

### Installed Package Categories

| Category | Tools | Count | Notes |
|----------|-------|--------|-------|
| **Windows & CLI** | PowerToys, Windows Terminal, PowerShell 7, Oh My Posh | 4 | Enhanced Windows functionality |
| **Development Environment** | Git, Git LFS, GitHub CLI, .NET SDK, fnm, Azure CLI, Claude | 7 | Core development runtime |
| **IDEs & Editors** | Visual Studio 2022 Pro, VSCode, SSMS, Azure Data Studio, JetBrains Toolbox | 5 | Complete IDE ecosystem |
| **Package Management** | WinGet (auto-installed) | 1 | Package management foundation |
| **Fonts** | Cascadia Code with registry integration | 1 | Programming fonts with ligatures |
| **VSCode Extensions** | 31+ curated extensions | 31+ | Full-stack development support |
| **Global NPM Packages** | TypeScript, ESLint, Prettier, Markdownlint, Live Server | 5+ | Essential development tools |

## ⚙️ Configuration Details

### Centralized Configuration Management

The setup creates symbolic links from system locations to repository files, enabling:
- **Live Configuration Updates**: Changes to repository files immediately affect system settings
- **Version Control Integration**: All configuration changes tracked in Git
- **Multi-Machine Consistency**: Same configurations across different development environments
- **Easy Restoration**: Simple repository checkout restores all settings

### Configuration Components

| Component | Target Location | Repository Source | Features |
|-----------|----------------|-------------------|----------|
| **Git Configuration** | `~/.gitconfig` | `settings/git/.gitconfig` | VSCode integration, helpful aliases |
| **VSCode Settings** | `%APPDATA%\Code\User\` | `settings/vscode/` | Settings, keybindings, 31+ extensions |
| **PowerShell Profile** | `$PROFILE` | `settings/pwsh/Microsoft.PowerShell_profile.ps1` | Enhanced profile with 1Password |
| **Oh My Posh Theme** | `~/.theme.omp.json` | `settings/pwsh/.theme.omp.json` | Developer-focused prompt theme |
| **Windows Terminal** | Multiple locations | `settings/windows-terminal/settings.json` | Windows 11 optimizations |
| **Claude Code** | `~/.claude/` | `settings/claude/` | WSL-optimized configuration |
| **Hosts File** | `C:\Windows\System32\drivers\etc\hosts` | `settings/etc/hosts` | Network configuration |

### Enhanced Configuration Features

- **Multi-Path Support**: Automatically detects Windows Terminal installation methods (standard vs. Microsoft Store)
- **Developer Mode Detection**: Uses symbolic links without Administrator privileges when enabled
- **Backup Management**: Creates backups before overwriting existing configurations
- **Error Recovery**: Comprehensive error handling with clear recovery instructions
- **Interactive Guidance**: Step-by-step configuration with detailed explanations

## 🤖 Claude Code Integration

### 9 Specialized AI Agents

The repository includes comprehensive Claude Code configuration with domain-specific agents:

| Agent | Specialization | Key Capabilities |
|-------|----------------|------------------|
| **🔧 azure-devops** | Azure DevOps operations | Sprint management, YAML pipelines, work item lifecycle, API integration |
| **⚡ csharp** | Modern C# development | C# 12+ features, .NET 8+ frameworks, clean architecture, SOLID principles |
| **📝 markdown** | Documentation creation | CommonMark standards, Azure DevOps wiki compatibility, automated formatting |
| **🧪 mstest** | .NET unit testing | MSTest.Sdk, NSubstitute patterns, test coverage, CI/CD integration |
| **⚙️ command-expert** | CLI development | Command design patterns, argument parsing, automation scripting |
| **🏗️ agent-expert** | Agent creation | Agent architecture, prompt engineering, integration patterns |
| **📋 feature-prompt** | Feature development | Requirements engineering, acceptance criteria, stakeholder communication |
| **🔌 mcp-expert** | Model Context Protocol | MCP server configuration, protocol compliance, custom development |
| **📚 readme-maintainer** | Documentation management | Hierarchical README updates, bottom-up processing, cross-reference validation |

### WSL-Optimized Configuration

The Claude Code setup is optimized for WSL development:

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

### MCP Server Configuration

Modern MCP servers configured for enhanced functionality:
- **filesystem**: File operations with directory access controls
- **memory**: Persistent conversation context and memory management
- **sequential-thinking**: Structured reasoning and problem-solving workflows
- **context7**: Advanced context management and intelligent retrieval

## 📚 Usage Examples

### Common Development Workflows

#### Setting Up a New Project
```powershell
# Navigate to your project directory
oss my-new-project

# Use Claude Code to initialize project structure
# Claude Code will automatically use appropriate agents based on project type

# Open in VSCode with all extensions and configuration
code .

# Start development with all tools configured
```

#### PowerShell Profile Features
```powershell
# Quick navigation functions
oss [subdir]              # Navigate to ~/src/oss/[subdir]
work [subdir]             # Navigate to ~/src/ofm/[subdir]

# Visual Studio integration
sln                       # Open solution file in current directory

# VSCode extension management
backup-vs                 # Export currently installed extensions to repository

# Git configuration
Set-GitUser               # Interactive Git user configuration

# 1Password integration
Set-1PEnvVar -Key "API_KEY" -Value "secret123"  # Secure environment variable storage
```

#### Claude Code Agent Usage
```powershell
# Agents automatically activate based on context and task
# Examples of agent specialization:

# C# development tasks → csharp agent
# Azure DevOps operations → azure-devops agent
# Documentation tasks → markdown agent
# Unit testing → mstest agent
# README management → readme-maintainer agent
```

### Advanced Setup Scripts

#### Azure Service Principal Setup
```powershell
.\settings\az\setup-azure-service-principal.ps1
```
- Interactive Azure CLI authentication and connection
- Service principal creation with Contributor role assignment
- 1Password credential storage for secure environment variables
- Connection testing and validation with detailed feedback

#### 1Password Environment Vault
```powershell
.\settings\1password\setup-environment-vault.ps1
```
- Secure environment variable management across Windows and WSL
- CLI integration setup with service account configuration
- Vault creation and permission management
- PowerShell and WSL integration for seamless access

## 📁 Directory Structure

```
new-windows-dev-pc/
├── 📄 install.ps1                         # Main installation script
├── 📄 configure.ps1                       # Configuration script  
├── 📄 LICENSE                             # MIT License
├── 📄 CLAUDE.md                           # Claude Code guidance
├── 📂 fonts/
│   └── 📦 CascadiaCode.zip               # Developer fonts with ligatures
├── 📂 installs/                          # Installation modules
│   ├── 📄 install-winget.ps1             # WinGet installation with fallbacks
│   ├── 📄 npm-global.ps1                 # Global npm packages
│   ├── 📄 vscode.ps1                     # VSCode extensions installer  
│   ├── 📄 winget.ps1                     # WinGet package installer
│   ├── 📄 wsl-tools.sh                   # WSL development environment
│   └── 📋 README.md                      # Installation documentation
├── 📂 prompts/                           # Development workflow prompts
│   └── 📄 npm-global-packages-management.md
└── 📂 settings/                          # Configuration files and scripts
    ├── 📂 1password/                     # Secure credential management
    │   └── 📄 setup-environment-vault.ps1
    ├── 📂 az/                            # Azure integration scripts
    │   └── 📄 setup-azure-service-principal.ps1
    ├── 📂 claude/                        # Claude Code configuration
    │   ├── 📄 configure-claude-windows-11.ps1  # Setup script
    │   ├── ⚙️ settings.json              # Windows configuration
    │   ├── ⚙️ settings-wsl.json          # WSL-optimized configuration
    │   ├── 📂 agents/                    # 9 specialized AI agents
    │   ├── 📂 config/                    # Configuration files
    │   ├── 📂 templates/                 # Project templates
    │   └── 📋 README.md                  # Claude Code documentation
    ├── 📂 etc/                           # System configuration
    │   ├── 📄 hosts                      # Network hosts configuration
    │   └── 📋 README.md                  # Hosts file management guide
    ├── 📂 git/                           # Git configuration
    │   ├── 📄 configure-git-windows.ps1  # Configuration script
    │   ├── ⚙️ .gitconfig                # Git settings with VSCode integration
    │   └── 📋 README.md                  # Git configuration guide
    ├── 📂 markdownlint/                  # Markdown linting
    │   ├── 📄 configure-markdownlint-windows.ps1
    │   └── ⚙️ .markdownlint.json        # Linting rules
    ├── 📂 npm/                           # NPM configuration
    │   └── 📄 global-packages            # Global package list
    ├── 📂 nuget/                         # NuGet configuration
    │   ├── 📄 configure-nuget-windows.ps1
    │   └── ⚙️ NuGet.Config               # Package sources
    ├── 📂 pwsh/                          # PowerShell configuration
    │   ├── 📄 configure-pwsh-windows.ps1 # Configuration script
    │   ├── ⚙️ Microsoft.PowerShell_profile.ps1  # Enhanced profile
    │   ├── 🎨 .theme.omp.json           # Oh My Posh theme
    │   ├── 📄 1p-env-vars.ps1            # 1Password integration
    │   └── 📋 README.md                  # PowerShell configuration guide
    ├── 📂 vscode/                        # VSCode configuration
    │   ├── 📄 configure-vscode-windows.ps1  # Configuration script
    │   ├── ⚙️ settings.json              # VSCode settings
    │   ├── ⚙️ keybindings.json           # Custom keybindings
    │   ├── 📄 extensions                 # Extension list (31+)
    │   └── 📋 README.md                  # VSCode configuration guide
    ├── 📂 windows-terminal/               # Windows Terminal configuration
    │   ├── 📄 configure-windows-terminal.ps1  # Configuration script
    │   ├── ⚙️ settings.json              # Terminal configuration
    │   └── 📋 README.md                  # Terminal configuration guide
    ├── 📂 wsl/                           # WSL-specific configuration
    │   ├── 📄 configure-1password-wsl.sh # 1Password CLI setup for WSL
    │   └── 📄 1p-env-vars.sh             # Environment variable loading
    └── 📂 visual-studio/                 # Visual Studio configuration
        └── ⚙️ .vsconfig                  # Workload configuration
```

## 🔍 Troubleshooting

### Common Issues and Solutions

| Issue | Symptoms | Solution | Prevention |
|-------|----------|----------|------------|
| **PowerShell Version** | Configuration script won't run | Install PowerShell 7+ or run `pwsh .\configure.ps1` | Use `$PSVersionTable` to check version |
| **Developer Mode** | Symbolic link creation fails | Enable in Settings → For developers | Enable before running scripts |
| **UAC Elevation** | Scripts fail with permissions | Click "Yes" when UAC prompt appears | Run PowerShell as Administrator |
| **WSL Not Installed** | WSL setup fails | Enable WSL feature, restart computer | Check `wsl --list --verbose` |
| **1Password Integration** | Environment variables not working | Run `.\settings\1password\setup-environment-vault.ps1` | Verify OP CLI installation |
| **VSCode Extensions** | Extensions not installing | Ensure VSCode is in PATH, restart terminal | Check `code --version` |
| **Claude Code WSL** | Claude not working in WSL | Verify WSL tools installation | Check WSL development environment |

### Advanced Troubleshooting Commands

```powershell
# System diagnostics
Get-ExecutionPolicy                        # Check PowerShell execution policy
wsl --list --verbose                       # Check WSL status and version
winget --version                           # Verify WinGet installation

# Configuration validation  
Get-Item ~/.gitconfig | Select-Object Target    # Check Git config symlink
Test-Path $PROFILE                              # Verify PowerShell profile exists
code --list-extensions                          # List installed VSCode extensions

# Force reconfiguration
.\configure.ps1 -Force                     # Overwrite existing configurations
```

### Detailed Documentation

Each component includes comprehensive documentation:

| Component | Documentation | Focus Areas |
|-----------|---------------|-------------|
| **Installation Scripts** | [installs/README.md](installs/README.md) | Modular installation, execution order, WSL setup |
| **Claude Code** | [settings/claude/README.md](settings/claude/README.md) | 9 AI agents, WSL integration, security |
| **Git Configuration** | [settings/git/README.md](settings/git/README.md) | VSCode integration, aliases, workflows |
| **VSCode Setup** | [settings/vscode/README.md](settings/vscode/README.md) | 31+ extensions, productivity features |
| **Terminal Configuration** | [settings/windows-terminal/README.md](settings/windows-terminal/README.md) | Windows 11 features, themes |
| **PowerShell Profile** | [settings/pwsh/README.md](settings/pwsh/README.md) | 1Password integration, Oh My Posh |
| **Network Configuration** | [settings/etc/README.md](settings/etc/README.md) | Hosts file management, security |

## 🤝 Contributing Guidelines

### Development Workflow

1. **Fork the Repository**: Create your own fork for development
2. **Create Feature Branch**: Use descriptive branch names (`feature/add-python-support`)
3. **Test Changes**: Verify functionality across Windows 10/11 and WSL environments
4. **Update Documentation**: Ensure README files reflect your changes
5. **Submit Pull Request**: Provide clear description of changes and testing performed

### Code Standards

#### PowerShell Scripts
- Use `PascalCase` for functions and `$camelCase` for variables
- Include comprehensive error handling with clear error messages
- Add help documentation with `Get-Help` compatible comments
- Test with PowerShell 5.1 and 7+ for compatibility

#### Documentation
- Follow CommonMark/GitHub Flavored Markdown standards
- Use consistent heading hierarchy and formatting
- Include code examples with syntax highlighting
- Update table of contents for structural changes

#### Configuration Files
- Validate JSON syntax before committing
- Use consistent indentation (2 spaces for JSON, 4 for PowerShell)
- Include comments where helpful (for non-JSON files)
- Test configuration changes in clean environment

### Testing Guidelines

#### Minimum Testing Requirements
- Test on clean Windows 10 and Windows 11 installations
- Verify WSL integration works correctly
- Ensure all symbolic links are created properly
- Validate 1Password integration (if applicable)
- Test both fresh installations and updates

#### Regression Testing
- Verify existing functionality isn't broken
- Test edge cases and error conditions
- Validate rollback procedures work correctly
- Check cross-component interactions

### Issue Reporting

When reporting issues, please include:
- **Environment Details**: Windows version, PowerShell version, WSL status
- **Reproduction Steps**: Clear steps to reproduce the issue
- **Expected vs. Actual Behavior**: What should happen vs. what does happen
- **Error Messages**: Full error text and stack traces
- **Configuration**: Relevant configuration files and settings

---

## 🚀 Ready to Get Started?

Transform your Windows development environment in just two commands:

```powershell
# Step 1: Install all development tools and WSL environment
.\install.ps1

# Step 2: Configure everything for optimal development workflow  
.\configure.ps1
```

**Result**: A complete Windows + WSL development setup with Claude Code AI integration, 30+ development tools, 31+ VSCode extensions, and 9 specialized AI agents - all configured and ready to use! 🎉