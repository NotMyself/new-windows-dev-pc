# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose
This is a Windows developer setup automation repository containing PowerShell scripts to install and configure development tools, IDEs, and environments for new developers.

## Key Commands

### Main Setup Commands
- `.\install.ps1` - Main installation script that installs WinGet (if needed), runs tool installation, and installs VSCode extensions
  - Optional parameters: `-SkipWinGet`, `-SkipExtensions`
  - Installs Cascadia Code fonts from `fonts/CascadiaCode.zip`
- `.\configure.ps1` - Creates symbolic links for configuration files (Git, VSCode, PowerShell, Claude Code)
  - Optional parameter: `-Force` (overwrite existing configurations)

### Component Scripts
- `.\installs\winget.ps1` - Installs development tools via WinGet package manager
- `.\installs\vscode.ps1` - Installs VSCode extensions from the extensions list
- `.\installs\install-winget.ps1` - Installs WinGet if not present

### Administrative Requirements
All main scripts require Administrator privileges and will check for elevation before running.

### PowerShell Profile Commands
Once configured, the PowerShell profile provides these key commands:
- `backup-vs` - Export currently installed VSCode extensions to the extensions list file
- Navigation: `oss`, `work`, `tw` - Quick navigation to common project directories
- `sln` - Smart solution file opener for the current directory
- Unix-like aliases: `ls`, `rm`, `mv`, `cp`, `touch`, `mkdir` and many others

## Architecture Overview

The repository follows a modular structure:

### Core Structure
- **Root scripts** (`install.ps1`, `configure.ps1`) - Main entry points
- **`installs/` directory** - Modular installation scripts for different components
- **`settings/` directory** - Configuration files that get symlinked to user directories

### Configuration Management
The system uses symbolic links to centralize configuration:
- Git config: `settings/git/.gitconfig` → `~/.gitconfig`
- VSCode settings: `settings/vscode/settings.json` → `$env:APPDATA\Code\User\settings.json`
- VSCode keybindings: `settings/vscode/keybindings.json` → `$env:APPDATA\Code\User\keybindings.json`
- PowerShell profile: `settings/pwsh/Microsoft.PowerShell_profile.ps1` → `$profile`
- Oh My Posh theme: `settings/pwsh/.theme.omp.json` → `~/.theme.omp.json`
- Claude Code settings: `settings/claude/settings.json` → `~/.claude/settings.json`
- Claude agents: `settings/claude/agents` → `~/.claude/agents`

### Tool Categories
The setup installs tools in these categories:
- **Windows/CLI tools**: PowerToys, Windows Terminal, PowerShell, Oh My Posh
- **Development environments**: .NET, Node.js (via fnm), Azure CLI
- **Version control**: Git, Git LFS, GitHub CLI
- **IDEs**: Visual Studio 2022 Professional, VSCode, Azure Data Studio, JetBrains Toolbox
- **Other**: Claude AI, SQL Server Management Studio

### PowerShell Profile Features
The included PowerShell profile provides:
- Oh My Posh prompt integration
- Fast Node Manager (fnm) integration
- Enhanced PSReadLine configuration
- Unix-like aliases and helper functions
- Project navigation shortcuts (`oss`, `work` functions)
- VSCode extension backup function (`backup-vs`)

## Development Notes

### VSCode Extensions
Extensions are managed via the `settings/vscode/extensions` file. The `backup-vs` function in the PowerShell profile can update this list from currently installed extensions.

### Git Configuration
The Git config includes VSCode as the default editor and merge/diff tool, with helpful aliases like `cm` for add-all-and-commit.

### File Modifications
When modifying scripts, ensure PowerShell execution policies allow script execution and maintain the Administrator privilege checks for system-level installations.

### Claude Code Configuration
The repository includes Claude Code agent configurations in `settings/claude/agents/`:
- `new-agent.md` - Meta-agent for designing specialized agents
- `readme-maintainer.md` - Agent for updating README files
- Global permissions are configured to allow specific tool operations
- Shell is configured to use PowerShell instead of bash for better Windows compatibility
- MCP server configuration includes development tools (NuGet, .NET CLI, Azure, Git, SQL Server)

### Extension Management Workflow
1. Install extensions manually in VSCode
2. Run `backup-vs` command in PowerShell to export current extensions
3. Extensions are automatically installed on future runs of `.\installs\vscode.ps1`

### Visual Studio Configuration
The `.vsconfig` file in `settings/visual-studio/` defines comprehensive workloads including .NET Web Development, Azure Development, MAUI, and UWP development components.