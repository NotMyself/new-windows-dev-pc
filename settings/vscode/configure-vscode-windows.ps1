[CmdletBinding()]
param(
    [switch]$Force
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

try {
    Write-Host "Configuring VSCode..." -ForegroundColor Cyan
    $vscodeUserDir = "$env:APPDATA\Code\User"
    
    $settingsSuccess = New-ConfigLink -LinkPath "$vscodeUserDir\settings.json" -TargetPath "$PSScriptRoot\settings.json" -Description "VSCode settings"
    $keybindingsSuccess = New-ConfigLink -LinkPath "$vscodeUserDir\keybindings.json" -TargetPath "$PSScriptRoot\keybindings.json" -Description "VSCode keybindings"
    
    if ($settingsSuccess -and $keybindingsSuccess) {
        Write-Host "  VSCode configuration completed successfully" -ForegroundColor Green
    } else {
        Write-Warning "  VSCode configuration had some issues"
    }
}
catch {
    Write-Error "VSCode configuration failed: $($_.Exception.Message)"
    exit 1
}