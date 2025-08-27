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
    Write-Host "Configuring Markdownlint..." -ForegroundColor Cyan
    $success = New-ConfigLink -LinkPath "$HOME\.markdownlint.json" -TargetPath "$PSScriptRoot\.markdownlint.json" -Description "Markdownlint configuration"
    
    if ($success) {
        Write-Host "  Markdownlint configuration completed successfully" -ForegroundColor Green
    } else {
        Write-Warning "  Markdownlint configuration had issues"
    }
}
catch {
    Write-Error "Markdownlint configuration failed: $($_.Exception.Message)"
    exit 1
}