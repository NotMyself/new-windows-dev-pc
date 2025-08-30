# Installation Scripts

This directory contains modular PowerShell scripts that handle the installation of development tools, IDEs, and environments for Windows developers. These scripts are designed to work together as part of the automated setup process but can also be executed independently.

## Table of Contents

- [Scripts Overview](#scripts-overview)
- [Prerequisites](#prerequisites)
- [Main Scripts Detailed Usage](#main-scripts-detailed-usage)
- [Component Scripts](#component-scripts)
- [Execution Order and Dependencies](#execution-order-and-dependencies)
- [Symbolic Link Management](#symbolic-link-management)
- [Configuration Files](#configuration-files)
- [Error Handling and Logging](#error-handling-and-logging)
- [Advanced Usage and Parameter Reference](#advanced-usage-and-parameter-reference)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Scripts Overview

| Script | Purpose | Dependencies |
|--------|---------|-------------|
| [`install-winget.ps1`](#install-wingetps1) | Installs WinGet package manager with dependencies | Administrator privileges |
| [`winget.ps1`](#wingetps1) | Installs development tools via WinGet | WinGet, Administrator privileges |
| [`npm-global.ps1`](#npm-globalps1) | Installs global npm packages using fnm | fnm (Fast Node Manager) |
| [`vscode.ps1`](#vscodeps1) | Installs VSCode extensions from list | VSCode, VSCode CLI |
| [`wsl-tools.sh`](#wsl-toolssh) | Sets up WSL development environment | WSL with Ubuntu |

## Prerequisites

- **Administrator privileges**: Required for `install-winget.ps1` and `winget.ps1`
- **PowerShell execution policy**: Must allow script execution
- **Internet connection**: Required for downloading packages and dependencies

## Main Scripts Detailed Usage

The main scripts (`install.ps1` and `configure.ps1`) orchestrate the entire setup process and call the component scripts in this directory. These scripts are designed to be run from the repository root.

### install.ps1 - Development Tools Installation

**Purpose**: Installs all development tools, fonts, VSCode extensions, and sets up WSL environment

**Parameters**:
- `-SkipWinGet` - Skip WinGet package manager and package installation
- `-SkipNpmPackages` - Skip global npm package installation
- `-SkipExtensions` - Skip VSCode extension installation
- `-WSLDistro` - Specify WSL distribution (default: Ubuntu-22.04)

**Process**:
1. **WinGet Installation**: Automatically installs WinGet if not present
2. **Tool Installation**: Runs WinGet package installation with progress tracking
3. **Font Installation**: Installs Cascadia Code fonts from `fonts/CascadiaCode.zip`
4. **NPM Packages**: Installs global npm packages using fnm
5. **Extension Installation**: Installs VSCode extensions from curated extensions list
6. **WSL Setup**: Installs and configures WSL with development tools

**Example Usage**:
```powershell
# Full installation
.\install.ps1

# Skip package installation, only install extensions and WSL
.\install.ps1 -SkipWinGet

# Skip extensions, only install packages and WSL
.\install.ps1 -SkipExtensions

# Use different WSL distribution
.\install.ps1 -WSLDistro "Ubuntu-20.04"
```

### configure.ps1 - Configuration Environment Setup

**Purpose**: Configures development environment with WSL and Windows tool integration

**Parameters**:
- `-Force` - Overwrite existing configuration files and directories
- `-SkipConfirmation` - Skip interactive confirmations for automated deployment
- `-WSLDistro` - Specify WSL distribution (default: Ubuntu-22.04)

**Process**:
1. **WSL Configuration**: Sets up Claude Code for WSL with bash shell
2. **1Password Integration**: Configures secure environment variables in WSL
3. **Git Configuration**: Sets up separate Git identity for Claude Code
4. **Windows Configuration**: Creates symbolic links for Windows tools
5. **Path Validation**: Validates all target paths before creating links

**Example Usage**:
```powershell
# Interactive configuration setup
.\configure.ps1

# Force overwrite existing configurations
.\configure.ps1 -Force

# Automated deployment without prompts
.\configure.ps1 -SkipConfirmation
```

## Component Scripts

The following scripts handle specific installation components and are typically called by the main scripts:

## install-winget.ps1

### Purpose
Installs the latest WinGet (Windows Package Manager) with all required dependencies and license files. This script ensures WinGet is properly configured and available for use by other installation scripts.

### What It Installs
- **WinGet CLI**: Latest version from GitHub releases
- **Microsoft.UI.Xaml**: Required dependency for WinGet
- **Microsoft.VCLibs**: Visual C++ redistributable libraries
- **License files**: Proper licensing for WinGet installation

### Key Features
- Downloads latest WinGet release automatically
- Installs all required dependencies
- Configures proper permissions and PATH environment
- Handles both primary and fallback installation methods
- Automatic cleanup of temporary files

### Usage
```powershell
# Run as Administrator
.\installs\install-winget.ps1
```

**Features**:
- Multiple installation methods with automatic fallback
- Comprehensive error handling and progress tracking
- Automatic cleanup of temporary installation files
- Validation of WinGet installation success

### Requirements
- Administrator privileges (mandatory)
- Internet connection for downloading components
- Windows 10/11 with PowerShell 5.1+

### Process Overview
1. Creates temporary download directory (`C:\WinGet`)
2. Downloads and installs Microsoft.UI.Xaml dependency
3. Downloads and installs Microsoft.VCLibs dependency
4. Downloads latest WinGet package and license from GitHub
5. Installs WinGet with proper licensing
6. Fixes permissions and adds WinGet to system PATH
7. Cleans up temporary files

### Error Handling
- Multiple installation methods (primary and fallback)
- Comprehensive error logging
- Graceful cleanup on failure
- Detailed status messages throughout process

## winget.ps1

### Purpose
Installs a comprehensive set of development tools using WinGet package manager. This script handles the bulk of the development environment setup with organized categories of tools.

### Parameters
- `$SkipPackages` (string[]): Array of package IDs to skip during installation
- `$IncludeBrowsers` (switch): Include browser installations (optional)

### What It Installs

#### Browsers (Optional - with `-IncludeBrowsers`)
- Microsoft Edge Beta
- Google Chrome Beta
- Firefox Developer Edition

#### Windows & CLI Tools
- **PowerToys**: Windows system utilities
- **Windows Terminal**: Modern terminal application
- **PowerShell 7+**: Latest PowerShell version
- **Oh My Posh**: Terminal prompt customization

#### Version Control
- **Git**: Distributed version control system
- **Git LFS**: Large File Storage for Git
- **GitHub CLI**: Command-line interface for GitHub

#### Development Environment
- **.NET SDK**: Microsoft .NET development platform
- **Fast Node Manager (fnm)**: Node.js version manager
- **Claude AI**: AI assistant application
- **Azure CLI**: Command-line tools for Azure

#### IDEs & Editors
- **Visual Studio 2022 Professional**: Full-featured IDE
  - Uses `.vsconfig` file if available in `../settings/visual-studio/`
  - Includes comprehensive .NET development workloads
- **Visual Studio Code**: Lightweight code editor
- **VSCode CLI**: Command-line interface for VSCode
- **SQL Server Management Studio**: Database management tool
- **Azure Data Studio Insiders**: Modern database tool
- **JetBrains Toolbox**: Manager for JetBrains IDEs

### Enhanced Usage Examples
```powershell
# Install all packages
.\installs\winget.ps1

# Install packages with optional browsers
.\installs\winget.ps1 -IncludeBrowsers

# Skip specific packages
.\installs\winget.ps1 -SkipPackages @("Microsoft.VisualStudio.2022.Professional")

# Combine options - install browsers but skip specific packages
.\installs\winget.ps1 -IncludeBrowsers -SkipPackages @('Mozilla.Firefox.DeveloperEdition')
```

**Tool Categories**:
- **Core Development Tools**: .NET SDK, Fast Node Manager (fnm), Azure CLI, Git, Claude AI
- **IDEs and Editors**: Visual Studio 2022 Professional, VSCode, JetBrains Toolbox
- **Database Tools**: SQL Server Management Studio, Azure Data Studio Insiders
- **Windows Tools**: PowerToys, Windows Terminal, PowerShell 7+, Oh My Posh
- **Optional Browsers**: Available with `-IncludeBrowsers` parameter

### Requirements
- Administrator privileges (mandatory)
- WinGet installed and available in PATH
- Internet connection for package downloads

### Visual Studio Configuration
The script automatically detects and uses a Visual Studio configuration file:
- **Location**: `../settings/visual-studio/.vsconfig`
- **Components**: Includes .NET Framework, .NET Core, ASP.NET, Windows App SDK, and development tools
- **Workloads**: Managed Desktop development with comprehensive tooling
- **Extensions**: GitHub Copilot, Live Share integration

### Error Handling
- Individual package failure doesn't stop the entire process
- Detailed success/failure reporting for each package
- Handles already-installed packages gracefully
- Color-coded status messages for easy monitoring

## vscode.ps1

### Purpose
Installs Visual Studio Code extensions from a centrally managed list. This ensures consistent VSCode configuration across development environments.

### Parameters
- `$ExtensionsFile` (string): Path to extensions list file (default: `../settings/vscode/extensions`)

### What It Installs
Installs all extensions listed in the extensions file, including:

#### Development Tools
- **GitLens**: Enhanced Git capabilities
- **GitHub Copilot & Copilot Chat**: AI-powered coding assistance
- **ESLint**: JavaScript/TypeScript linting
- **Prettier**: Code formatting
- **REST Client**: API testing

#### Language Support
- **C# Dev Kit**: Complete C# development experience
- **PowerShell**: PowerShell language support
- **Docker**: Container development support
- **Markdown**: Enhanced markdown editing and preview

#### Productivity Extensions
- **Path Intellisense**: Autocomplete for file paths
- **npm Intellisense**: npm package autocomplete
- **Version Lens**: Package version information
- **EditorConfig**: Consistent coding styles
- **Live Server**: Local development server

#### Visual Enhancements
- **VSCode Icons**: File and folder icons
- **Markdown Preview Enhanced**: Advanced markdown preview
- **Import Cost**: Display package import sizes

### Enhanced Usage Examples
```powershell
# Install extensions from default list
.\installs\vscode.ps1

# Use custom extensions file
.\installs\vscode.ps1 -ExtensionsFile "custom-extensions.txt"
```

**Features**:
- Supports comments in extensions file (lines starting with `#`)
- Progress tracking and error handling per extension
- Automatic retry logic for failed installations
- Integration with `backup-vs` PowerShell function for extension management

### Requirements
- VSCode installed and `code` command available in PATH
- Extensions file exists and is readable
- Internet connection for extension downloads

### Extensions File Format
The extensions file (`../settings/vscode/extensions`) contains:
- One extension ID per line
- Comments supported with `#` prefix
- Empty lines ignored
- Extension IDs in format: `publisher.extension-name`

### Maintenance
The PowerShell profile includes a `backup-vs` function to update the extensions list with currently installed extensions:
```powershell
backup-vs  # Updates the extensions file with current VSCode extensions
```

### Error Handling
- Validates VSCode CLI availability before proceeding
- Checks for extensions file existence
- Individual extension failures don't stop the process
- Detailed reporting for each extension installation
- Graceful handling of already-installed extensions

## npm-global.ps1

### Purpose
Installs essential global npm packages using Fast Node Manager (fnm). This ensures a consistent set of Node.js development tools across all environments.

### Prerequisites
- **fnm (Fast Node Manager)** must be installed and available in PATH
- **Node.js** must be installed (handled by fnm)
- **npm** must be available (comes with Node.js)

### What It Installs
Global npm packages from `../settings/npm/global-packages` including:

#### Development Tools
- **TypeScript**: TypeScript compiler and language service
- **ESLint**: JavaScript and TypeScript linting
- **Prettier**: Code formatting
- **Markdownlint-CLI**: Markdown linting for documentation
- **Live Server**: Development server with live reload

#### Build Tools
- **Webpack CLI**: Module bundler command line interface
- **Vite**: Next generation frontend tooling
- **Nodemon**: Development server with auto-restart

### Usage Examples
```powershell
# Install all global packages from default list
.\installs\npm-global.ps1

# Check installed packages after completion
npm list -g --depth=0
```

### Features
- Reads package list from centralized file
- Progress tracking for each package installation
- Error handling for individual package failures
- Automatic fnm environment initialization

### Error Handling
- Validates fnm and npm availability before proceeding
- Individual package failures don't stop the process
- Detailed status reporting for each package
- Graceful handling of already-installed packages

## wsl-tools.sh

### Purpose
Sets up a comprehensive WSL development environment with all necessary tools for Claude Code integration and modern development workflows.

### Prerequisites
- **WSL 2** installed and configured
- **Ubuntu 22.04** (or compatible distribution)
- **Internet connection** for package downloads

### What It Installs

#### System Updates
- Updates package manager (apt)
- Installs essential build tools and dependencies

#### Development Environment
- **Node.js LTS**: Latest stable Node.js version via NodeSource repository
- **.NET SDK**: Microsoft .NET development platform
- **Azure CLI**: Command-line tools for Azure development
- **1Password CLI**: Secure credential management

#### Development Tools
- **Git**: Version control (if not already installed)
- **Essential npm packages**: prettier, markdownlint-cli, typescript, eslint
- **Build tools**: make, build-essential, curl, wget

### Usage Examples
```bash
# Run from WSL (called automatically by install.ps1)
./installs/wsl-tools.sh

# Or run from Windows PowerShell
wsl bash ./installs/wsl-tools.sh
```

### Key Features
- **Automatic environment setup**: Configures PATH and environment variables
- **Package verification**: Checks installation success for each component
- **Error resilience**: Continues with other installations if one fails
- **Progress reporting**: Clear status updates throughout the process

### Integration with Claude Code
- Installs tools specifically needed for Claude Code WSL integration
- Configures environment for seamless Windows-WSL development
- Sets up npm packages used by Claude Code for formatting and linting

### Error Handling
- Validates WSL environment before proceeding
- Individual tool failures don't stop the entire process
- Detailed error reporting for troubleshooting
- Automatic retry logic for network-dependent installations

## Execution Order and Dependencies

### Recommended Execution Order
1. **`install-winget.ps1`** - Ensures WinGet is available
2. **`winget.ps1`** - Installs development tools (includes VSCode and fnm)
3. **`npm-global.ps1`** - Installs global npm packages
4. **`vscode.ps1`** - Installs VSCode extensions
5. **`wsl-tools.sh`** - Sets up WSL development environment

### Dependency Chain
```
install-winget.ps1
    ↓
winget.ps1 (requires WinGet)
    ↓ (installs fnm and VSCode)
npm-global.ps1 (requires fnm) | vscode.ps1 (requires VSCode CLI)
    ↓
wsl-tools.sh (requires WSL)
```

### Integration with Main Scripts
These scripts are typically called by the main setup scripts:
- **`install.ps1`**: Calls all scripts in order with WSL setup
- **Individual execution**: Each script can be run independently if prerequisites are met

## Symbolic Link Management

The configuration setup process (`configure.ps1`) uses symbolic links to centralize configuration management while maintaining system compatibility. This approach keeps all settings in the repository while linking them to their expected system locations.

### Symbolic Link Creation Process

The `configure.ps1` script creates symbolic links that:
- **Preserve existing settings** (with `-Force` option to overwrite)
- **Support multiple installation paths** (e.g., Windows Terminal standard vs. Store versions)
- **Validate paths** before creating links
- **Provide detailed feedback** during the linking process

### Multi-Path Support

The script automatically detects and creates links for multiple installation paths:

| Component | Primary Path | Alternative Path |
|-----------|--------------|------------------|
| **Windows Terminal** | `%LOCALAPPDATA%\Microsoft\Windows Terminal\settings.json` | `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json` |
| **VSCode** | `%APPDATA%\Code\User\` | User profile directory variations |
| **PowerShell** | `$PROFILE` | Multiple profile paths supported |

### Path Validation Features

- **Pre-creation validation**: Ensures target directories exist
- **Source file verification**: Confirms repository files are available
- **Backup handling**: Creates backups before overwriting (with `-Force`)
- **Error recovery**: Graceful handling of permission or path issues

### Symbolic Link Benefits

- **Live configuration updates**: Changes to repository files immediately affect system settings
- **Version control integration**: All configuration changes are tracked in Git
- **Easy restoration**: Simple repository checkout restores all settings
- **Multi-machine consistency**: Same configurations across different development machines

## Configuration Files

### Extensions List
- **Location**: `../settings/vscode/extensions`
- **Purpose**: Centralized list of VSCode extensions to install
- **Format**: One extension ID per line, comments with `#`
- **Maintenance**: Use `backup-vs` PowerShell function to update

### Visual Studio Configuration
- **Location**: `../settings/visual-studio/.vsconfig`
- **Purpose**: Defines Visual Studio workloads and components
- **Format**: JSON file with components and extensions arrays
- **Usage**: Automatically detected by `winget.ps1` for VS installation

## Error Handling and Logging

All scripts implement comprehensive error handling:
- **Color-coded output**: Green (success), Yellow (warning), Red (error), Cyan (info)
- **Individual failure isolation**: One package failure doesn't stop others
- **Detailed error messages**: Specific information about failures
- **Exit codes**: Non-zero exit codes on critical failures
- **Progress tracking**: Clear indication of current operation

## Advanced Usage and Parameter Reference

### Complete Script Parameter Options

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

**Component Script Advanced Options**:
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
| **System Hosts** | `C:\Windows\System32\drivers\etc\hosts` | `settings/etc/hosts` |

**Multi-Path Support**: The script automatically detects and creates links for multiple installation paths (e.g., Windows Terminal standard vs. Microsoft Store versions).

**Recent Updates**: Claude settings structure has been reorganized - the commands directory has been removed and .mcp.json is no longer used. MCP server configuration is now embedded directly in settings.json files.

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

## Best Practices

### Before Running Scripts
1. **Run PowerShell as Administrator** (required for install-winget.ps1 and winget.ps1)
2. **Check execution policy**: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
3. **Ensure internet connectivity** for package downloads
4. **Review package lists** and use `-SkipPackages` if needed

### Customization
- **Skip unwanted packages**: Use `-SkipPackages` parameter with winget.ps1
- **Custom extension lists**: Modify `../settings/vscode/extensions` or use `-ExtensionsFile`
- **Visual Studio workloads**: Modify `../settings/visual-studio/.vsconfig`
- **Browser inclusion**: Use `-IncludeBrowsers` switch as needed

### Maintenance
- **Update extensions list**: Run `backup-vs` after manually installing new VSCode extensions
- **Review installed packages**: Use `winget list` to see currently installed packages
- **Keep scripts updated**: Check for script updates in the repository

## Troubleshooting

### Common Issues

**WinGet not found after installation**
- Restart PowerShell session to reload PATH
- Manually add WinGet to PATH if automatic addition fails

**VSCode CLI not available**
- Ensure VSCode is installed and added to PATH
- Restart terminal after VSCode installation
- Check with `Get-Command code`

**Package installation failures**
- Check internet connectivity
- Verify Administrator privileges for system-level installations
- Review specific error messages for package-specific issues

**Extension installation failures**
- Ensure VSCode is fully installed and running
- Check extension marketplace connectivity
- Verify extension IDs in the extensions file

### Getting Help
- **Check script output**: All scripts provide detailed status messages
- **Review error messages**: Specific error information is provided for failures
- **Test individual components**: Run scripts individually to isolate issues
- **Verify prerequisites**: Ensure all requirements are met before execution