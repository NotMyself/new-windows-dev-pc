[CmdletBinding()]
param(
    [string]$ExtensionsFile = "$PSScriptRoot\..\settings\vscode\extensions"
)

function Install-VSCodeExtension {
    param([string]$ExtensionId)
    
    if ([string]::IsNullOrWhiteSpace($ExtensionId) -or $ExtensionId.StartsWith('#')) {
        return # Skip empty lines and comments
    }
    
    Write-Host "  Installing extension: $ExtensionId" -ForegroundColor Cyan
    
    try {
        $result = & code --install-extension $ExtensionId --force 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    ✓ $ExtensionId installed successfully" -ForegroundColor Green
        } else {
            Write-Warning "    ✗ Failed to install $ExtensionId`: $result"
        }
    }
    catch {
        Write-Warning "    ✗ Error installing $ExtensionId`: $($_.Exception.Message)"
    }
}

try {
    # Check if VSCode is available
    if (-not (Get-Command 'code' -ErrorAction SilentlyContinue)) {
        Write-Error "VSCode CLI ('code') not found. Please ensure VSCode is installed and added to PATH."
        exit 1
    }
    
    # Check if extensions file exists
    if (-not (Test-Path $ExtensionsFile)) {
        Write-Error "Extensions file not found: $ExtensionsFile"
        exit 1
    }
    
    Write-Host "Installing VSCode extensions from: $ExtensionsFile" -ForegroundColor Green
    
    $extensions = Get-Content $ExtensionsFile | Where-Object { $_ -and -not $_.StartsWith('#') }
    $totalExtensions = $extensions.Count
    
    Write-Host "Found $totalExtensions extensions to install`n"
    
    $extensions | ForEach-Object {
        Install-VSCodeExtension $_
    }
    
    Write-Host "`nVSCode extension installation completed!" -ForegroundColor Green
    Write-Host "Use 'backup-vs' function in PowerShell to update the extensions list." -ForegroundColor Yellow
}
catch {
    Write-Error "VSCode extension installation failed: $($_.Exception.Message)"
    exit 1
}