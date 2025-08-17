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
    
    Write-Step "Configuration completed successfully!"
    Write-Host "Restart your terminal and VSCode to apply the new settings." -ForegroundColor Green
}
catch {
    Write-Error "Configuration failed: $($_.Exception.Message)"
    exit 1
}
