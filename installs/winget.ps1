[CmdletBinding()]
param(
    [string[]]$SkipPackages = @(),
    [switch]$IncludeBrowsers
)

function Install-WinGetPackage {
    param(
        [string]$PackageId,
        [string]$Description,
        [string]$Override = $null
    )
    
    if ($SkipPackages -contains $PackageId) {
        Write-Host "  Skipping $Description ($PackageId)" -ForegroundColor Yellow
        return
    }
    
    Write-Host "  Installing $Description..." -ForegroundColor Cyan
    
    try {
        $args = @('install', $PackageId, '--accept-source-agreements', '--accept-package-agreements', '--silent')
        if ($Override) {
            $args += '--override', $Override
        }
        
        $result = & winget @args 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    ✓ $Description installed successfully" -ForegroundColor Green
        } elseif ($result -match "already installed") {
            Write-Host "    ✓ $Description already installed" -ForegroundColor Green
        } else {
            Write-Warning "    ✗ Failed to install $Description`: $result"
        }
    }
    catch {
        Write-Warning "    ✗ Error installing $Description`: $($_.Exception.Message)"
    }
}

function Write-Category {
    param([string]$Category)
    Write-Host "`n$Category" -ForegroundColor Magenta
    Write-Host ("-" * $Category.Length) -ForegroundColor Magenta
}

try {
    Write-Host "Installing development tools via WinGet..." -ForegroundColor Green
    
    # Browsers (optional)
    if ($IncludeBrowsers) {
        Write-Category "Browsers"
        Install-WinGetPackage "Microsoft.Edge.Beta" "Microsoft Edge Beta"
        Install-WinGetPackage "Google.Chrome.Beta" "Google Chrome Beta"
        Install-WinGetPackage "Mozilla.Firefox.DeveloperEdition" "Firefox Developer Edition"
    }
    
    # Windows and CLI Tools
    Write-Category "Windows & CLI Tools"
    Install-WinGetPackage "Microsoft.PowerToys" "PowerToys"
    Install-WinGetPackage "Microsoft.WindowsTerminal" "Windows Terminal"
    Install-WinGetPackage "Microsoft.PowerShell" "PowerShell 7+"
    Install-WinGetPackage "JanDeDobbeleer.OhMyPosh" "Oh My Posh"
    
    # Version Control
    Write-Category "Version Control"
    Install-WinGetPackage "Git.Git" "Git"
    Install-WinGetPackage "GitHub.GitLFS" "Git LFS"
    Install-WinGetPackage "GitHub.cli" "GitHub CLI"
    
    # Development Environment
    Write-Category "Development Environment"
    Install-WinGetPackage "Microsoft.dotnet" ".NET SDK"
    Install-WinGetPackage "Schniz.fnm" "Fast Node Manager"
    Install-WinGetPackage "Anthropic.Claude" "Claude AI"
    Install-WinGetPackage "Microsoft.AzureCLI" "Azure CLI"
    
    # IDEs and Editors
    Write-Category "IDEs & Editors"
    
    # Check if VS config exists before installing VS
    $vsConfigPath = "$PSScriptRoot\..\settings\visual-studio\.vsconfig"
    if (Test-Path $vsConfigPath) {
        Install-WinGetPackage "Microsoft.VisualStudio.2022.Community" "Visual Studio 2022 Community" "--passive --config `"$vsConfigPath`""
    } else {
        Install-WinGetPackage "Microsoft.VisualStudio.2022.Community" "Visual Studio 2022 Community"
    }
    
    Install-WinGetPackage "Microsoft.VisualStudioCode" "Visual Studio Code"
    Install-WinGetPackage "Microsoft.VisualStudioCode.CLI" "VSCode CLI"
    Install-WinGetPackage "Microsoft.SQLServerManagementStudio" "SQL Server Management Studio"
    Install-WinGetPackage "Microsoft.AzureDataStudio.Insiders" "Azure Data Studio Insiders"
    Install-WinGetPackage "JetBrains.Toolbox" "JetBrains Toolbox"
    
    Write-Host "`nWinGet package installation completed!" -ForegroundColor Green
}
catch {
    Write-Error "WinGet installation failed: $($_.Exception.Message)"
    exit 1
}
