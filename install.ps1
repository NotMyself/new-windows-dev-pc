[CmdletBinding()]
param(
    [switch]$SkipWinGet,
    [switch]$SkipExtensions
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

function Test-Command {
    param([string]$CommandName)
    return [bool](Get-Command -Name $CommandName -ErrorAction SilentlyContinue)
}

function Write-Step {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor Cyan
}

try {
    Write-Step "Starting developer setup installation..."
    
    # Install WinGet if not present and not skipped
    if (-not $SkipWinGet -and -not (Test-Command 'winget')) {
        Write-Step "Installing WinGet package manager..."
        & "$PSScriptRoot\installs\install-winget.ps1"
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to install WinGet"
        }
    }
    
    # Install Tools via WinGet
    if (-not $SkipWinGet) {
        Write-Step "Installing development tools via WinGet..."
        & "$PSScriptRoot\installs\winget.ps1"
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Some WinGet installations may have failed. Check the output above."
        }
    }
    
    # Install VSCode Extensions
    if (-not $SkipExtensions -and (Test-Command 'code')) {
        Write-Step "Installing VSCode extensions..."
        & "$PSScriptRoot\installs\vscode.ps1"
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Some VSCode extensions may have failed to install. Check the output above."
        }
    } elseif (-not $SkipExtensions) {
        Write-Warning "VSCode not found. Skipping extension installation. Install VSCode and run './installs/vscode.ps1' manually."
    }
    
    Write-Step "Installation completed successfully!"
    Write-Host "Next step: Run './configure.ps1' to set up configuration files." -ForegroundColor Green
}
catch {
    Write-Error "Installation failed: $($_.Exception.Message)"
    exit 1
}
