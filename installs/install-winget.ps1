# Source: https://github.com/cquresphere/WindowsInternals/blob/main/WinGet/Install-WinGetWithDependenciesAndLicense.ps1

# This script installs the latest WinGet (Windows Package Manager) with dependencies and license files.
$ProgressPreference = 'SilentlyContinue' # Hide Progressbar

# Create download directory
if (-not $(Test-Path -Path "C:\WinGet")) {
    New-Item -Path "C:" -Name "WinGet" -ItemType Directory -Force
}

# Dependencies
## Microsoft.UI.Xaml
$UIXamlPath = "C:\WinGet\Microsoft.UI.Xaml.zip"
$downloadUIXamlUri = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6"
(New-Object System.Net.WebClient).DownloadFile($downloadUIXamlUri, $UIXamlPath)
Unblock-File -Path $UIXamlPath
Expand-Archive -Path $UIXamlPath -DestinationPath "C:\WinGet\Microsoft.UI.Xaml.2.8.6"
$UIXamlAppxPath = "C:\WinGet\Microsoft.UI.Xaml.2.8.6\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.8.appx"
Add-AppxPackage -Path $UIXamlAppxPath

## Microsoft.VCLibs.x64.14.00.Desktop
$VCLibsPath = "C:\WinGet\Microsoft.VCLibs.x64.14.00.Desktop.appx"
$downloadVClibsUri = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
(New-Object System.Net.WebClient).DownloadFile($downloadVClibsUri, $VCLibsPath)
Unblock-File -Path $VCLibsPath
Add-AppxPackage -Path $VCLibsPath

# Main Package
# Get the newest WinGet's version the download URL
$assetPattern = "*Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$releasesUri = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
$asset = (Invoke-RestMethod -Uri $releasesUri -Method Get -ErrorAction stop).assets | Where-Object name -like $assetPattern
$downloadAssetUri = $asset.browser_download_url

# Download newest version of WinGet
$installerPath = "C:\WinGet\$($asset.name)"
(New-Object System.Net.WebClient).DownloadFile($downloadAssetUri, $installerPath)
Unblock-File -Path $installerPath

# Get the newest WinGet's license file download URL
$licensePattern = "*_License1.xml"
$license = (Invoke-RestMethod -Uri $releasesUri -Method Get -ErrorAction stop).assets | Where-Object name -like $licensePattern
$downloadLicenseUri = $license.browser_download_url

# Download license file
$licensePath = "C:\WinGet\$($license.name)"
(New-Object System.Net.WebClient).DownloadFile($downloadLicenseUri, $licensePath)
Unblock-File -Path $licensePath

# Install Package
Add-AppxPackage $installerPath

# Register Package with License
Try {
    Add-AppxProvisionedPackage -Online -PackagePath $installerPath -LicensePath $licensePath -Verbose -LogPath "C:\WinGet\DesktopAppInstaller_Install.log" #-DependencyPackagePath "$UIXamlAppxPath", "$VCLibsPath"
}
Catch {
    try {
        Add-AppxPackage -Path $installerPath -DependencyPath "$UIXamlAppxPath", "$VCLibsPath" -InstallAllResources
    }
    catch {
        Write-Output $_.Exception.Message
        Write-Output $Error[0]
    }
}

# Fix Permissions (S-1-5-32-544) Local Administrators Group (Language independent)
TAKEOWN /F "C:\Program Files\WindowsApps" /R /A /D Y
ICACLS "C:\Program Files\WindowsApps" /grant "*S-1-5-32-544:(F)" /T

# Add Environment Path
$ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
if ($ResolveWingetPath) {
    $WingetPath = $ResolveWingetPath[-1].Path
}
$ENV:PATH += ";$WingetPath"
$SystemEnvPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
$SystemEnvPath += ";$WingetPath;"

# Cleanup
Get-ChildItem -Path "C:\WinGet" -Recurse | Where-Object { -not ($_.psiscontainer) } | Remove-Item -Force
Get-ChildItem -Path "C:\WinGet" -Recurse  | Remove-Item -Force
Get-Item -Path "C:\WinGet" | Remove-Item -Force 