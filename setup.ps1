# Ensure the script can run with elevated privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as an Administrator!"
    break
}

function Test-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Install WinGet
if(-Not (Test-Command 'winget')) {
    ./installs/install-winget.ps1
}

# Install Tools via WinGet
./installs/winget.ps1

# Install VSCode Extensions
if(Test-Command 'code-insiders') {
    ./installs/vscode.ps1
}


# Link Config Files

# Git
New-Item -Force -Path ~/.gitconfig -ItemType SymbolicLink -Value $PSScriptRoot\settings\git\.gitconfig

# VSCode
New-Item -Force -Path $env:APPDATA\'Code - Insiders'\User\settings.json -ItemType SymbolicLink -Value $PSScriptRoot\settings\vscode\settings.json

New-Item -Force -Path $env:APPDATA\'Code - Insiders'\User\keybindings.json -ItemType SymbolicLink -Value $PSScriptRoot\settings\vscode\keybindings.json


# Powershell
New-Item -Force -Path ~/.theme.omp.json -ItemType SymbolicLink -Value $PSScriptRoot\settings\pwsh\.theme.omp.json

New-Item -Force -Path $profile -ItemType SymbolicLink -Value $PSScriptRoot\settings\pwsh\Microsoft.PowerShell_profile.ps1