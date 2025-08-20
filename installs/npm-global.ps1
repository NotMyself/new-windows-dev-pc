[CmdletBinding()]
param(
    [string]$PackagesFile = "$PSScriptRoot\..\settings\npm\global-packages"
)

function Test-Command {
    param([string]$CommandName)
    return [bool](Get-Command -Name $CommandName -ErrorAction SilentlyContinue)
}

function Install-GlobalNpmPackage {
    param([string]$PackageName)
    
    if ([string]::IsNullOrWhiteSpace($PackageName) -or $PackageName.StartsWith('#')) {
        return # Skip empty lines and comments
    }
    
    Write-Host "  Installing package: $PackageName" -ForegroundColor Cyan
    
    try {
        $result = & npm install -g $PackageName 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    ✓ $PackageName installed successfully" -ForegroundColor Green
        } else {
            Write-Warning "    ✗ Failed to install $PackageName`: $result"
        }
    }
    catch {
        Write-Warning "    ✗ Error installing $PackageName`: $($_.Exception.Message)"
    }
}

function Initialize-NodeEnvironment {
    Write-Host "Initializing Node.js environment..." -ForegroundColor Green
    
    # Check if fnm is available
    if (-not (Test-Command 'fnm')) {
        Write-Error "fnm (Fast Node Manager) not found. Please ensure fnm is installed first."
        exit 1
    }
    
    try {
        # Install and use LTS Node.js
        Write-Host "  Installing Node.js LTS via fnm..." -ForegroundColor Cyan
        & fnm install --lts 2>&1 | Out-Null
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    ✓ Node.js LTS installed successfully" -ForegroundColor Green
        } else {
            Write-Warning "    ✗ Failed to install Node.js LTS"
        }
        
        # Use LTS as default
        Write-Host "  Setting Node.js LTS as default..." -ForegroundColor Cyan
        & fnm use --install-if-missing lts-latest 2>&1 | Out-Null
        & fnm default lts-latest 2>&1 | Out-Null
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    ✓ Node.js LTS set as default" -ForegroundColor Green
        } else {
            Write-Warning "    ✗ Failed to set Node.js LTS as default"
        }
        
        # Refresh environment for current session
        & fnm env --use-on-cd | Out-String | Invoke-Expression
        
        # Verify npm is available
        if (-not (Test-Command 'npm')) {
            Write-Error "npm not found after Node.js initialization. Check fnm configuration."
            exit 1
        }
        
        $nodeVersion = & node --version 2>&1
        $npmVersion = & npm --version 2>&1
        Write-Host "    ✓ Node.js: $nodeVersion, npm: $npmVersion" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to initialize Node.js environment: $($_.Exception.Message)"
        exit 1
    }
}

try {
    # Initialize Node.js environment
    Initialize-NodeEnvironment
    
    # Check if packages file exists
    if (-not (Test-Path $PackagesFile)) {
        Write-Error "Packages file not found: $PackagesFile"
        exit 1
    }
    
    Write-Host "`nInstalling global npm packages from: $PackagesFile" -ForegroundColor Green
    
    $packages = Get-Content $PackagesFile | Where-Object { $_ -and -not $_.StartsWith('#') }
    $totalPackages = $packages.Count
    
    if ($totalPackages -eq 0) {
        Write-Host "No packages found to install." -ForegroundColor Yellow
        exit 0
    }
    
    Write-Host "Found $totalPackages packages to install`n"
    
    $packages | ForEach-Object {
        Install-GlobalNpmPackage $_
    }
    
    Write-Host "`nGlobal npm packages installation completed!" -ForegroundColor Green
    Write-Host "Use 'backup-npm' function in PowerShell to update the packages list." -ForegroundColor Yellow
}
catch {
    Write-Error "Global npm packages installation failed: $($_.Exception.Message)"
    exit 1
}