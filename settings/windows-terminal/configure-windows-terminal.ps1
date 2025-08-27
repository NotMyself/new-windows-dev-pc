[CmdletBinding()]
param(
    [switch]$Force,
    [switch]$EnableWindows11Features
)

function New-ConfigLink {
    param(
        [string]$LinkPath,
        [string]$TargetPath,
        [string]$Description
    )
    
    try {
        # Ensure target exists
        if (-not (Test-Path $TargetPath)) {
            throw "Target file does not exist: $TargetPath"
        }
        
        # Create parent directory if it doesn't exist
        $parentDir = Split-Path $LinkPath -Parent
        if ($parentDir -and -not (Test-Path $parentDir)) {
            New-Item -Path $parentDir -ItemType Directory -Force | Out-Null
        }
        
        # Remove existing link/file if Force is specified
        if ((Test-Path $LinkPath) -and $Force) {
            Remove-Item $LinkPath -Force -Recurse
        }
        
        # Create symbolic link
        New-Item -Force -Path $LinkPath -ItemType SymbolicLink -Value $TargetPath -ErrorAction Stop | Out-Null
        Write-Host "  ✓ $Description" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Warning "  ✗ Failed to create $Description - $($_.Exception.Message)"
        return $false
    }
}

function Install-WindowsTerminalFragment {
    param([string]$Description = "Windows Terminal fragment")
    
    # Check if Windows Terminal is available
    $IsWindowsTerminal = $env:WT_SESSION -or $env:TERM_PROGRAM -eq 'Windows Terminal'
    if (-not $IsWindowsTerminal) {
        Write-Host "  Windows Terminal not detected, skipping fragment installation" -ForegroundColor Yellow
        return $false
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
        
        Write-Host "  ✓ $Description installed" -ForegroundColor Green
        return $true
    } catch {
        Write-Warning "  ✗ Failed to install $Description - $($_.Exception.Message)"
        return $false
    }
}

try {
    Write-Host "Configuring Windows Terminal..." -ForegroundColor Cyan
    
    # Standard configuration
    $standardSuccess = New-ConfigLink -LinkPath "$env:LOCALAPPDATA\Microsoft\Windows Terminal\settings.json" -TargetPath "$PSScriptRoot\settings.json" -Description "Windows Terminal settings (standard)"
    
    # Package configuration for Store installations
    $packageSuccess = $false
    $terminalPackage = Get-ChildItem -Path "$env:LOCALAPPDATA\Packages" -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "Microsoft.WindowsTerminal*_8wekyb3d8bbwe" } | Select-Object -First 1
    if ($terminalPackage) {
        $terminalConfigDir = "$($terminalPackage.FullName)\LocalState"
        $packageSuccess = New-ConfigLink -LinkPath "$terminalConfigDir\settings.json" -TargetPath "$PSScriptRoot\settings.json" -Description "Windows Terminal settings (package)"
    }
    
    # Windows 11 Enhanced Features
    $fragmentSuccess = $false
    if ($EnableWindows11Features) {
        $fragmentSuccess = Install-WindowsTerminalFragment -Description "Claude Code Windows Terminal theme"
    }
    
    if ($standardSuccess -or $packageSuccess) {
        Write-Host "  Windows Terminal configuration completed successfully" -ForegroundColor Green
        if ($EnableWindows11Features -and $fragmentSuccess) {
            Write-Host "  Windows 11 enhanced features applied" -ForegroundColor Green
        }
    } else {
        Write-Warning "  Windows Terminal configuration had issues"
    }
}
catch {
    Write-Error "Windows Terminal configuration failed: $($_.Exception.Message)"
    exit 1
}