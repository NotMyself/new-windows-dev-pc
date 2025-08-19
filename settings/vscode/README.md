# VSCode Configuration

This directory contains a comprehensive Visual Studio Code configuration optimized for modern development workflows on Windows. The configuration provides a unified development environment with enhanced productivity features, consistent formatting, and powerful extensions for full-stack development.

## Overview

This VSCode configuration provides:
- **Enhanced Visual Experience**: Custom fonts with ligatures, optimized sizing, and improved readability
- **Productivity Enhancements**: Smart formatting, code completion, and integrated terminal optimization
- **Development Tools**: Comprehensive extension suite for JavaScript/TypeScript, .NET, Docker, and more
- **Git Integration**: Advanced GitLens features and streamlined version control workflows
- **PowerShell Integration**: Optimized PowerShell development with formatting and syntax highlighting
- **Cross-Platform Support**: Docker, containers, and cloud development tools

## File Structure

```
settings/vscode/
├── README.md          # This documentation file
├── settings.json      # Main VSCode settings configuration
├── keybindings.json   # Custom keyboard shortcuts
└── extensions         # List of extensions to install
```

## Installation

These configuration files are installed via symbolic links when running the main setup script:

```powershell
# From repository root (requires Administrator privileges)
.\configure.ps1
```

This creates symbolic links:
- `settings.json` → `$env:APPDATA\Code\User\settings.json`
- `keybindings.json` → `$env:APPDATA\Code\User\keybindings.json`
- Extensions are installed via `installs\vscode.ps1`

## Settings Configuration

### Visual Appearance

```json
{
  "window.zoomLevel": 2,
  "workbench.sideBar.location": "right",
  "workbench.startupEditor": "none"
}
```

- **Zoom Level**: Set to 2 for better readability on high-DPI displays
- **Sidebar Position**: Moved to right for better code visibility
- **Startup Editor**: Disabled welcome screen for faster startup

### Editor Configuration

```json
{
  "editor.fontFamily": "Cascadia Code, Dank Monk",
  "editor.fontSize": 18,
  "editor.lineHeight": 1,
  "editor.tabSize": 2,
  "editor.fontLigatures": true,
  "editor.renderWhitespace": "all",
  "editor.renderControlCharacters": true,
  "editor.dragAndDrop": false,
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.smoothScrolling": true,
  "editor.minimap.enabled": false,
  "editor.wordWrap": "on",
  "editor.guides.bracketPairs": true,
  "editor.inlineSuggest.enabled": true
}
```

**Key Features:**
- **Cascadia Code Font**: Premium programming font with ligatures
- **Whitespace Visualization**: Shows all whitespace characters for better formatting control
- **Smooth Animations**: Enhanced cursor and scrolling animations
- **Bracket Pair Guides**: Visual guides for matching brackets
- **Inline Suggestions**: AI-powered code completion enabled
- **Disabled Minimap**: More screen space for code
- **Word Wrap**: Prevents horizontal scrolling

### Formatting Configuration

```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": false,
  "[javascript]": { "editor.formatOnSave": true },
  "[html]": { "editor.formatOnSave": true },
  "[typescript]": { "editor.formatOnSave": true },
  "[json]": { "editor.formatOnSave": true },
  "[xml]": { "editor.defaultFormatter": "DotJoshJohnson.xml" }
}
```

**Formatting Strategy:**
- **Prettier as Default**: Uses Prettier for most file types
- **Selective Auto-Format**: Only auto-formats web development files on save
- **Language-Specific Formatters**: XML uses dedicated XML formatter
- **Manual Control**: Other file types require manual formatting for precision

### Terminal Configuration

```json
{
  "terminal.integrated.fontFamily": "CaskaydiaCove NF",
  "terminal.integrated.fontSize": 12,
  "terminal.integrated.lineHeight": 1.2,
  "terminal.integrated.fontLigatures": true
}
```

- **Nerd Font**: CaskaydiaCove NF provides icons and symbols for terminal applications
- **Optimized Sizing**: Balanced readability and screen space usage
- **Ligatures**: Enhanced terminal text rendering

### PowerShell Integration

```json
{
  "powershell.codeFormatting.trimWhitespaceAroundPipe": true,
  "powershell.codeFormatting.useConstantStrings": true,
  "powershell.codeFormatting.useCorrectCasing": true,
  "powershell.powerShellAdditionalExePaths": {
    "PowerShell": "C:/Program Files/PowerShell/7/pwsh.exe"
  },
  "powershell.powerShellDefaultVersion": "PowerShell"
}
```

**PowerShell Features:**
- **Code Formatting**: Automatic formatting with PowerShell best practices
- **PowerShell 7**: Uses modern PowerShell 7 instead of Windows PowerShell 5.1
- **Consistent Casing**: Enforces proper PowerShell cmdlet casing
- **Clean Syntax**: Removes unnecessary whitespace around pipes

### Git and GitHub Configuration

```json
{
  "gitlens.views.branches.branches.layout": "list",
  "git.openRepositoryInParentFolders": "never",
  "git.confirmSync": false,
  "github.copilot.nextEditSuggestions.enabled": true
}
```

- **GitLens**: List view for better branch visualization
- **Repository Scope**: Prevents opening parent folder repositories
- **Streamlined Workflow**: Disabled sync confirmation for faster commits
- **GitHub Copilot**: Enhanced AI suggestions enabled

## Custom Keybindings

The configuration includes one custom keybinding for enhanced terminal workflow:

```json
[
  {
    "key": "shift+enter",
    "command": "workbench.action.terminal.runSelectedText",
    "when": "editorTextFocus && !findInputFocussed && !replaceInputFocussed"
  }
]
```

**Shift+Enter**: Run selected text in terminal
- Select code in any file
- Press Shift+Enter to execute in integrated terminal
- Works when editor is focused (not in find/replace mode)
- Ideal for testing code snippets and PowerShell commands

## Extensions

The configuration includes 31 carefully selected extensions organized by category:

### Development Core (8 extensions)
- **esbenp.prettier-vscode** - Code formatter for consistent styling
- **editorconfig.editorconfig** - Consistent coding styles across editors
- **dbaeumer.vscode-eslint** - JavaScript/TypeScript linting
- **christian-kohler.npm-intellisense** - NPM package IntelliSense
- **christian-kohler.path-intellisense** - File path autocompletion
- **pflannery.vscode-versionlens** - Package version information
- **wix.vscode-import-cost** - Display import statement costs
- **hjb2012.vscode-es6-string-html** - HTML syntax in template literals

### Git and Version Control (4 extensions)
- **eamodio.gitlens** - Advanced Git capabilities and visualization
- **piotrpalarz.vscode-gitignore-generator** - Generate .gitignore files
- **vsls-contrib.gistfs** - GitHub Gist integration
- **interactive-smartlog.interactive-smartlog** - Interactive Git history

### Microsoft Development (6 extensions)
- **ms-dotnettools.csdevkit** - C# development kit
- **ms-dotnettools.csharp** - C# language support
- **ms-dotnettools.vscode-dotnet-runtime** - .NET runtime management
- **ms-vscode.powershell** - PowerShell language support
- **ms-vscode.live-server** - Live development server
- **amodio.tsl-problem-matcher** - TypeScript problem matcher

### Cloud and Containers (5 extensions)
- **docker.docker** - Docker support
- **ms-azuretools.vscode-containers** - Container development
- **ms-azuretools.vscode-docker** - Docker integration
- **ms-vscode-remote.remote-containers** - Remote container development

### Documentation and Markdown (3 extensions)
- **davidanson.vscode-markdownlint** - Markdown linting
- **shd101wyy.markdown-preview-enhanced** - Enhanced markdown preview
- **mikestead.dotenv** - .env file syntax highlighting

### AI and Productivity (2 extensions)
- **github.copilot** - AI-powered code completion
- **github.copilot-chat** - AI chat integration

### Utilities (3 extensions)
- **vscode-icons-team.vscode-icons** - File and folder icons
- **humao.rest-client** - HTTP client for API testing
- **rpinski.shebang-snippets** - Shebang line snippets
- **dotjoshjohnson.xml** - XML language support

## Extension Management

### Installing Extensions

Extensions are automatically installed when running:

```powershell
# From repository root
.\install.ps1
```

Or manually:

```powershell
.\installs\vscode.ps1
```

### Backing Up Extensions

Use the PowerShell profile function to update the extensions list:

```powershell
# In PowerShell (after profile is loaded)
backup-vs
```

This function:
1. Gets all currently installed VSCode extensions
2. Updates the `settings/vscode/extensions` file
3. Commits changes to git (if in a git repository)

### Manual Extension Management

To add new extensions:
1. Install the extension in VSCode
2. Run `backup-vs` to update the extensions file
3. Commit the updated extensions list

To remove extensions:
1. Uninstall from VSCode
2. Run `backup-vs` to sync the extensions file
3. Commit the changes

## Productivity Features

### Code Formatting
- **Automatic Formatting**: Web development files (JS, TS, HTML, JSON) format on save
- **Prettier Integration**: Consistent code styling across projects
- **Language-Specific**: XML and PowerShell use specialized formatters

### AI-Powered Development
- **GitHub Copilot**: Code suggestions and completion
- **Copilot Chat**: Interactive AI assistance
- **Inline Suggestions**: Context-aware code recommendations

### Enhanced Git Workflow
- **GitLens**: Advanced blame, history, and branch visualization
- **Streamlined Operations**: Reduced confirmation dialogs
- **Branch Management**: List view for easier navigation

### Terminal Integration
- **PowerShell 7**: Modern PowerShell with enhanced features
- **Custom Shortcuts**: Shift+Enter to run selected code
- **Optimized Fonts**: Nerd fonts with icon support

### Development Environment
- **Multi-Language Support**: JavaScript, TypeScript, C#, PowerShell, Docker
- **Container Development**: Full Docker and remote container support
- **Cloud Integration**: Azure tools and services
- **API Testing**: Built-in REST client for API development

## Customization

### Modifying Settings

1. **Edit the source file**:
   ```powershell
   code settings\vscode\settings.json
   ```

2. **Test changes**: VSCode will automatically reload settings

3. **Commit changes**: Add modifications to version control

### Adding Custom Keybindings

1. **Edit keybindings**:
   ```powershell
   code settings\vscode\keybindings.json
   ```

2. **Follow VSCode keybinding format**:
   ```json
   {
     "key": "ctrl+shift+alt+t",
     "command": "workbench.action.terminal.new",
     "when": "terminalProcessSupported"
   }
   ```

### Extension Customization

1. **Install extensions** in VSCode UI or via command line
2. **Update extensions list**:
   ```powershell
   backup-vs
   ```
3. **Configure extension settings** in `settings.json`

### Font Customization

```json
{
  "editor.fontFamily": "'Your Font', Cascadia Code, Consolas, monospace",
  "terminal.integrated.fontFamily": "'Your Nerd Font', CaskaydiaCove NF"
}
```

**Font Requirements:**
- Editor fonts should be monospace
- Terminal fonts should be Nerd Fonts for icon support
- Include fallbacks for different systems

## Troubleshooting

### Settings Not Applied

1. **Check symbolic links**:
   ```powershell
   # Verify links exist
   Get-Item "$env:APPDATA\Code\User\settings.json" | Select-Object Target
   ```

2. **Re-run configuration**:
   ```powershell
   .\configure.ps1
   ```

### Extensions Not Installing

1. **Check VSCode is installed**: Ensure VSCode is in PATH
2. **Run extension installer**:
   ```powershell
   .\installs\vscode.ps1
   ```
3. **Manual installation**: Use VSCode Extensions view

### Font Issues

1. **Install required fonts**:
   - Cascadia Code (included with Windows Terminal)
   - CaskaydiaCove NF (Nerd Font variant)

2. **Verify font installation**: Check fonts appear in VSCode font picker

3. **Update font settings** if using different fonts

### PowerShell Integration Issues

1. **Verify PowerShell 7 installation**:
   ```powershell
   $PSVersionTable.PSVersion
   ```

2. **Check PowerShell path** in settings matches installation

3. **Install PowerShell extension** if not working

## Benefits for Development Teams

### Consistency
- **Unified Configuration**: All developers use identical settings
- **Predictable Behavior**: Same extensions and formatting across team
- **Version Controlled**: Configuration changes tracked in git

### Productivity
- **Optimized Workflow**: Settings designed for maximum efficiency
- **AI Integration**: GitHub Copilot for faster development
- **Smart Formatting**: Automatic code formatting for web technologies

### Developer Experience
- **Enhanced Visuals**: High-quality fonts and optimized display settings
- **Powerful Extensions**: Comprehensive toolset for modern development
- **Streamlined Setup**: One-command installation for new developers

This VSCode configuration provides a robust, production-ready development environment that enhances productivity while maintaining consistency across development teams.