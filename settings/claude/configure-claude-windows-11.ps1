#Requires -Version 7.0
#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Configure Claude Code for optimal Windows 11 and PowerShell 7+ integration.

.DESCRIPTION
    This script configures Claude Code for Windows 11 with PowerShell 7+ features including:
    - Enhanced terminal integration with Windows Terminal
    - Advanced PowerShell 7+ features (predictive IntelliSense, cross-platform compatibility)
    - Windows 11 specific optimizations and WSL2 integration
    - Environment variable configuration and security
    - MCP (Model Context Protocol) server setup
    - Performance optimizations and best practices
    - Integration with Windows development tools

.PARAMETER Force
    Overwrite existing configurations without prompting

.PARAMETER SkipMCP
    Skip MCP server configuration

.PARAMETER SkipEnvironmentSetup
    Skip environment variable and PATH configuration

.EXAMPLE
    .\configure-claude-windows-11.ps1
    
.EXAMPLE
    .\configure-claude-windows-11.ps1 -Force

.NOTES
    Author: Generated for Windows 11 development environment
    Requires: PowerShell 7+, Windows 11, Administrator privileges
    Compatible with Claude Code native Windows support and WSL2
#>

[CmdletBinding()]
param(
    [switch]$Force,
    [switch]$SkipMCP,
    [switch]$SkipEnvironmentSetup
)

# Windows 11 and PowerShell 7+ feature detection
$IsWindows11 = [System.Environment]::OSVersion.Version.Build -ge 22000
$IsPowerShell7Plus = $PSVersionTable.PSVersion.Major -ge 7
$IsWindowsTerminal = $env:WT_SESSION -or $env:TERM_PROGRAM -eq 'Windows Terminal'

if (-not $IsPowerShell7Plus) {
    Write-Error "This script requires PowerShell 7 or later. Current version: $($PSVersionTable.PSVersion)"
    exit 1
}

function Write-Header {
    param([string]$Message, [string]$Color = 'Cyan')
    Write-Host ""
    Write-Host ("=" * 80) -ForegroundColor $Color
    Write-Host " $Message" -ForegroundColor White
    Write-Host ("=" * 80) -ForegroundColor $Color
    Write-Host ""
}

function Write-Step {
    param([string]$Message, [string]$Status = 'Info')
    $timestamp = Get-Date -Format 'HH:mm:ss'
    $colors = @{
        'Info' = 'Cyan'
        'Success' = 'Green'  
        'Warning' = 'Yellow'
        'Error' = 'Red'
        'Skipped' = 'DarkGray'
    }
    Write-Host "[$timestamp] " -ForegroundColor Gray -NoNewline
    Write-Host $Message -ForegroundColor $colors[$Status]
}

function Test-ClaudeCodeInstalled {
    $claudeCommand = Get-Command claude -ErrorAction SilentlyContinue
    $claudeNative = if (Test-Path "$env:LOCALAPPDATA\Programs\Claude\claude.exe") { "$env:LOCALAPPDATA\Programs\Claude\claude.exe" } else { $null }
    
    # Check for npm installation more safely
    $claudeNpm = $null
    if (Get-Command npx -ErrorAction SilentlyContinue) {
        try {
            # Use npm list instead of npx which to avoid hanging
            $npmList = npm list -g @anthropic-ai/claude-code --depth=0 2>$null
            if ($LASTEXITCODE -eq 0 -and $npmList -match "@anthropic-ai/claude-code") {
                $claudeNpm = "npm-global"
            }
        } catch {
            # Silently continue if npm check fails
        }
    }
    
    return [PSCustomObject]@{
        IsInstalled = [bool]($claudeCommand -or $claudeNative -or $claudeNpm)
        InstallPath = $claudeCommand.Source ?? $claudeNative ?? $claudeNpm ?? $null
        InstallType = if ($claudeNative) { 'Native' } elseif ($claudeNpm) { 'NPM' } elseif ($claudeCommand) { 'PATH' } else { 'None' }
    }
}

function Test-WSLInstalled {
    try {
        $wslInfo = wsl --status 2>$null
        return $LASTEXITCODE -eq 0 -and $wslInfo -match "running|stopped"
    } catch {
        return $false
    }
}

function Install-WindowsTerminalFragment {
    param([string]$FragmentPath)
    
    if (-not $IsWindowsTerminal) {
        Write-Step "Windows Terminal not detected, skipping terminal fragment installation" 'Warning'
        return
    }
    
    try {
        $wtFragmentsPath = "$env:LOCALAPPDATA\Microsoft\Windows Terminal\Fragments"
        New-Item -Path $wtFragmentsPath -ItemType Directory -Force | Out-Null
        
        $fragmentContent = @{
            "profiles" = @{
                "defaults" = @{
                    "colorScheme" = "Claude Code"
                    "font" = @{
                        "face" = "CascadiaCode Nerd Font"
                        "size" = 11
                        "features" = @{
                            "liga" = 1
                            "calt" = 1
                        }
                    }
                    "padding" = "8, 8, 8, 8"
                    "antialiasingMode" = "cleartype"
                    "cursorShape" = "filledBox"
                    "bellStyle" = @("window", "taskbar")
                }
                "list" = @(
                    @{
                        "guid" = "{574e775e-4f2a-5b96-ac1e-a2962a402336}"
                        "name" = "Claude Code (PowerShell)"
                        "commandline" = "pwsh.exe -NoLogo"
                        "icon" = "ms-appx:///ProfileIcons/pwsh.png"
                        "startingDirectory" = "%USERPROFILE%"
                        "tabTitle" = "Claude Dev"
                    }
                )
            }
            "schemes" = @(
                @{
                    "name" = "Claude Code"
                    "background" = "#1a1b26"
                    "foreground" = "#c0caf5"
                    "black" = "#15161e"
                    "red" = "#f7768e"
                    "green" = "#9ece6a"
                    "yellow" = "#e0af68"
                    "blue" = "#7aa2f7"
                    "purple" = "#bb9af7"
                    "cyan" = "#7dcfff"
                    "white" = "#a9b1d6"
                    "brightBlack" = "#414868"
                    "brightRed" = "#f7768e"
                    "brightGreen" = "#9ece6a"
                    "brightYellow" = "#e0af68"
                    "brightBlue" = "#7aa2f7"
                    "brightPurple" = "#bb9af7"
                    "brightCyan" = "#7dcfff"
                    "brightWhite" = "#c0caf5"
                }
            )
        }
        
        $fragmentJson = $fragmentContent | ConvertTo-Json -Depth 10
        $fragmentFile = Join-Path $wtFragmentsPath "claude-code.json"
        Set-Content -Path $fragmentFile -Value $fragmentJson -Encoding UTF8
        
        Write-Step "Windows Terminal fragment installed" 'Success'
    } catch {
        Write-Step "Failed to install Windows Terminal fragment: $($_.Exception.Message)" 'Error'
    }
}

function Set-PowerShellOptimizations {
    Write-Step "Configuring PowerShell 7+ optimizations for Claude Code"
    
    # Enhanced PSReadLine configuration for Windows 11
    $psReadLineConfig = @"
# PowerShell 7+ optimizations for Claude Code on Windows 11
if (`$PSVersionTable.PSVersion.Major -ge 7) {
    # Enhanced predictive IntelliSense (Windows 11 compatible)
    if (`$IsWindows -and [System.Environment]::OSVersion.Version.Build -ge 22000) {
        try {
            Set-PSReadLineOption -PredictionSource HistoryAndPlugin -WarningAction SilentlyContinue
            Set-PSReadLineOption -PredictionViewStyle ListView -WarningAction SilentlyContinue
        } catch {
            # Fallback for older terminal versions
            Set-PSReadLineOption -PredictionSource History -WarningAction SilentlyContinue
        }
    }
    
    # Enhanced editing features
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -BellStyle None
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineOption -ShowToolTips
    Set-PSReadLineOption -CompletionQueryItems 100
    
    # Windows 11 specific key bindings for Claude Code
    Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
    Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
    Set-PSReadLineKeyHandler -Chord 'Alt+d' -Function DeleteWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
    
    # Claude Code specific shortcuts
    Set-PSReadLineKeyHandler -Chord 'Ctrl+Shift+c' -ScriptBlock {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert('claude ')
    }
}

# Claude Code environment detection
function Test-ClaudeCodeEnvironment {
    return `$env:CLAUDE_SESSION -or `$env:ANTHROPIC_API_KEY -or (Get-Command claude -ErrorAction SilentlyContinue)
}

# Enhanced prompt for Claude Code integration
function prompt {
    `$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    `$principal = [Security.Principal.WindowsPrincipal] `$identity
    `$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
    
    `$prefix = if (`$principal.IsInRole(`$adminRole)) { "[ADMIN] " } else { "" }
    `$claudeIndicator = if (Test-ClaudeCodeEnvironment) { " 🤖" } else { "" }
    `$location = `$(Get-Location).Path.Replace(`$env:USERPROFILE, "~")
    
    Write-Host "`$prefix" -NoNewline -ForegroundColor Red
    Write-Host "`$location" -NoNewline -ForegroundColor Cyan
    Write-Host "`$claudeIndicator" -NoNewline -ForegroundColor Green
    return "> "
}
"@
    
    $profilePath = $PROFILE.CurrentUserAllHosts
    $profileDir = Split-Path $profilePath -Parent
    New-Item -Path $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
    
    if ($Force -or -not (Test-Path $profilePath) -or -not (Get-Content $profilePath -ErrorAction SilentlyContinue | Select-String "Claude Code optimizations")) {
        Add-Content -Path $profilePath -Value "`n# $($psReadLineConfig)" -Encoding UTF8
        Write-Step "PowerShell profile updated with Claude Code optimizations" 'Success'
    } else {
        Write-Step "PowerShell profile already configured" 'Skipped'
    }
}

function Set-ClaudeEnvironmentVariables {
    if ($SkipEnvironmentSetup) {
        Write-Step "Skipping environment variable setup" 'Skipped'
        return
    }
    
    Write-Step "Configuring Claude Code environment variables"
    
    # Windows 11 optimized environment variables
    $envVars = @{
        'CLAUDE_SHELL' = 'pwsh'
        'CLAUDE_EDITOR' = 'code'
        'CLAUDE_PAGER' = 'less'
        'TERM' = 'xterm-256color'
        'COLORTERM' = 'truecolor'
        'FORCE_COLOR' = '1'
        'NO_UPDATE_NOTIFIER' = '1'
        'DISABLE_AUTOUPDATER' = '0'
        'CLAUDE_CONFIG_DIR' = "$env:USERPROFILE\.claude"
        'CLAUDE_AGENTS_PATH' = "$env:USERPROFILE\.claude\agents"
        'CLAUDE_TEMPLATES_PATH' = "$env:USERPROFILE\.claude\templates"
    }
    
    # Windows 11 specific paths
    $windowsPaths = @(
        "$env:LOCALAPPDATA\Programs\Claude"
        "$env:APPDATA\npm"
        "$env:USERPROFILE\.local\bin"
    )
    
    foreach ($var in $envVars.GetEnumerator()) {
        [System.Environment]::SetEnvironmentVariable($var.Key, $var.Value, 'User')
        Set-Item -Path "env:$($var.Key)" -Value $var.Value -Force
        Write-Step "Set environment variable: $($var.Key) = $($var.Value)" 'Success'
    }
    
    # Update PATH for Windows 11
    $currentPath = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
    $pathsToAdd = $windowsPaths | Where-Object { Test-Path $_ -ErrorAction SilentlyContinue }
    
    foreach ($pathToAdd in $pathsToAdd) {
        if ($currentPath -notlike "*$pathToAdd*") {
            $newPath = "$currentPath;$pathToAdd"
            [System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')
            $env:PATH = "$env:PATH;$pathToAdd"
            Write-Step "Added to PATH: $pathToAdd" 'Success'
        }
    }
}

function Set-ClaudeCodeMCPServers {
    if ($SkipMCP) {
        Write-Step "Skipping MCP server configuration" 'Skipped'
        return
    }
    
    Write-Step "Configuring MCP (Model Context Protocol) servers for Windows 11"
    
    $claudeConfigDir = "$env:USERPROFILE\.claude"
    New-Item -Path $claudeConfigDir -ItemType Directory -Force | Out-Null
    
    # Windows 11 optimized MCP server configuration
    $mcpConfig = @{
        'mcpServers' = @{
            'filesystem' = @{
                'command' = 'npx'
                'args' = @('@modelcontextprotocol/server-filesystem')
                'env' = @{
                    'ALLOWED_DIRECTORIES' = "$env:USERPROFILE\src;$env:USERPROFILE\Documents;$env:USERPROFILE\Desktop"
                }
            }
            'memory' = @{
                'command' = 'npx'
                'args' = @('-y', '@modelcontextprotocol/server-memory')
            }
            'sequential-thinking' = @{
                'command' = 'npx'
                'args' = @('-y', '@modelcontextprotocol/server-sequential-thinking')
            }
            'context7' = @{
                'command' = 'npx'
                'args' = @('-y', '@upstash/context7-mcp')
            }
        }
    }
    
    $settingsPath = Join-Path $claudeConfigDir 'settings.json'
    $existingSettings = @{}
    
    if (Test-Path $settingsPath) {
        try {
            $existingSettings = Get-Content $settingsPath -Raw | ConvertFrom-Json -AsHashtable
        } catch {
            Write-Step "Could not parse existing settings, creating new configuration" 'Warning'
        }
    }
    
    # Merge MCP configuration with existing settings
    if ($existingSettings.mcpServers) {
        foreach ($server in $mcpConfig.mcpServers.GetEnumerator()) {
            $existingSettings.mcpServers[$server.Key] = $server.Value
        }
    } else {
        $existingSettings['mcpServers'] = $mcpConfig.mcpServers
    }
    
    $existingSettings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
    Write-Step "MCP servers configured successfully" 'Success'
}

function Install-ClaudeCodeNative {
    Write-Step "Checking for native Claude Code installation on Windows 11"
    
    $claudeStatus = Test-ClaudeCodeInstalled
    
    if ($claudeStatus.IsInstalled) {
        Write-Step "Claude Code already installed ($($claudeStatus.InstallType)): $($claudeStatus.InstallPath)" 'Success'
        return
    }
    
    Write-Step "Installing Claude Code via npm (recommended for Windows 11)"
    
    # Check for Node.js and npm
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        Write-Step "Node.js not found. Please install Node.js first." 'Error'
        return
    }
    
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Step "npm not found. Please install npm first." 'Error'  
        return
    }
    
    try {
        Write-Step "Running: npm install -g @anthropic-ai/claude-code"
        $installResult = npm install -g @anthropic-ai/claude-code 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Step "Claude Code installed successfully via npm" 'Success'
            
            # Verify installation
            $newStatus = Test-ClaudeCodeInstalled
            if ($newStatus.IsInstalled) {
                Write-Step "Installation verified: $($newStatus.InstallPath)" 'Success'
            }
        } else {
            Write-Step "npm installation failed: $installResult" 'Error'
        }
    } catch {
        Write-Step "Failed to install Claude Code: $($_.Exception.Message)" 'Error'
    }
}

function Set-WSLIntegration {
    if (-not (Test-WSLInstalled)) {
        Write-Step "WSL not installed, skipping WSL integration" 'Warning'
        Write-Step "To install WSL: Run 'wsl --install' in an elevated PowerShell" 'Info'
        return
    }
    
    Write-Step "Configuring WSL2 integration for Claude Code"
    
    # Create WSL bridge script for seamless integration
    $wslBridgeScript = @'
#!/bin/bash
# WSL Claude Code Bridge Script for Windows 11
# This script provides seamless integration between Windows and WSL environments

# Function to start Claude Code in WSL with Windows integration
claude-wsl() {
    local windows_path=""
    if [[ $1 =~ ^/mnt/[a-z]/.* ]]; then
        # Already a WSL path pointing to Windows
        windows_path="$1"
    elif [[ $1 =~ ^[A-Za-z]:.* ]]; then
        # Windows path format - convert to WSL format
        drive_letter=$(echo "$1" | cut -c1 | tr '[:upper:]' '[:lower:]')
        path_part=$(echo "$1" | cut -c3- | sed 's|\\|/|g')
        windows_path="/mnt/$drive_letter/$path_part"
    else
        # Relative or Linux path - use as is
        windows_path="$1"
    fi
    
    # Set Windows 11 optimized environment variables
    export TERM=xterm-256color
    export COLORTERM=truecolor
    export FORCE_COLOR=1
    
    # Launch Claude Code with Windows integration
    claude "${windows_path:-$(pwd)}"
}

# Alias for convenience
alias claude-win='claude-wsl'

# Add Windows directories to PATH if they exist
if [[ -d "/mnt/c/Users/$USER/AppData/Local/Programs/Claude" ]]; then
    export PATH="$PATH:/mnt/c/Users/$USER/AppData/Local/Programs/Claude"
fi

# Integration with Windows PowerShell
powershell() {
    powershell.exe "$@"
}

pwsh() {
    pwsh.exe "$@"
}
'@
    
    try {
        # Install the bridge script in WSL
        $tempScript = New-TemporaryFile
        Set-Content -Path $tempScript.FullName -Value $wslBridgeScript -Encoding UTF8
        
        wsl bash -c "mkdir -p ~/.local/bin"
        
        # Copy the script content to WSL using PowerShell-native method
        $scriptContent = Get-Content $tempScript.FullName -Raw
        $base64Content = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($scriptContent))
        wsl bash -c "echo '$base64Content' | base64 -d > ~/.local/bin/claude-bridge.sh"
        wsl bash -c "chmod +x ~/.local/bin/claude-bridge.sh"
        
        # Add to WSL bash profile
        wsl bash -c "echo 'source ~/.local/bin/claude-bridge.sh' >> ~/.bashrc"
        
        Remove-Item $tempScript.FullName
        Write-Step "WSL integration configured successfully" 'Success'
    } catch {
        Write-Step "Failed to configure WSL integration: $($_.Exception.Message)" 'Error'
    }
}

function Set-VSCodeIntegration {
    Write-Step "Configuring VS Code integration for Claude Code"
    
    $vscodeConfigDir = "$env:APPDATA\Code\User"
    if (-not (Test-Path $vscodeConfigDir)) {
        Write-Step "VS Code not installed or config directory not found" 'Warning'
        return
    }
    
    # VS Code settings for Claude Code integration
    $vscodeSettings = @{
        'claude-code.autoStart' = $true
        'claude-code.shell' = 'pwsh'
        'claude-code.enableWindowsTerminal' = $IsWindowsTerminal
        'claude-code.fontSize' = 12
        'claude-code.fontFamily' = 'Cascadia Code, Consolas, monospace'
        'claude-code.theme' = 'dark'
        'terminal.integrated.defaultProfile.windows' = 'PowerShell'
        'terminal.integrated.profiles.windows' = @{
            'PowerShell' = @{
                'source' = 'PowerShell'
                'args' = @('-NoLogo')
            }
        }
    }
    
    $settingsPath = Join-Path $vscodeConfigDir 'settings.json'
    $existingSettings = @{}
    
    if (Test-Path $settingsPath) {
        try {
            $existingSettings = Get-Content $settingsPath -Raw | ConvertFrom-Json -AsHashtable
        } catch {
            Write-Step "Could not parse VS Code settings, creating new configuration" 'Warning'
        }
    }
    
    # Merge settings
    foreach ($setting in $vscodeSettings.GetEnumerator()) {
        $existingSettings[$setting.Key] = $setting.Value
    }
    
    $existingSettings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
    Write-Step "VS Code integration configured" 'Success'
}

function Test-Configuration {
    Write-Step "Running configuration tests..."
    
    $tests = @(
        @{
            Name = "PowerShell Version"
            Test = { $PSVersionTable.PSVersion.Major -ge 7 }
            Expected = $true
        },
        @{
            Name = "Windows 11"
            Test = { $IsWindows11 }
            Expected = $true
        },
        @{
            Name = "Claude Code Installation"
            Test = { (Test-ClaudeCodeInstalled).IsInstalled }
            Expected = $true
        },
        @{
            Name = "Windows Terminal"
            Test = { $IsWindowsTerminal }
            Expected = $false # Optional
        },
        @{
            Name = "Claude Config Directory"
            Test = { Test-Path "$env:USERPROFILE\.claude" }
            Expected = $true
        },
        @{
            Name = "Environment Variables"
            Test = { $env:CLAUDE_SHELL -eq 'pwsh' }
            Expected = $true
        }
    )
    
    $passed = 0
    $total = $tests.Count
    
    foreach ($test in $tests) {
        $result = & $test.Test
        $status = if ($result -eq $test.Expected) { 
            $passed++; 'Success' 
        } elseif (-not $test.Expected) { 
            'Warning' 
        } else { 
            'Error' 
        }
        Write-Step "Test: $($test.Name) - $(if($result){'✓'}else{'✗'})" $status
    }
    
    Write-Step "Configuration tests completed: $passed/$total passed" 'Info'
}

# Main execution
try {
    Write-Header "Claude Code Configuration for Windows 11 & PowerShell 7+"
    
    Write-Step "Detected Configuration:" 'Info'
    Write-Step "  OS: $(if($IsWindows11){'Windows 11'}else{'Windows 10 or older'})" 'Info'
    Write-Step "  PowerShell: $($PSVersionTable.PSVersion)" 'Info'
    Write-Step "  Terminal: $(if($IsWindowsTerminal){'Windows Terminal'}else{'Legacy Console'})" 'Info'
    
    # Step 1: Install Claude Code
    Write-Header "Step 1: Claude Code Installation"
    Install-ClaudeCodeNative
    
    # Step 2: Environment Setup
    Write-Header "Step 2: Environment Configuration"
    Set-ClaudeEnvironmentVariables
    Set-PowerShellOptimizations
    
    # Step 3: Windows 11 Specific Features
    Write-Header "Step 3: Windows 11 Integration"
    if ($IsWindowsTerminal) {
        Install-WindowsTerminalFragment
    }
    Set-VSCodeIntegration
    
    # Step 4: WSL Integration
    Write-Header "Step 4: WSL Integration"
    Set-WSLIntegration
    
    # Step 5: MCP Server Configuration
    Write-Header "Step 5: MCP Server Configuration"
    Set-ClaudeCodeMCPServers
    
    # Step 6: Configuration Testing
    Write-Header "Step 6: Configuration Validation"
    Test-Configuration
    
    Write-Header "Configuration Complete!" 'Green'
    Write-Step "Claude Code is now configured for Windows 11 with PowerShell 7+" 'Success'
    Write-Step "" 'Info'
    Write-Step "Next Steps:" 'Info'
    Write-Step "  1. Restart your terminal to apply environment changes" 'Info'
    Write-Step "  2. Run 'claude --version' to verify installation" 'Info'
    Write-Step "  3. Set your ANTHROPIC_API_KEY environment variable" 'Info'
    Write-Step "  4. Try 'claude .' in a project directory to start coding!" 'Info'
    
    Write-Step "  5. In WSL, use 'claude-wsl' for Windows integration" 'Info'
    
} catch {
    Write-Step "Configuration failed: $($_.Exception.Message)" 'Error'
    Write-Step "Please check the error details and try again" 'Error'
    exit 1
}