[CmdletBinding()]
param(
    [switch]$Force
)

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script requires Administrator privileges. Requesting elevation..." -ForegroundColor Yellow
    
    # Get the current script path and arguments
    $scriptPath = $MyInvocation.MyCommand.Path
    $arguments = ""
    
    # Build argument string from bound parameters
    foreach ($param in $PSBoundParameters.GetEnumerator()) {
        if ($param.Value -is [switch] -and $param.Value) {
            $arguments += " -$($param.Key)"
        } elseif ($param.Value -isnot [switch]) {
            $arguments += " -$($param.Key) '$($param.Value)'"
        }
    }
    
    try {
        # Start elevated process
        $process = Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"$arguments" -Verb RunAs -Wait -PassThru
        
        # Exit with the same code as the elevated process
        exit $process.ExitCode
    }
    catch {
        Write-Error "Failed to elevate privileges: $($_.Exception.Message)"
        Write-Host "Please run this script as Administrator manually." -ForegroundColor Red
        exit 1
    }
}

function Write-Step {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor Cyan
}

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
            Remove-Item $LinkPath -Force
        }
        
        # Create symbolic link
        New-Item -Force -Path $LinkPath -ItemType SymbolicLink -Value $TargetPath -ErrorAction Stop | Out-Null
        Write-Host "  ✓ $Description" -ForegroundColor Green
    }
    catch {
        Write-Warning "  ✗ Failed to create $Description`: $($_.Exception.Message)"
    }
}

try {
    Write-Step "Creating symbolic links for configuration files..."
    
    # Git Configuration
    Write-Host "Configuring Git..."
    New-ConfigLink -LinkPath "$HOME\.gitconfig" -TargetPath "$PSScriptRoot\settings\git\.gitconfig" -Description "Git configuration"
    
    # VSCode Configuration
    Write-Host "Configuring VSCode..."
    $vscodeUserDir = "$env:APPDATA\Code\User"
    New-ConfigLink -LinkPath "$vscodeUserDir\settings.json" -TargetPath "$PSScriptRoot\settings\vscode\settings.json" -Description "VSCode settings"
    New-ConfigLink -LinkPath "$vscodeUserDir\keybindings.json" -TargetPath "$PSScriptRoot\settings\vscode\keybindings.json" -Description "VSCode keybindings"
    
    # PowerShell Configuration
    Write-Host "Configuring PowerShell..."
    New-ConfigLink -LinkPath "$HOME\.theme.omp.json" -TargetPath "$PSScriptRoot\settings\pwsh\.theme.omp.json" -Description "Oh My Posh theme"
    New-ConfigLink -LinkPath $profile -TargetPath "$PSScriptRoot\settings\pwsh\Microsoft.PowerShell_profile.ps1" -Description "PowerShell profile"
    
    # Claude Code Configuration
    Write-Host "Configuring Claude Code..."
    $claudeConfigDir = "$HOME\.claude"
    New-ConfigLink -LinkPath "$claudeConfigDir\settings.json" -TargetPath "$PSScriptRoot\settings\claude-code\settings.json" -Description "Claude Code settings"
    New-ConfigLink -LinkPath "$claudeConfigDir\agents" -TargetPath "$PSScriptRoot\settings\claude\agents" -Description "Claude Code agents"
    New-ConfigLink -LinkPath "$claudeConfigDir\commands" -TargetPath "$PSScriptRoot\settings\claude\commands" -Description "Claude Code commands"
    New-ConfigLink -LinkPath "$claudeConfigDir\.mcp.json" -TargetPath "$PSScriptRoot\settings\claude\.mcp.json" -Description "MCP server configuration"
    
    # Hosts File Configuration (Development domains)
    Write-Host "Configuring hosts file for development domains..."
    $hostsFile = "$env:WINDIR\System32\drivers\etc\hosts"
    $devHosts = "$PSScriptRoot\settings\etc\hosts"
    
    if (Test-Path $devHosts) {
        try {
            # Read current hosts file
            $currentHosts = Get-Content $hostsFile -ErrorAction SilentlyContinue
            $devHostsContent = Get-Content $devHosts
            
            # Check if dev domains are already present
            $needsUpdate = $false
            foreach ($line in $devHostsContent) {
                if ($line.Trim() -and -not $line.StartsWith('#') -and $currentHosts -notcontains $line) {
                    $needsUpdate = $true
                    break
                }
            }
            
            if ($needsUpdate -or $Force) {
                # Backup current hosts file
                Copy-Item $hostsFile "$hostsFile.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')" -Force
                
                # Add development domains if not present
                $updatedContent = $currentHosts + "`n# Development domains added by Windows Dev Setup" + $devHostsContent
                $updatedContent | Set-Content $hostsFile -Force
                Write-Host "  ✓ Development domains added to hosts file" -ForegroundColor Green
            } else {
                Write-Host "  ✓ Development domains already present in hosts file" -ForegroundColor Green
            }
        }
        catch {
            Write-Warning "  ✗ Failed to update hosts file: $($_.Exception.Message)"
            Write-Host "    You may need to manually add development domains from $devHosts" -ForegroundColor Yellow
        }
    }
    
    Write-Step "Configuration completed successfully!"
    Write-Host "Restart your terminal and VSCode to apply the new settings." -ForegroundColor Green
}
catch {
    Write-Error "Configuration failed: $($_.Exception.Message)"
    exit 1
}
