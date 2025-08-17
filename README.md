# New Developer Setup

A set of PowerShell scripts that will install common developer tools and configurations needed by a new Developer.

**Note:** These scripts automatically request Administrator privileges when needed - no need to "Run as Administrator" manually.

## Quick Start

1. **Install tools**: Run `.\install.ps1` to install all development tools via WinGet and VSCode extensions
2. **Configure settings**: Run `.\configure.ps1` to create symbolic links for configuration files

💡 **Tip**: You can double-click the scripts or run them from any PowerShell prompt - they'll automatically request elevation when needed.

## Installed Packages

### Windows & CLI Tools
- **WinGet** - CLI based Windows package manager
- **PowerToys** - Windows system utilities
- **Windows Terminal** - Modern terminal application
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

## Configuration Files

The setup includes pre-configured settings that get symlinked to your user directories:

- **Git**: Custom `.gitconfig` with VSCode integration and useful aliases
- **VSCode**: Settings and keybindings optimized for development
- **PowerShell**: Enhanced profile with Oh My Posh, fnm integration, and Unix-like aliases
- **Extensions**: Curated list of VSCode extensions for development

## Prerequisites

- Windows 10/11
- PowerShell (included with Windows)
- User account with ability to elevate to Administrator (scripts handle elevation automatically)

## Detailed Usage

### Main Scripts

- **`.\install.ps1`** - Main installation script with options:
  - `-SkipWinGet` - Skip WinGet and package installation
  - `-SkipExtensions` - Skip VSCode extension installation
  - Automatically installs WinGet if not present
  - Runs tool installation via WinGet with progress tracking
  - Installs VSCode extensions from the curated list

- **`.\configure.ps1`** - Configuration script with options:
  - `-Force` - Overwrite existing configuration files
  - Creates symbolic links for Git, VSCode, and PowerShell configurations
  - Validates paths and provides detailed feedback

### Component Scripts

Located in the `installs/` directory:
- **`winget.ps1`** - Installs development tools via WinGet with options:
  - `-SkipPackages` - Array of package IDs to skip
  - `-IncludeBrowsers` - Install optional browser packages
  - Categorized installation with progress tracking
  - Individual package error handling

- **`vscode.ps1`** - Installs VSCode extensions with options:
  - `-ExtensionsFile` - Custom path to extensions file
  - Supports comments in extensions file
  - Progress tracking and error handling per extension

- **`install-winget.ps1`** - Installs WinGet package manager:
  - Comprehensive error handling and progress tracking
  - Automatic cleanup of temporary files
  - Multiple installation methods with fallback

### PowerShell Profile Features

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

### Advanced Usage

#### Script Parameters
```powershell
# Install with options
.\install.ps1 -SkipWinGet          # Skip package installation
.\install.ps1 -SkipExtensions      # Skip VSCode extensions

# Configure with options
.\configure.ps1 -Force              # Overwrite existing configs

# Component scripts with options
.\installs\winget.ps1 -IncludeBrowsers -SkipPackages @('Git.Git', 'Microsoft.PowerShell')
.\installs\vscode.ps1 -ExtensionsFile "custom-extensions.txt"
```

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

## File Structure

```
├── install.ps1              # Main installation script (auto-elevates)
├── configure.ps1            # Configuration symbolic links (auto-elevates)
├── CLAUDE.md                # Claude Code documentation
├── installs/
│   ├── winget.ps1           # WinGet package installations
│   ├── vscode.ps1           # VSCode extension installer
│   └── install-winget.ps1   # WinGet installer with error handling
└── settings/
    ├── git/
    │   └── .gitconfig       # Git configuration with VSCode integration
    ├── vscode/
    │   ├── settings.json    # VSCode settings optimized for development
    │   ├── keybindings.json # VSCode keybindings
    │   └── extensions       # Curated extension list
    └── pwsh/
        ├── Microsoft.PowerShell_profile.ps1  # Enhanced PowerShell profile
        └── .theme.omp.json  # Oh My Posh theme configuration
```
