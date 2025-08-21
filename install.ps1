[CmdletBinding()]
param(
    [switch]$SkipWinGet,
    [switch]$SkipNpmPackages,
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

function Write-Header {
    param([string]$Message)
    Write-Host ""
    Write-Host $Message -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host ""
}

function Write-Step {
    param([string]$Message)
    Write-Host "• $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "  ✓ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "  ⚠ $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "  ✗ $Message" -ForegroundColor Red
}

function Write-Skipped {
    param([string]$Message)
    Write-Host "  - $Message" -ForegroundColor DarkGray
}

function Install-Fonts {
    param([string]$FontZipPath)
    
    try {
        if (-not (Test-Path $FontZipPath)) {
            Write-Warning "Font zip file not found: $FontZipPath"
            return
        }
        
        # Silent installation - output handled by main script
        
        # Create temporary directory for extraction
        $tempDir = Join-Path $env:TEMP "CascadiaCodeFonts"
        if (Test-Path $tempDir) {
            Remove-Item $tempDir -Recurse -Force
        }
        New-Item -Path $tempDir -ItemType Directory -Force | Out-Null
        
        # Extract fonts
        Expand-Archive -Path $FontZipPath -DestinationPath $tempDir -Force
        
        # Get font files
        $fontFiles = Get-ChildItem -Path $tempDir -Recurse -Include "*.ttf", "*.otf"
        
        if ($fontFiles.Count -eq 0) {
            Write-Warning "No font files found in the archive"
            return
        }
        
        # Install fonts
        $fontsInstalled = 0
        foreach ($fontFile in $fontFiles) {
            try {
                # Copy to Windows Fonts directory
                $fontName = $fontFile.Name
                $fontDestination = Join-Path $env:windir "Fonts\$fontName"
                
                if (-not (Test-Path $fontDestination)) {
                    Copy-Item $fontFile.FullName $fontDestination -Force
                    
                    # Register font in registry
                    $fontDisplayName = $fontFile.BaseName
                    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $fontDisplayName -Value $fontName -PropertyType String -Force | Out-Null
                    
                    $fontsInstalled++
                }
            }
            catch {
                Write-Warning "Failed to install font $($fontFile.Name): $($_.Exception.Message)"
            }
        }
        
        # Silent installation - status reported by main script
        
        # Cleanup
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
    catch {
        Write-Warning "Font installation failed: $($_.Exception.Message)"
    }
}

try {
    Write-Header " Developer Setup Installation "
    Write-Host "Automated installation of development tools and configurations" -ForegroundColor Gray
    
    $totalSteps = 5
    $currentStep = 0
    
    # Step 1: WinGet
    $currentStep++
    Write-Header " Step ${currentStep}/${totalSteps}: Package Manager "
    if (-not $SkipWinGet -and -not (Test-Command 'winget')) {
        Write-Step "Installing WinGet package manager"
        & "$PSScriptRoot\installs\install-winget.ps1" | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Success "WinGet installed"
        } else {
            Write-Error "WinGet installation failed"
            throw "Failed to install WinGet"
        }
    } elseif (-not $SkipWinGet) {
        Write-Success "WinGet already available"
    } else {
        Write-Skipped "WinGet installation skipped"
    }
    
    # Step 2: Development Tools
    $currentStep++
    Write-Header " Step ${currentStep}/${totalSteps}: Development Tools "
    if (-not $SkipWinGet) {
        Write-Step "Installing development tools via WinGet"
        
        # Run WinGet script silently and show only clean progress
        Write-Host "  This may take several minutes..." -ForegroundColor Gray
        
        # Capture all output but don't display the messy parts
        $wingetResult = & "$PSScriptRoot\installs\winget.ps1" *>&1 | Out-String
        
        # Parse the output for meaningful information
        $installCount = 0
        $skipCount = 0
        $errorCount = 0
        
        # Count successful installations, skips, and errors from the final result
        if ($wingetResult -match "✓") {
            $installCount = ([regex]::Matches($wingetResult, "✓")).Count
        }
        if ($wingetResult -match "Skipping") {
            $skipCount = ([regex]::Matches($wingetResult, "Skipping")).Count  
        }
        if ($wingetResult -match "✗|Failed") {
            $errorCount = ([regex]::Matches($wingetResult, "✗|Failed")).Count
        }
        
        # Show clean summary
        if ($installCount -gt 0) {
            Write-Host "  ✓ $installCount tools installed" -ForegroundColor Green
        }
        if ($skipCount -gt 0) {
            Write-Host "  - $skipCount tools skipped (already current)" -ForegroundColor Gray
        }
        if ($errorCount -gt 0) {
            Write-Host "  ⚠ $errorCount tools had issues" -ForegroundColor Yellow
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Development tools installation completed"
        } else {
            Write-Warning "Some tools may have failed (see details above)"
        }
    } else {
        Write-Skipped "Development tools installation skipped"
    }
    
    # Step 3: Fonts
    $currentStep++
    Write-Header " Step ${currentStep}/${totalSteps}: Developer Fonts "
    Write-Step "Installing Cascadia Code fonts"
    $fontZipPath = Join-Path $PSScriptRoot "fonts\CascadiaCode.zip"
    try {
        Install-Fonts -FontZipPath $fontZipPath
        Write-Success "Cascadia Code fonts installed"
    }
    catch {
        Write-Warning "Font installation failed"
    }
    
    # Step 4: NPM Packages
    $currentStep++
    Write-Header " Step ${currentStep}/${totalSteps}: Global NPM Packages "
    if (-not $SkipNpmPackages) {
        if (Test-Command 'fnm') {
            Write-Step "Installing global npm packages"
            
            # Run npm script with filtered output to show progress
            $npmOutput = & "$PSScriptRoot\installs\npm-global.ps1" 2>&1
            $npmOutput | ForEach-Object {
                $line = $_.ToString().Trim()
                # Show installation progress and results
                if ($line -match "Initializing|Installing|✓|✗|already|Failed|Error") {
                    Write-Host $line
                }
            }
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "NPM packages installation completed"
            } else {
                Write-Warning "Some npm packages may have failed (see details above)"
            }
        } else {
            Write-Warning "Fast Node Manager (fnm) not found"
            Write-Host "  Install fnm first, then run: .\installs\npm-global.ps1" -ForegroundColor Gray
        }
    } else {
        Write-Skipped "NPM packages installation skipped"
    }
    
    # Step 5: VSCode Extensions
    $currentStep++
    Write-Header " Step ${currentStep}/${totalSteps}: VSCode Extensions "
    if (-not $SkipExtensions) {
        if (Test-Command 'code') {
            Write-Step "Installing VSCode extensions"
            
            # Run VSCode script with filtered output to show progress
            $vscodeOutput = & "$PSScriptRoot\installs\vscode.ps1" 2>&1
            $vscodeOutput | ForEach-Object {
                $line = $_.ToString().Trim()
                # Filter out the main header but keep progress info
                if ($line -match "^Installing VSCode extensions from:" -or $line -match "^Found \d+ extensions") {
                    return
                }
                # Show installation progress and results
                elseif ($line -match "Installing|✓|✗|already|Failed|Error") {
                    Write-Host $line
                }
            }
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "VSCode extensions installation completed"
            } else {
                Write-Warning "Some extensions may have failed (see details above)"
            }
        } else {
            Write-Warning "VSCode not found"
            Write-Host "  Install VSCode first, then run: .\installs\vscode.ps1" -ForegroundColor Gray
        }
    } else {
        Write-Skipped "VSCode extensions installation skipped"
    }
    
    # Completion
    Write-Header " Installation Complete "
    Write-Host "✓ Setup process finished!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Step:" -ForegroundColor Cyan
    Write-Host "  Run .\configure.ps1 to set up configuration files" -ForegroundColor White
}
catch {
    Write-Host ""
    Write-Host " Installation Failed " -ForegroundColor White -BackgroundColor Red
    Write-Host ""
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Check the error details above and try running the script again." -ForegroundColor Gray
    exit 1
}
