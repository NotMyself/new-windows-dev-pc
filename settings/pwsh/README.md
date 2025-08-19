# PowerShell Configuration

This directory contains a comprehensive PowerShell configuration that enhances the command-line experience with modern tooling, developer productivity features, and a beautiful, informative prompt theme.

## Overview

The PowerShell configuration provides:

- **Modern Prompt Theme**: A feature-rich Oh My Posh theme with development context awareness
- **Enhanced Profile**: Unix-like aliases, developer utilities, and productivity functions
- **Tool Integration**: Seamless integration with Node.js (fnm), Git, and development workflows
- **Cross-Platform Compatibility**: Works across Windows, WSL, and other PowerShell environments

## File Structure

```
settings/pwsh/
├── Microsoft.PowerShell_profile.ps1    # PowerShell profile with functions and aliases
├── .theme.omp.json                     # Oh My Posh theme configuration
└── README.md                           # This documentation
```

## Installation

These configuration files are automatically installed via the main setup scripts:

### Automatic Installation

```powershell
# Run the main configuration script (requires Administrator)
.\configure.ps1
```

This creates symbolic links:
- `$PROFILE` → `settings/pwsh/Microsoft.PowerShell_profile.ps1`
- `~/.theme.omp.json` → `settings/pwsh/.theme.omp.json`

### Manual Installation

If you prefer manual setup:

```powershell
# Create PowerShell profile symlink
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$PSScriptRoot\settings\pwsh\Microsoft.PowerShell_profile.ps1" -Force

# Create Oh My Posh theme symlink
New-Item -ItemType SymbolicLink -Path "$HOME\.theme.omp.json" -Target "$PSScriptRoot\settings\pwsh\.theme.omp.json" -Force
```

## PowerShell Profile Features

The `Microsoft.PowerShell_profile.ps1` provides extensive functionality:

### Core Integrations

#### Oh My Posh Prompt
```powershell
# Loads the custom theme for enhanced prompt display
oh-my-posh init pwsh --config ~/.theme.omp.json | Invoke-Expression
```

#### Fast Node Manager (fnm)
```powershell
# Automatic Node.js version management with directory switching
fnm completions --shell powershell | Out-String | Invoke-Expression
fnm env --use-on-cd | Out-String | Invoke-Expression
```

#### Enhanced PSReadLine
```powershell
# Improved command history and prediction
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
```

### Unix-Like Aliases

Provides familiar Unix commands for cross-platform consistency:

#### Navigation
```powershell
~           # Navigate to home directory
..          # Go up one directory
....        # Go up two directories
......      # Go up three directories
```

#### File Operations
```powershell
touch <file>              # Create new file
mkdir <dir>               # Create directory
rmdir <dir>               # Remove directory recursively
rm <file>                 # Remove file
mv <source> <dest>        # Move/rename file
cp <source> <dest>        # Copy file
ls [path]                 # List directory contents
```

#### System Utilities
```powershell
which <command>           # Find command location
grep <pattern> [path]     # Search text patterns
find <name> [path]        # Find files by name
```

### Developer Productivity Functions

#### Project Navigation
```powershell
oss [subdir]              # Navigate to ~/src/oss/[subdir]
work [subdir]             # Navigate to ~/src/ofm/[subdir]
```

#### Visual Studio Integration
```powershell
sln                       # Open solution file in current directory
                         # - Auto-detects single .sln file
                         # - Prompts for selection with multiple files
                         # - Provides numbered selection interface
```

#### VSCode Extension Management
```powershell
backup-vs                 # Backup currently installed VSCode extensions
                         # - Exports to settings/vscode/extensions file
                         # - Automatically sorts extensions
                         # - Validates VSCode CLI availability
                         # - Shows extension count and file location
```

### Git Configuration Management

The profile includes a comprehensive `Set-GitUser` function for managing Git configuration:

#### Basic Usage
```powershell
Set-GitUser                           # Interactive prompts with smart defaults
Set-GitUser -Name "John Doe" -Email "john@example.com"  # Direct setup
Set-GitUser -Auto                     # Auto-detect from system/existing config
```

#### Features
- **Smart Defaults**: Uses current Git config or system user information
- **Email Validation**: Validates email format with confirmation option
- **Auto-Detection**: Can automatically configure from system information
- **Interactive Mode**: Provides helpful prompts with current values
- **Verification**: Shows updated configuration and config file location
- **Error Handling**: Comprehensive error handling with helpful messages

## Oh My Posh Theme

The `.theme.omp.json` provides a sophisticated, developer-focused prompt theme.

### Theme Features

#### Left Prompt Segments
1. **OS Indicator** (`os`)
   - Shows Windows icon with WSL detection
   - Teal background (`#21c7a8`) with dark text
   - Leading diamond style connector

2. **Root Indicator** (`root`)
   - Warning when running as administrator
   - Red background (`#ef5350`) with yellow icon
   - Only visible when elevated

3. **Path Display** (`path`)
   - Blue background (`#82AAFF`) with dark text
   - Agnoster short style (intelligent path shortening)
   - Custom folder icons and separators
   - Home directory special icon

4. **Git Status** (`git`)
   - Comprehensive Git information display
   - Dynamic background colors based on status:
     - Green (`#addb67`): Clean repository
     - Yellow (`#e4cf6a`): Working/staging changes
     - Purple (`#C792EA`): Ahead of remote
     - Orange (`#f78c6c`): Diverged from remote
   - Shows:
     - Branch name with upstream status
     - Working tree changes (📝 icon)
     - Staged changes (📦 icon)
     - Stash count (📚 icon)
     - Fetch status and worktree information

5. **Execution Time** (`executiontime`)
   - Gray background (`#575656`) with light text
   - Shows command execution duration
   - Rounded display format
   - Only appears for commands taking time

#### Right Prompt Segments

The theme includes comprehensive development environment detection:

**Frontend Technologies**
- **Angular** (`angular`): Version with error handling
- **Node.js** (`node`): Version with package manager detection (npm/yarn icons)
- **Flutter** (`flutter`): Framework version
- **Dart** (`dart`): Language version

**Backend Technologies**
- **.NET** (`dotnet`): Framework version with unsupported version warning
- **Go** (`go`): Language version
- **Python** (`python`): Version with virtual environment display
- **Java** (`java`): Runtime version
- **Rust** (`rust`): Compiler version
- **PHP** (`php`): Language version

**Cloud & DevOps**
- **Azure CLI** (`az`): Current subscription/environment
- **Azure Functions** (`azfunc`): Function app context
- **AWS** (`aws`): Profile and region information
- **Kubernetes** (`kubectl`): Context and namespace
- **Cloud Foundry** (`cf`): CLI version and target org/space

**Build Tools & Other**
- **CMake** (`cmake`): Build system version
- **Nx** (`nx`): Monorepo tool version
- **Crystal** (`crystal`): Language version
- **Haskell** (`haskell`): Compiler version

**System Information**
- **Time** (`time`): Current time (3:04:05 PM format)
- Dark blue background (`#234d70`) with light text

#### Bottom Prompt

1. **Continuation Line**: Visual connection from main prompt
2. **Spotify Integration** (`spotify`): Currently playing track (when active)
3. **Status Indicator** (`status`): 
   - Green arrows (`⚡⚡`) for successful commands
   - Red arrows for failed commands (exit code > 0)

### Theme Customization

#### Color Scheme
The theme uses a cohesive color palette:
- **Primary**: Teal (`#21c7a8`) for system information
- **Secondary**: Blue (`#82AAFF`) for navigation context
- **Success**: Green (`#addb67`) for positive status
- **Warning**: Yellow (`#e4cf6a`) for attention items
- **Error**: Red (`#ef5350`) for problems
- **Info**: Purple (`#C792EA`) for additional context

#### Segment Configuration
Each segment can be customized by modifying the corresponding object in `.theme.omp.json`:

```json
{
  "type": "segment_type",
  "style": "powerline|diamond|plain",
  "foreground": "#color",
  "background": "#color",
  "template": "Display template with {{ .Properties }}",
  "properties": {
    "segment_specific_settings": "value"
  }
}
```

## Customization Guide

### Adding Custom Functions

Add new functions to the PowerShell profile:

```powershell
# Add to Microsoft.PowerShell_profile.ps1
function my-custom-function {
    param(
        [Parameter(Mandatory=$true)][string]$Parameter
    )
    
    # Your custom logic here
    Write-Host "Custom function executed with: $Parameter" -ForegroundColor Green
}
```

### Adding Custom Aliases

```powershell
# Add to Microsoft.PowerShell_profile.ps1
Set-Alias -Name "myalias" -Value "my-custom-function"
```

### Modifying the Theme

1. **Edit Segment Colors**: Modify `foreground` and `background` properties
2. **Add New Segments**: Insert new segment objects in the appropriate `segments` array
3. **Change Layout**: Modify `alignment` (left/right) and `type` (prompt)
4. **Customize Templates**: Update `template` strings with desired display format

### Environment-Specific Configurations

Add conditional logic for different environments:

```powershell
# Add to Microsoft.PowerShell_profile.ps1
if ($env:COMPUTERNAME -eq "WORK-MACHINE") {
    # Work-specific configurations
    function work-specific-function {
        # Work-related functionality
    }
}

if (Test-Path "C:\Development") {
    # Development machine specific settings
    Set-Location "C:\Development"
}
```

## Troubleshooting

### Common Issues

#### Oh My Posh Not Loading
```powershell
# Verify Oh My Posh is installed
Get-Command oh-my-posh

# Check theme file exists
Test-Path ~/.theme.omp.json

# Manually reload profile
. $PROFILE
```

#### Missing Fonts for Icons
The theme uses Nerd Fonts for icons. Install a compatible font:
- Download from [Nerd Fonts](https://www.nerdfonts.com/)
- Install and configure your terminal to use the font
- Popular choices: "CascadiaCode NF", "FiraCode NF", "JetBrainsMono NF"

#### fnm Not Working
```powershell
# Verify fnm is installed
Get-Command fnm

# Check Node.js installation
node --version
npm --version
```

#### Profile Not Loading
```powershell
# Check profile path
$PROFILE

# Verify profile exists
Test-Path $PROFILE

# Check execution policy
Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Performance Optimization

If the profile loads slowly:

1. **Disable Unused Segments**: Remove segments you don't need from the theme
2. **Reduce Git Fetch Operations**: Set `fetch_status: false` in git segment
3. **Limit Right Prompt**: Remove unused development environment segments

```json
{
  "properties": {
    "fetch_status": false,
    "fetch_stash_count": false,
    "fetch_upstream_icon": false
  }
}
```

## Dependencies

### Required
- **PowerShell 7+**: Modern PowerShell with cross-platform support
- **Oh My Posh**: Prompt theme engine (`winget install JanDeDobbeleer.OhMyPosh`)

### Optional
- **Nerd Fonts**: For proper icon display in the theme
- **fnm**: Fast Node Manager for Node.js version management
- **Git**: Version control system for Git segment functionality
- **VSCode**: For `backup-vs` function and `sln` function integration

### Development Tools
The theme automatically detects and displays versions for:
- .NET SDK, Node.js, Python, Go, Rust, Java
- Azure CLI, AWS CLI, kubectl
- Various development frameworks and build tools

## Contributing

To enhance the PowerShell configuration:

1. **Profile Functions**: Add utility functions to `Microsoft.PowerShell_profile.ps1`
2. **Theme Segments**: Add new segments or modify existing ones in `.theme.omp.json`
3. **Documentation**: Update this README with new features and usage examples
4. **Testing**: Test changes across different development environments

### Best Practices
- Add comprehensive help documentation for new functions
- Include error handling and validation
- Test with different PowerShell versions
- Ensure cross-platform compatibility where possible
- Keep the theme performant by avoiding expensive operations

## Resources

- [Oh My Posh Documentation](https://ohmyposh.dev/)
- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [PSReadLine Documentation](https://docs.microsoft.com/en-us/powershell/module/psreadline/)
- [Fast Node Manager (fnm)](https://github.com/Schniz/fnm)

This configuration transforms PowerShell into a powerful, modern development environment with visual feedback, productivity enhancements, and seamless tool integration.