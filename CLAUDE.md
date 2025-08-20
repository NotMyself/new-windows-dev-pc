# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose
This is a Windows developer setup automation repository containing PowerShell scripts to install and configure development tools, IDEs, and environments for new developers.

## Key Commands

### Main Setup Commands
- `.\install.ps1` - Main installation script that installs WinGet (if needed), runs tool installation, installs global npm packages, and installs VSCode extensions
- `.\configure.ps1` - Creates symbolic links for configuration files (Git, VSCode, PowerShell)

### Component Scripts
- `.\installs\winget.ps1` - Installs development tools via WinGet package manager
- `.\installs\npm-global.ps1` - Installs global npm packages from the packages list
- `.\installs\vscode.ps1` - Installs VSCode extensions from the extensions list
- `.\installs\install-winget.ps1` - Installs WinGet if not present

### Administrative Requirements
All main scripts require Administrator privileges and will check for elevation before running.

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
- Global npm packages: `settings/npm/global-packages` (installed directly, not symlinked)

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
- Global npm packages backup function (`backup-npm`)

## Development Notes

### VSCode Extensions
Extensions are managed via the `settings/vscode/extensions` file. The `backup-vs` function in the PowerShell profile can update this list from currently installed extensions.

### Global npm Packages
Global npm packages are managed via the `settings/npm/global-packages` file. The `backup-npm` function in the PowerShell profile can update this list from currently installed global packages. The installation process ensures fnm installs Node.js LTS before attempting package installation.

### Git Configuration
The Git config includes VSCode as the default editor and merge/diff tool, with helpful aliases like `cm` for add-all-and-commit.

### File Modifications
When modifying scripts, ensure PowerShell execution policies allow script execution and maintain the Administrator privilege checks for system-level installations.