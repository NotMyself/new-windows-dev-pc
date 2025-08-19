# Windows Developer Setup Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%2B-0078d4.svg)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Ready-purple.svg)](https://claude.ai/code)

A comprehensive Windows developer setup automation repository containing PowerShell scripts to install and configure development tools, IDEs, and environments for new developers. Includes specialized Claude Code agents for enhanced development workflows.

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
3. **Claude Code**: Specialized agents are automatically configured for enhanced development workflows

**💡 Tip**: You can double-click the scripts or run them from any PowerShell prompt - they'll automatically request elevation when needed.

## Installed Packages

### Windows & CLI Tools
- **WinGet** - CLI based Windows package manager
- **PowerToys** - Windows system utilities
- **Windows Terminal** - Modern terminal application with dual-location configuration support
- **PowerShell** - Latest cross-platform PowerShell
- **Oh My Posh** - Custom PowerShell prompts

### Productivity & Security
- **1Password** - Password manager with CLI support
- **Google Drive** - Cloud storage and sync
- **Zoom** - Video conferencing platform

### Development Environment
- **Git** - Version control system
- **Git LFS** - Large File System for Git
- **GitHub CLI** - Command-line interface for GitHub
- **.NET** - Microsoft development framework
- **.NET Framework Developer Pack** - .NET Framework development pack for legacy applications
- **fnm** - Fast Node.js version manager
- **Azure CLI** - Command-line interface for Azure
- **Claude** - Anthropic's AI assistant
- **Docker Desktop** - Container development platform

### IDEs & Editors
- **Visual Studio 2022 Professional** - Full-featured IDE with custom workload configuration
- **Visual Studio Code** - Lightweight code editor
- **VSCode CLI** - Command-line interface for VSCode
- **Azure Data Studio Insiders** - Database management tool
- **SQL Server Management Studio 21** - SQL Server administration
- **JetBrains Toolbox** - JetBrains IDE manager

### Developer Fonts
- **Cascadia Code** - Microsoft's monospaced font optimized for programming and terminal use

## Configuration Files

The setup includes pre-configured settings that get symlinked to your user directories:

- **Git**: Custom `.gitconfig` with VSCode integration, GitHub CLI credentials, and useful aliases (`cm` for add-all-and-commit)
- **VSCode**: Settings and keybindings optimized for development
- **Windows Terminal**: Custom terminal configuration with optimized profile ordering (PowerShell, Azure Cloud Shell, Command Prompt)
- **PowerShell**: Enhanced profile with Oh My Posh, fnm integration, and Unix-like aliases
- **Extensions**: Curated list of VSCode extensions for development
- **Claude Code**: Global settings with PowerShell shell configuration, specialized agents, commands, and MCP server integrations

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
  - Creates symbolic links for Git, VSCode, Windows Terminal, PowerShell, and Claude Code configurations
  - Supports dual-location Windows Terminal configuration (standard and Microsoft Store installations)
  - Enhanced directory removal handling with automatic confirmation bypass
  - Validates paths and provides detailed feedback

### Component Scripts

Located in the `installs/` directory:
- **`winget.ps1`** - Installs development tools via WinGet:
  - Includes productivity tools (1Password, Google Drive, Zoom)
  - Development environment setup (.NET, Docker, Azure CLI, fnm)
  - IDE and editor installations with Visual Studio custom configuration
  - Database tools (SQL Server Management Studio, Azure Data Studio)
  - Progress tracking with individual package installation

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
  - Custom profile ordering: PowerShell → Azure Cloud Shell → Command Prompt
  - Windows PowerShell profile hidden by default for cleaner interface
  - Supports both standard and Microsoft Store installations with dual symlink approach
  - Located in `settings/windows-terminal/settings.json`

### Visual Studio Configuration

- **`.vsconfig`** - Visual Studio component configuration file:
  - Automatically used by Visual Studio installer when present
  - Defines consistent workload and component installations
  - Located in `settings/visual-studio/.vsconfig`

## PowerShell Profile Features

The included PowerShell profile provides:
- Oh My Posh prompt with custom theme (safe initialization)
- Fast Node Manager (fnm) integration with error handling
- Enhanced PSReadLine with history and ListView
- Improved Unix-like aliases with parameter validation:
  - `ls`, `rm`, `mv`, `cp`, `touch`, `mkdir`, `rmdir`
- Navigation shortcuts (`oss`, `work`, `~`, `..`, `....`, `......`)
- Enhanced utility functions:
  - `backup-vs` - Backup VSCode extensions with validation
  - `sln` - Smart solution file opener with multi-file selection
  - `which` - Find command location
  - `grep` - Search text in files
  - `find` - Find files by name

## Claude Code Integration

The setup includes comprehensive Claude Code configuration with specialized agents and development tool integrations:

### Global Settings
- **PowerShell Shell**: Configures Claude Code to use PowerShell instead of bash for better Windows compatibility
- **Permissions**: Pre-configured permissions for common development operations
- **Environment Variables**: Sets `SHELL` and `CLAUDE_SHELL` to PowerShell

### Specialized Agents

The repository includes seven specialized agents for enhanced development workflows:

#### 🔧 Claude Agent Specialist (`/new-agent`)
**Purpose**: Meta-agent that designs and creates other specialized agents with proper structure, validation, and best practices.
- Agent design and architecture planning
- Template creation following Claude Code standards
- Validation and best practice enforcement
- YAML frontmatter format compliance
- Naming convention and uniqueness checks
- Sub-agent integration and workflow orchestration
- README maintenance after agent creation/updates

#### ☁️ Azure DevOps Specialist (`/devops`)
**Purpose**: Azure DevOps specialist for pipelines, builds, releases, and project management.
- YAML pipeline creation and optimization
- Azure CLI automation and scripting
- Build agent and deployment configuration
- Security scanning and compliance implementation
- Modern CI/CD pattern implementation (2024-2025)

#### 📝 README Maintainer (`/readme`)
**Purpose**: Updates and maintains README.md files with modern documentation best practices and integrates with markdown-specialist for optimal formatting.
- README analysis and gap identification
- Modern documentation standards implementation
- Structure optimization with scannable sections
- Badge integration and status indicators
- Cross-platform compatibility considerations
- Automatic markdown formatting via markdown-specialist integration

#### 💻 C# Specialist (`/csharp`)
**Purpose**: Modern C# development specialist using latest language features, frameworks, and best practices.
- C# 12+ language features (primary constructors, collection expressions, ref readonly parameters, alias any type)
- .NET 8+ framework capabilities with ASP.NET Core and Entity Framework Core
- SOLID principles, dependency injection, and clean architecture patterns
- Modern async/await patterns with proper ConfigureAwait usage
- Integration with popular libraries (MediatR, FluentValidation, AutoMapper, Serilog, Carter)
- Nullable reference types and null safety patterns
- Record types, pattern matching, and switch expressions
- Result patterns for error handling vs traditional exceptions

#### 🧪 MSTest Specialist (`/mstest`)
**Purpose**: .NET unit testing specialist using MSTest.Sdk and NSubstitute for component testing.
- MSTest.Sdk framework test generation with modern attributes
- NSubstitute mocking and dependency isolation patterns
- Component testing vs unit testing methodologies
- Async/await testing patterns and best practices
- Test architecture following .NET testing standards
- Arrange-act-assert pattern implementation
- Test execution and coverage analysis
- Parameterized testing with DataTestMethod and DataRow

#### 📋 Feature Prompt Specialist (`/new-feature`)
**Purpose**: Specialized agent for creating comprehensive, well-structured feature prompts for software development tasks.
- Requirements engineering principles and analysis
- Comprehensive feature documentation with all necessary sections
- Technical specifications with implementation guidance
- Clear, testable acceptance criteria and success metrics
- Context integration with existing codebases and architecture
- Testing strategy and quality assurance requirements
- User story and acceptance criteria writing techniques
- Technical documentation following industry standards

#### 📝 Markdown Specialist (`/markdown`)
**Purpose**: Creates well-formed, linted markdown documents and reformats existing markdown files following CommonMark and GitHub Flavored Markdown standards.
- CommonMark and GitHub Flavored Markdown specification compliance
- Markdown linting rules and markdownlint standards application
- Table formatting, alignment, and accessibility optimization
- Code block syntax highlighting and language specification
- Link validation, formatting, and accessibility enhancement
- Header hierarchy optimization and document structure improvement

### Quick Agent Commands

```bash
# Update README with modern best practices
/readme

# Create or improve agents
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

> **Note**: These commands are available after running `.\configure.ps1` to set up Claude Code integration.

### Agent Workflow Integration

The agents are designed to work together as an integrated workflow system, with each agent capable of calling others to ensure comprehensive and properly formatted results:

**Documentation Chain**:
- `readme-maintainer` → `markdown-specialist`: README updates automatically formatted and linted
- `claude-agent-specialist` → `readme-maintainer` → `markdown-specialist`: New agent creation triggers complete documentation update
- `feature-prompt-specialist` → `markdown-specialist`: Feature documentation properly formatted

**Development Chain**:
- `feature-prompt-specialist` → `csharp-specialist`: Requirements analysis followed by modern C# implementation
- `csharp-specialist` → `mstest-specialist`: Code implementation followed by comprehensive unit testing
- `azure-devops-specialist` → `mstest-specialist`: CI/CD pipelines with integrated testing workflows
- `csharp-specialist` → `azure-devops-specialist`: Modern .NET applications with proper CI/CD integration

### MCP Server Integrations

The configuration includes MCP server support for development tools:
- **nuget** - Microsoft NuGet package server for package management
- **dotnet-cli** - .NET CLI integration for build and project operations
- **filesystem** - File system operations and project navigation
- **git** - Git operations and repository management
- **azure-cli** - Azure CLI integration for cloud services
- **mssql** - Microsoft SQL Server integration for database operations

### Advanced Usage

#### Script Parameters
```powershell
# Install with options
.\install.ps1 -SkipWinGet          # Skip package installation
.\install.ps1 -SkipExtensions      # Skip VSCode extensions

# Configure with options
.\configure.ps1 -Force              # Overwrite existing configs

# Component scripts with options
.\installs\vscode.ps1 -ExtensionsFile "custom-extensions.txt"
```

#### Symbolic Link Mappings

The `configure.ps1` script creates the following symbolic links:

**Git Configuration:**
- `~/.gitconfig` → `settings/git/.gitconfig`

**VSCode Configuration:**
- `%APPDATA%\Code\User\settings.json` → `settings/vscode/settings.json`
- `%APPDATA%\Code\User\keybindings.json` → `settings/vscode/keybindings.json`

**Windows Terminal Configuration:**
- `%LOCALAPPDATA%\Microsoft\Windows Terminal\settings.json` → `settings/windows-terminal/settings.json`
- `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json` → `settings/windows-terminal/settings.json` (Store version)

**PowerShell Configuration:**
- `~/.theme.omp.json` → `settings/pwsh/.theme.omp.json`
- `$profile` → `settings/pwsh/Microsoft.PowerShell_profile.ps1`

**Claude Code Configuration:**
- `~/.claude/settings.json` → `settings/claude/settings.json`
- `~/.claude/agents/` → `settings/claude/agents/`
- `~/.claude/commands/` → `settings/claude/commands/`

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
│   ├── winget.ps1           # WinGet package installations
│   ├── vscode.ps1           # VSCode extension installer
│   └── install-winget.ps1   # WinGet installer with error handling
└── settings/
    ├── git/
    │   └── .gitconfig       # Git configuration with VSCode integration
    ├── visual-studio/
    │   └── .vsconfig        # Visual Studio workload configuration
    ├── vscode/
    │   ├── settings.json    # VSCode settings optimized for development
    │   ├── keybindings.json # VSCode keybindings
    │   └── extensions       # Curated extension list
    ├── windows-terminal/
    │   └── settings.json    # Windows Terminal configuration with custom profiles
    ├── claude/
    │   ├── README.md                       # Claude Code configuration documentation
    │   ├── settings.json                   # Claude Code global settings with PowerShell shell
    │   ├── agents/                         # Specialized Claude agents
    │   │   ├── claude-agent-specialist.md  # Meta-agent for creating specialized agents
    │   │   ├── azure-devops-specialist.md  # Azure DevOps operations specialist
    │   │   ├── csharp-specialist.md        # Modern C# development specialist
    │   │   ├── mstest-specialist.md        # .NET unit testing specialist
    │   │   ├── feature-prompt-specialist.md # Feature specification specialist
    │   │   ├── markdown-specialist.md      # Markdown formatting and linting specialist
    │   │   └── readme-maintainer.md        # README maintenance agent
    │   └── commands/                       # Quick access commands for agents
    │       ├── new-agent.md                # /new-agent command
    │       ├── devops.md                   # /devops command
    │       ├── csharp.md                   # /csharp command
    │       ├── mstest.md                   # /mstest command
    │       ├── new-feature.md              # /new-feature command
    │       ├── markdown.md                 # /markdown command
    │       └── readme.md                   # /readme command
    └── pwsh/
        ├── Microsoft.PowerShell_profile.ps1  # Enhanced PowerShell profile
        └── .theme.omp.json  # Oh My Posh theme configuration
```