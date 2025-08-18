# enable oh my posh prompt
oh-my-posh init pwsh --config ~/.theme.omp.json | Invoke-Expression

# enable fnm fast node manager
fnm completions --shell powershell | Out-String | Invoke-Expression
fnm env --use-on-cd | Out-String | Invoke-Expression

# History
 
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
 
# Alias
 
function ~ {
  Set-Location ~
}

function .. {
  Set-Location ..
}

function .... {
  Set-Location ../../
}

function ...... {
  Set-Location ../../../
}

function oss {
  Set-Location "~/src/oss/$args"
}

function work {
  Set-Location "~/src/ofm/$args"
}

function touch {
  New-Item -ItemType File -Name $args[0]
}

function mkdir {
  New-Item -ItemType Directory -Name $args[0]
}

function rmdir {
  Remove-Item -Recurse -Force $args[0]
}

function rm {
  Remove-Item -Force $args[0]
}

function mv {
  Move-Item $args[0] $args[1]
}

function cp {
  Copy-Item $args[0] $args[1]
}

function ls {
  Get-ChildItem $args[0]
}

function backup-vs {
    <#
    .SYNOPSIS
    Backs up currently installed VSCode extensions to the extensions file.
    #>
    try {
        if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
            Write-Error "VSCode CLI not found. Please ensure VSCode is installed and in PATH."
            return
        }
        
        $ProfilePath = Get-Item $profile | Select-Object -ExpandProperty Target
        $ExtensionFile = Join-Path (Split-Path $ProfilePath -Parent) "..\vscode\extensions"
        
        if (-not (Test-Path (Split-Path $ExtensionFile -Parent))) {
            Write-Error "VSCode settings directory not found: $(Split-Path $ExtensionFile -Parent)"
            return
        }
        
        $extensions = code --list-extensions
        $extensions | Sort-Object | Out-File -FilePath $ExtensionFile -Encoding UTF8
        
        Write-Host "VSCode extensions backed up to: $ExtensionFile" -ForegroundColor Green
        Write-Host "Found $($extensions.Count) extensions" -ForegroundColor Cyan
    }
    catch {
        Write-Error "Failed to backup VSCode extensions: $($_.Exception.Message)"
    }
}

function sln {
    <#
    .SYNOPSIS
    Opens the first .sln file found in the current directory.
    #>
    try {
        $slnFiles = Get-ChildItem -Filter "*.sln"
        
        if ($slnFiles.Count -eq 0) {
            Write-Warning "No .sln files found in the current directory."
            return
        }
        
        if ($slnFiles.Count -eq 1) {
            Write-Host "Opening: $($slnFiles[0].Name)" -ForegroundColor Green
            Invoke-Item $slnFiles[0]
        } else {
            Write-Host "Multiple .sln files found:" -ForegroundColor Yellow
            for ($i = 0; $i -lt $slnFiles.Count; $i++) {
                Write-Host "  [$i] $($slnFiles[$i].Name)"
            }
            $selection = Read-Host "Select file to open (0-$($slnFiles.Count-1))"
            
            if ($selection -match '^\d+$' -and [int]$selection -lt $slnFiles.Count) {
                Write-Host "Opening: $($slnFiles[[int]$selection].Name)" -ForegroundColor Green
                Invoke-Item $slnFiles[[int]$selection]
            } else {
                Write-Error "Invalid selection: $selection"
            }
        }
    }
    catch {
        Write-Error "Failed to open solution file: $($_.Exception.Message)"
    }
}

# Additional utility functions
function which {
    param([Parameter(Mandatory)][string]$Command)
    Get-Command $Command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source
}

function grep {
    param(
        [Parameter(Mandatory)][string]$Pattern,
        [string]$Path = "."
    )
    Select-String -Pattern $Pattern -Path $Path -Recurse
}

function find {
    param(
        [Parameter(Mandatory)][string]$Name,
        [string]$Path = "."
    )
    Get-ChildItem -Path $Path -Recurse -Filter $Name -ErrorAction SilentlyContinue
}

function Set-GitUser {
    <#
    .SYNOPSIS
    Updates the .gitconfig file with the current user's name and email address.
    
    .DESCRIPTION
    This function prompts for or automatically detects the current user's name and email,
    then updates the Git configuration. It can use the Windows user account name as a 
    starting point and allows for manual override.
    
    .PARAMETER Name
    The user's full name. If not provided, will prompt for input with current user as default.
    
    .PARAMETER Email
    The user's email address. If not provided, will prompt for input.
    
    .PARAMETER Auto
    Attempt to automatically detect user information from the system and Git config.
    
    .EXAMPLE
    Set-GitUser
    # Prompts for name and email interactively
    
    .EXAMPLE
    Set-GitUser -Name "John Doe" -Email "john@example.com"
    # Sets Git user directly with provided values
    
    .EXAMPLE
    Set-GitUser -Auto
    # Attempts to auto-detect from current Git config or system
    #>
    [CmdletBinding()]
    param(
        [string]$Name,
        [string]$Email,
        [switch]$Auto
    )
    
    try {
        # Get current Git config values if they exist
        $currentGitName = git config --global user.name 2>$null
        $currentGitEmail = git config --global user.email 2>$null
        
        # Get system user info as fallback
        $systemUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $systemName = $systemUser.Name -replace '^.*\\', ''  # Remove domain prefix
        
        # Try to get full name from user account
        try {
            $adUser = Get-WmiObject -Class Win32_UserAccount -Filter "Name='$systemName'" -ErrorAction SilentlyContinue
            if ($adUser -and $adUser.FullName) {
                $systemFullName = $adUser.FullName
            } else {
                $systemFullName = $systemName
            }
        } catch {
            $systemFullName = $systemName
        }
        
        if ($Auto) {
            # Auto mode: use current Git config or system defaults
            $finalName = if ($currentGitName) { $currentGitName } else { $systemFullName }
            $finalEmail = if ($currentGitEmail) { $currentGitEmail } else { "$systemName@$(hostname.exe)" }
            
            Write-Host "Auto-detected configuration:" -ForegroundColor Cyan
            Write-Host "  Name: $finalName" -ForegroundColor Yellow
            Write-Host "  Email: $finalEmail" -ForegroundColor Yellow
            
            $confirm = Read-Host "Use these values? (Y/n)"
            if ($confirm -and $confirm.ToLower() -ne 'y' -and $confirm.ToLower() -ne 'yes') {
                Write-Host "Cancelled by user" -ForegroundColor Yellow
                return
            }
        } else {
            # Interactive or parameter mode
            if (-not $Name) {
                $defaultName = if ($currentGitName) { $currentGitName } else { $systemFullName }
                $Name = Read-Host "Enter your full name [$defaultName]"
                if (-not $Name) { $Name = $defaultName }
            }
            
            if (-not $Email) {
                $defaultEmail = if ($currentGitEmail) { $currentGitEmail } else { "$systemName@$(hostname.exe)" }
                $Email = Read-Host "Enter your email address [$defaultEmail]"
                if (-not $Email) { $Email = $defaultEmail }
            }
            
            $finalName = $Name
            $finalEmail = $Email
        }
        
        # Validate inputs
        if (-not $finalName -or -not $finalEmail) {
            Write-Error "Both name and email are required"
            return
        }
        
        if ($finalEmail -notmatch '^[^\s@]+@[^\s@]+\.[^\s@]+$') {
            Write-Warning "Email format may not be valid: $finalEmail"
            $proceed = Read-Host "Continue anyway? (y/N)"
            if ($proceed.ToLower() -ne 'y' -and $proceed.ToLower() -ne 'yes') {
                Write-Host "Cancelled by user" -ForegroundColor Yellow
                return
            }
        }
        
        # Update Git configuration
        Write-Host "Updating Git configuration..." -ForegroundColor Green
        
        git config --global user.name $finalName
        git config --global user.email $finalEmail
        
        # Verify the changes
        $newName = git config --global user.name
        $newEmail = git config --global user.email
        
        Write-Host "✓ Git configuration updated successfully:" -ForegroundColor Green
        Write-Host "  Name: $newName" -ForegroundColor Cyan
        Write-Host "  Email: $newEmail" -ForegroundColor Cyan
        
        # Show location of .gitconfig
        $gitConfigPath = git config --global --list --show-origin | Select-String "user.name" | ForEach-Object { ($_ -split "\t")[0] -replace "file:", "" }
        if ($gitConfigPath) {
            Write-Host "  Config file: $gitConfigPath" -ForegroundColor Gray
        }
    }
    catch {
        Write-Error "Failed to update Git configuration: $($_.Exception.Message)"
    }
}
