# Installation Scripts

This directory contains modular PowerShell scripts that handle the installation of development tools, IDEs, and environments for Windows developers. These scripts are designed to work together as part of the automated setup process but can also be executed independently.

## Scripts Overview

| Script | Purpose | Dependencies |
|--------|---------|-------------|
| [`install-winget.ps1`](#install-wingetps1) | Installs WinGet package manager with dependencies | Administrator privileges |
| [`winget.ps1`](#wingetps1) | Installs development tools via WinGet | WinGet, Administrator privileges |
| [`vscode.ps1`](#vscodeps1) | Installs VSCode extensions from list | VSCode, VSCode CLI |

## Prerequisites

- **Administrator privileges**: Required for `install-winget.ps1` and `winget.ps1`
- **PowerShell execution policy**: Must allow script execution
- **Internet connection**: Required for downloading packages and dependencies

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

### Usage
```powershell
# Basic installation (skip browsers)
.\installs\winget.ps1

# Include browsers
.\installs\winget.ps1 -IncludeBrowsers

# Skip specific packages
.\installs\winget.ps1 -SkipPackages @('Microsoft.PowerToys', 'JetBrains.Toolbox')

# Combine options
.\installs\winget.ps1 -IncludeBrowsers -SkipPackages @('Mozilla.Firefox.DeveloperEdition')
```

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

### Usage
```powershell
# Install extensions from default list
.\installs\vscode.ps1

# Use custom extensions file
.\installs\vscode.ps1 -ExtensionsFile "C:\path\to\custom\extensions"
```

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

## Execution Order and Dependencies

### Recommended Execution Order
1. **`install-winget.ps1`** - Ensures WinGet is available
2. **`winget.ps1`** - Installs development tools (includes VSCode)
3. **`vscode.ps1`** - Installs VSCode extensions

### Dependency Chain
```
install-winget.ps1
    ↓
winget.ps1 (requires WinGet)
    ↓ (installs VSCode)
vscode.ps1 (requires VSCode CLI)
```

### Integration with Main Scripts
These scripts are typically called by the main setup scripts:
- **`install.ps1`**: Calls `install-winget.ps1`, then `winget.ps1`, then `vscode.ps1`
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