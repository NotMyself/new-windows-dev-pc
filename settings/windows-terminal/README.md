# Windows Terminal Configuration

Custom Windows Terminal settings optimized for development workflows with enhanced themes, typography, and productivity-focused keybindings.

## Overview

This configuration provides a modern terminal experience with:
- **Developer-Optimized Typography**: CaskaydiaCove Nerd Font for programming ligatures and symbols
- **Dark Theme**: One Half Dark color scheme for reduced eye strain
- **Enhanced Productivity**: Custom keybindings for efficient workflow management
- **Profile Management**: Curated shell profiles with appropriate visibility settings
- **Visual Polish**: Subtle transparency and modern styling

## Configuration Features

### Typography and Visual Design

- **Font**: CaskaydiaCove Nerd Font Mono (size 12) - Includes programming ligatures and developer icons
- **Color Scheme**: One Half Dark - Professional dark theme with excellent contrast
- **Transparency**: 95% opacity with acrylic effects disabled for performance
- **Cursor**: Bar-style cursor for precise text editing
- **Padding**: 8px uniform padding for comfortable spacing
- **Window Size**: 120 columns × 30 rows for optimal screen utilization

### Enhanced Keybindings

#### Tab Management
| Keybinding | Action | Description |
|------------|--------|--------------|
| `Ctrl+T` | New Tab | Open new terminal tab |
| `Ctrl+W` | Close Tab | Close current tab |
| `Ctrl+Tab` | Next Tab | Switch to next tab |
| `Ctrl+Shift+Tab` | Previous Tab | Switch to previous tab |

#### Pane Operations
| Keybinding | Action | Description |
|------------|--------|--------------|
| `Alt+Shift+Plus` | Split Right | Split pane vertically |
| `Alt+Shift+Minus` | Split Down | Split pane horizontally |
| `Alt+Shift+D` | Duplicate Pane | Split with current profile |

#### Text Operations
| Keybinding | Action | Description |
|------------|--------|--------------|
| `Ctrl+C` | Copy | Copy selected text (multi-line support) |
| `Ctrl+V` | Paste | Paste clipboard content |
| `Ctrl+Shift+F` | Find | Open search dialog |

### Profile Configuration

#### Active Profiles
- **PowerShell** (Default) - Modern PowerShell Core for cross-platform compatibility
- **Azure Cloud Shell** - Direct Azure CLI access for cloud operations
- **Command Prompt** - Legacy Windows command line when needed

#### Hidden Profiles
- **Windows PowerShell** - Legacy PowerShell 5.1 (hidden to promote PowerShell 7+ usage)
- **Visual Studio Debug Console** - Development debugging console (hidden to reduce clutter)

### Performance Optimizations

- **Bell Style**: Disabled for distraction-free development
- **Acrylic Effects**: Disabled for better performance
- **Scrollbar**: Always visible for navigation feedback
- **Copy Formatting**: Disabled to prevent formatting issues in code
- **Copy on Select**: Disabled to prevent accidental clipboard changes

## Integration with Development Setup

### PowerShell Profile Integration

This Windows Terminal configuration works seamlessly with the enhanced PowerShell profile:
- **Oh My Posh Themes**: Custom prompt themes displayed with proper font support
- **Git Integration**: Enhanced Git status and branch information in terminal
- **Developer Tools**: Integrated fnm, Azure CLI, and other development tools
- **Unix-like Commands**: Familiar command aliases for cross-platform development

### Font Requirements

The configuration uses **CaskaydiaCove Nerd Font Mono**, which is automatically installed by the setup scripts:
- **Installation**: Included in `fonts/CascadiaCode.zip` and installed by `install.ps1`
- **Features**: Programming ligatures, developer icons, and optimal character spacing
- **Compatibility**: Works across all terminal applications and code editors

### Symbolic Link Management

The `configure.ps1` script creates symbolic links for dual-location support:

```powershell
# Standard installation path
$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json

# Microsoft Store installation path  
$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json
```

**Benefits**:
- **Version Control**: Configuration changes tracked in Git
- **Consistency**: Same settings across Windows Terminal installation methods
- **Backup**: Automatic backup through repository versioning
- **Portability**: Easy replication across development machines

## Installation and Usage

### Automatic Installation

The Windows Terminal configuration is automatically installed when running the setup scripts:

```powershell
# Install Windows Terminal (if not present)
.\install.ps1

# Configure Windows Terminal settings
.\configure.ps1
```

### Manual Configuration

To apply configuration manually:

1. **Install Windows Terminal** (via Microsoft Store or WinGet)
2. **Install CaskaydiaCove Nerd Font** (included in repository fonts)
3. **Create symbolic link**:
   ```powershell
   # Navigate to repository root
   New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json" -Target ".\settings\windows-terminal\settings.json"
   ```

### Verification

After installation, verify the configuration:
1. **Open Windows Terminal** - Should use One Half Dark theme with CaskaydiaCove font
2. **Test Keybindings** - Try `Ctrl+T` for new tab, `Alt+Shift+Plus` for split pane
3. **Check Profiles** - PowerShell should be default, legacy profiles hidden
4. **Validate Font** - Should display programming ligatures and developer icons

## Customization

### Color Schemes

To modify the color scheme, edit the `colorScheme` property in the defaults section:
```json
"colorScheme": "One Half Dark"  // Change to preferred scheme
```

### Font Configuration

To adjust font settings:
```json
"font": {
    "face": "CaskaydiaCove Nerd Font Mono",
    "size": 12  // Adjust size as needed
}
```

### Keybinding Modifications

Add custom keybindings to the `keybindings` array:
```json
{
    "keys": "ctrl+shift+n",
    "command": "newWindow"
}
```

### Profile Management

To add new profiles or modify existing ones, edit the `profiles.list` array. Use `"hidden": false` to show profiles or `"hidden": true` to hide them.

## Troubleshooting

### Common Issues

| Issue | Symptoms | Solution |
|-------|----------|----------|
| **Font Not Applied** | Default font instead of CaskaydiaCove | Run `install.ps1` to install fonts, restart Windows Terminal |
| **Keybindings Not Working** | Keyboard shortcuts don't respond | Check for conflicting system keybindings, restart Windows Terminal |
| **Profile Missing** | Expected shell not visible | Verify shell installation, check `hidden` property in profile |
| **Theme Not Applied** | Light theme or wrong colors | Verify `colorScheme` and `theme` settings, restart Windows Terminal |
| **Settings Not Persistent** | Changes revert after restart | Ensure symbolic link was created correctly by `configure.ps1` |

### Manual Recovery

If automatic configuration fails:

```powershell
# Backup existing settings
Copy-Item "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json" "settings.json.backup"

# Copy configuration manually
Copy-Item ".\settings\windows-terminal\settings.json" "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json"
```

### Validation Commands

```powershell
# Check if Windows Terminal is installed
Get-AppxPackage Microsoft.WindowsTerminal

# Verify font installation
Get-ChildItem "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\*Cascadia*"

# Check symbolic link
Get-Item "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json" | Select-Object Target
```

## Related Documentation

- **[Main Setup Documentation](../../README.md)** - Complete Windows developer setup guide
- **[PowerShell Profile](../pwsh/README.md)** - Enhanced PowerShell configuration that integrates with Windows Terminal
- **[VSCode Settings](../vscode/README.md)** - Code editor configuration with integrated terminal
- **[Claude Code Integration](../claude/README.md)** - AI assistant configuration for development workflows

## Technical Specifications

**Configuration File**: `settings.json`  
**Schema Version**: Windows Terminal schema  
**Font Requirements**: CaskaydiaCove Nerd Font Mono  
**Supported Versions**: Windows Terminal 1.0+  
**Installation Methods**: Microsoft Store, WinGet, Direct Download  
**Profile Support**: PowerShell Core, Azure Cloud Shell, Command Prompt  
**Theme Support**: Built-in and custom color schemes