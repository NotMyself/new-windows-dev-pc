# Source: https://github.com/cquresphere/WindowsInternals/blob/main/WinGet/Install-WinGetWithDependenciesAndLicense.ps1

<#
.SYNOPSIS
Installs the latest WinGet (Windows Package Manager) with dependencies and license files.

.DESCRIPTION
This script downloads and installs WinGet along with its required dependencies.
It requires Administrator privileges to run.
#>

[CmdletBinding()]
param()

# This script installs the latest WinGet (Windows Package Manager) with dependencies and license files.
$ProgressPreference = 'SilentlyContinue' # Hide Progressbar

function Write-Step {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor Cyan
}

try {
    Write-Step "Starting WinGet installation..."
    
    # Create download directory
    $downloadDir = "C:\WinGet"
    if (-not (Test-Path -Path $downloadDir)) {
        Write-Step "Creating download directory: $downloadDir"
        New-Item -Path $downloadDir -ItemType Directory -Force | Out-Null
    }

    # Dependencies
    Write-Step "Installing dependencies..."
    
    ## Microsoft.UI.Xaml
    Write-Step "Downloading Microsoft.UI.Xaml..."
    $UIXamlPath = "$downloadDir\Microsoft.UI.Xaml.zip"
    $downloadUIXamlUri = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6"
    (New-Object System.Net.WebClient).DownloadFile($downloadUIXamlUri, $UIXamlPath)
    Unblock-File -Path $UIXamlPath
    Expand-Archive -Path $UIXamlPath -DestinationPath "$downloadDir\Microsoft.UI.Xaml.2.8.6"
    $UIXamlAppxPath = "$downloadDir\Microsoft.UI.Xaml.2.8.6\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.8.appx"
    Add-AppxPackage -Path $UIXamlAppxPath
    
    ## Microsoft.VCLibs.x64.14.00.Desktop
    Write-Step "Downloading Microsoft.VCLibs..."
    $VCLibsPath = "$downloadDir\Microsoft.VCLibs.x64.14.00.Desktop.appx"
    $downloadVClibsUri = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
    (New-Object System.Net.WebClient).DownloadFile($downloadVClibsUri, $VCLibsPath)
    Unblock-File -Path $VCLibsPath
    Add-AppxPackage -Path $VCLibsPath

    # Main Package
    Write-Step "Downloading latest WinGet package..."
    $assetPattern = "*Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    $releasesUri = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
    $asset = (Invoke-RestMethod -Uri $releasesUri -Method Get -ErrorAction stop).assets | Where-Object name -like $assetPattern
    $downloadAssetUri = $asset.browser_download_url
    
    # Download newest version of WinGet
    $installerPath = "$downloadDir\$($asset.name)"
    (New-Object System.Net.WebClient).DownloadFile($downloadAssetUri, $installerPath)
    Unblock-File -Path $installerPath
    
    # Get the newest WinGet's license file download URL
    Write-Step "Downloading WinGet license..."
    $licensePattern = "*_License1.xml"
    $license = (Invoke-RestMethod -Uri $releasesUri -Method Get -ErrorAction stop).assets | Where-Object name -like $licensePattern
    $downloadLicenseUri = $license.browser_download_url
    
    # Download license file
    $licensePath = "$downloadDir\$($license.name)"
    (New-Object System.Net.WebClient).DownloadFile($downloadLicenseUri, $licensePath)
    Unblock-File -Path $licensePath

    # Install Package
    Write-Step "Installing WinGet package..."
    Add-AppxPackage $installerPath
    
    # Register Package with License
    Write-Step "Registering WinGet with license..."
    Try {
        Add-AppxProvisionedPackage -Online -PackagePath $installerPath -LicensePath $licensePath -Verbose -LogPath "$downloadDir\DesktopAppInstaller_Install.log" #-DependencyPackagePath "$UIXamlAppxPath", "$VCLibsPath"
    }
    Catch {
        Write-Warning "Primary installation method failed, trying alternative..."
        try {
            Add-AppxPackage -Path $installerPath -DependencyPath "$UIXamlAppxPath", "$VCLibsPath" -InstallAllResources
        }
        catch {
            Write-Error "WinGet installation failed: $($_.Exception.Message)"
            throw
        }
    }
    
    # Fix Permissions (S-1-5-32-544) Local Administrators Group (Language independent)
    Write-Step "Fixing WinGet permissions..."
    try {
        & TAKEOWN /F "C:\Program Files\WindowsApps" /R /A /D Y | Out-Null
        & ICACLS "C:\Program Files\WindowsApps" /grant "*S-1-5-32-544:(F)" /T | Out-Null
    }
    catch {
        Write-Warning "Failed to fix permissions: $($_.Exception.Message)"
    }
    
    # Add Environment Path
    Write-Step "Adding WinGet to system PATH..."
    try {
        $ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
        if ($ResolveWingetPath) {
            $WingetPath = $ResolveWingetPath[-1].Path
            $ENV:PATH += ";$WingetPath"
            $SystemEnvPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
            if ($SystemEnvPath -notlike "*$WingetPath*") {
                [System.Environment]::SetEnvironmentVariable('PATH', "$SystemEnvPath;$WingetPath", [System.EnvironmentVariableTarget]::Machine)
            }
        }
    }
    catch {
        Write-Warning "Failed to add WinGet to PATH: $($_.Exception.Message)"
    }

    Write-Step "WinGet installation completed successfully!"
}
catch {
    Write-Error "WinGet installation failed: $($_.Exception.Message)"
    exit 1
}
finally {
    # Cleanup
    if (Test-Path "C:\WinGet") {
        Write-Step "Cleaning up temporary files..."
        try {
            Get-ChildItem -Path "C:\WinGet" -Recurse | Where-Object { -not ($_.psiscontainer) } | Remove-Item -Force -ErrorAction SilentlyContinue
            Get-ChildItem -Path "C:\WinGet" -Recurse | Remove-Item -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "C:\WinGet" -Force -ErrorAction SilentlyContinue
        }
        catch {
            Write-Warning "Failed to clean up temporary files: $($_.Exception.Message)"
        }
    }
}