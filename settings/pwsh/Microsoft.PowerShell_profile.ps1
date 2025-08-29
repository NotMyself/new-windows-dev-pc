# enable oh my posh prompt (only if available and interactive)
if ((Get-Command oh-my-posh -ErrorAction SilentlyContinue) -and $Host.Name -eq 'ConsoleHost' -and [Environment]::UserInteractive) {
    try {
        oh-my-posh init pwsh --config ~/.theme.omp.json | Invoke-Expression
    } catch {
        Write-Warning "Failed to initialize oh-my-posh: $($_.Exception.Message)"
    }
}

# enable fnm fast node manager (only if available and interactive)
if ((Get-Command fnm -ErrorAction SilentlyContinue) -and $Host.Name -eq 'ConsoleHost' -and [Environment]::UserInteractive) {
    try {
        fnm completions --shell powershell | Out-String | Invoke-Expression
        fnm env --use-on-cd | Out-String | Invoke-Expression
    } catch {
        Write-Warning "Failed to initialize fnm: $($_.Exception.Message)"
    }
}
# Load environment variables from 1Password (only if op CLI available)
if (Get-Command op -ErrorAction SilentlyContinue) {
    try {
        $profileTarget = Get-Item $profile | Select-Object -ExpandProperty Target
        if ($profileTarget) {
            $envVarsScript = Join-Path (Split-Path $profileTarget -Parent) "1p-env-vars.ps1"
            if (Test-Path $envVarsScript) {
                . $envVarsScript
            }
        }
    } catch {
        Write-Warning "Failed to load environment variables from 1Password: $($_.Exception.Message)"
    }
}

# Login to Azure if environment variables are set (only if valid and az CLI available)
if ((Get-Command az -ErrorAction SilentlyContinue) -and 
    $env:AZURE_CLIENT_ID -and $env:AZURE_CLIENT_SECRET -and $env:AZURE_TENANT_ID -and
    $env:AZURE_CLIENT_ID -ne '${AZURE_CLIENT_ID}' -and $env:AZURE_TENANT_ID -ne '${AZURE_TENANT_ID}') {
    try {
        az login --service-principal -u $env:AZURE_CLIENT_ID -p $env:AZURE_CLIENT_SECRET --tenant $env:AZURE_TENANT_ID | Out-Null
    } catch {
        Write-Warning "Failed to login to Azure: $($_.Exception.Message)"
    }
}
# History (only in interactive sessions)
if ($Host.Name -eq 'ConsoleHost' -and [Environment]::UserInteractive) {
    try {
        Set-PSReadLineOption -PredictionSource History -WarningAction SilentlyContinue
        Set-PSReadLineOption -PredictionViewStyle ListView -WarningAction SilentlyContinue
        Set-PSReadLineOption -EditMode Windows -WarningAction SilentlyContinue
    } catch {
        # Silently ignore PSReadLine errors in non-compatible terminals
    }
}
 
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

function backup-npm {
    <#
    .SYNOPSIS
    Backs up currently installed global npm packages to the global packages file.
    #>
    try {
        if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
            Write-Error "npm not found. Please ensure Node.js/npm is installed and in PATH."
            return
        }
        
        $ProfilePath = Get-Item $profile | Select-Object -ExpandProperty Target
        $PackageFile = Join-Path (Split-Path $ProfilePath -Parent) "..\npm\global-packages"
        
        if (-not (Test-Path (Split-Path $PackageFile -Parent))) {
            Write-Error "npm settings directory not found: $(Split-Path $PackageFile -Parent)"
            return
        }
        
        # Get list of globally installed packages (excluding npm itself)
        $packages = npm list -g --depth=0 --parseable 2>$null | ForEach-Object {
            if ($_ -match 'node_modules[\\\/](.+)$') {
                $matches[1]
            }
        } | Where-Object { $_ -ne 'npm' } | Sort-Object
        
        if ($packages) {
            # Create header comment
            $header = @(
                "# Global npm packages"
                "# Generated on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
                "# Use 'npm install -g <package>' to install manually"
                ""
            )
            
            # Combine header and packages
            $content = $header + $packages
            $content | Out-File -FilePath $PackageFile -Encoding UTF8
            
            Write-Host "Global npm packages backed up to: $PackageFile" -ForegroundColor Green
            Write-Host "Found $($packages.Count) packages" -ForegroundColor Cyan
        } else {
            Write-Warning "No global npm packages found to backup"
        }
    }
    catch {
        Write-Error "Failed to backup global npm packages: $($_.Exception.Message)"
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

function refresh-env {
    <#
    .SYNOPSIS
    Refreshes environment variables and reinitializes development tools.
    
    .DESCRIPTION
    This function refreshes the current session's environment variables from the system,
    reloads PATH, and reinitializes development tools like fnm and 1Password environment variables.
    Use this after installing new tools or when CLI commands aren't found.
    
    .EXAMPLE
    refresh-env
    # Refreshes all environment variables and tool configurations
    #>
    
    Write-Host "Refreshing environment variables and tools..." -ForegroundColor Cyan
    
    try {
        # Refresh environment variables from registry
        Write-Host "• Updating environment variables..." -ForegroundColor Yellow
        
        # Get machine and user environment variables
        $machineEnv = [Environment]::GetEnvironmentVariables([EnvironmentVariableTarget]::Machine)
        $userEnv = [Environment]::GetEnvironmentVariables([EnvironmentVariableTarget]::User)
        
        # Update PATH specifically
        $machinePath = $machineEnv["PATH"]
        $userPath = $userEnv["PATH"]
        $combinedPath = @($machinePath, $userPath) -join ";"
        $env:PATH = $combinedPath
        
        # Update other important environment variables
        foreach ($key in $machineEnv.Keys) {
            [Environment]::SetEnvironmentVariable($key, $machineEnv[$key])
        }
        foreach ($key in $userEnv.Keys) {
            [Environment]::SetEnvironmentVariable($key, $userEnv[$key])
        }
        
        Write-Host "  ✓ Environment variables updated" -ForegroundColor Green
        
        # Reinitialize fnm if available
        if (Get-Command fnm -ErrorAction SilentlyContinue) {
            Write-Host "• Reinitializing fnm (Fast Node Manager)..." -ForegroundColor Yellow
            try {
                fnm completions --shell powershell | Out-String | Invoke-Expression
                fnm env --use-on-cd | Out-String | Invoke-Expression
                Write-Host "  ✓ fnm reinitialized" -ForegroundColor Green
            } catch {
                Write-Warning "Failed to reinitialize fnm: $($_.Exception.Message)"
            }
        }
        
        # Reload 1Password environment variables if available
        if (Get-Command op -ErrorAction SilentlyContinue) {
            Write-Host "• Reloading 1Password environment variables..." -ForegroundColor Yellow
            try {
                $profileTarget = Get-Item $profile | Select-Object -ExpandProperty Target
                if ($profileTarget) {
                    $envVarsScript = Join-Path (Split-Path $profileTarget -Parent) "1p-env-vars.ps1"
                    if (Test-Path $envVarsScript) {
                        . $envVarsScript
                        Write-Host "  ✓ 1Password environment variables reloaded" -ForegroundColor Green
                    } else {
                        Write-Host "  ! 1Password env vars script not found" -ForegroundColor Yellow
                    }
                }
            } catch {
                Write-Warning "Failed to reload 1Password environment variables: $($_.Exception.Message)"
            }
        }
        
        # Test common CLI tools
        Write-Host "• Testing CLI tool availability..." -ForegroundColor Yellow
        $tools = @("winget", "code", "node", "npm", "gh", "wt", "git", "dotnet", "az")
        $available = @()
        $missing = @()
        
        foreach ($tool in $tools) {
            if (Get-Command $tool -ErrorAction SilentlyContinue) {
                $available += $tool
            } else {
                $missing += $tool
            }
        }
        
        if ($available.Count -gt 0) {
            Write-Host "  ✓ Available: $($available -join ', ')" -ForegroundColor Green
        }
        if ($missing.Count -gt 0) {
            Write-Host "  ! Missing: $($missing -join ', ')" -ForegroundColor Yellow
        }
        
        Write-Host "Environment refresh complete!" -ForegroundColor Cyan
        
    } catch {
        Write-Error "Failed to refresh environment: $($_.Exception.Message)"
    }
}

function Set-1PEnvVar {
    <#
    .SYNOPSIS
    Stores an environment variable key-value pair in 1Password secure note.
    
    .DESCRIPTION
    This function adds or updates an environment variable in the "Environment Variables" 
    secure note in 1Password. The variable is stored in KEY:value format.
    
    .PARAMETER Key
    The environment variable name/key.
    
    .PARAMETER Value
    The environment variable value.
    
    .PARAMETER Vault
    The 1Password vault containing the Environment Variables note. If not specified, uses default vault.
    
    .EXAMPLE
    Set-1PEnvVar -Key "API_KEY" -Value "secret123"
    
    .EXAMPLE
    Set-1PEnvVar -Key "DATABASE_URL" -Value "postgres://user:pass@host:5432/db" -Vault "Development"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Key,
        
        [Parameter(Mandatory)]
        [string]$Value,
        
        [string]$Vault
    )
    
    try {
        # Check if op cli is available
        if (-not (Get-Command op -ErrorAction SilentlyContinue)) {
            Write-Error "1Password CLI (op) not found. Please install and authenticate with 1Password CLI."
            return
        }
        
        $noteTitle = "Local Environment Variables"
        
        # Get current note content - first check if note exists
        $currentNote = $null
        $currentContent = ""
        
        try {
            # Search for existing note first to avoid creating duplicates
            if ($Vault) {
                $searchResult = op item list --categories="Secure Note" --vault $Vault --format json | ConvertFrom-Json
            } else {
                $searchResult = op item list --categories="Secure Note" --format json | ConvertFrom-Json
            }
            
            $existingNote = $searchResult | Where-Object { $_.title -eq $noteTitle }
            
            if ($existingNote) {
                # Note exists, get its content
                if ($Vault) {
                    $currentNote = op item get $existingNote.id --vault $Vault --format json | ConvertFrom-Json
                } else {
                    $currentNote = op item get $existingNote.id --format json | ConvertFrom-Json
                }
                $currentContent = $currentNote.fields | Where-Object { $_.label -eq "notesPlain" } | Select-Object -ExpandProperty value
            }
        } catch {
            # If search fails, note doesn't exist or there's an authentication issue
            Write-Verbose "Could not find existing note or search failed: $($_.Exception.Message)"
        }
        
        # Parse existing content into lines
        $lines = if ($currentContent) { $currentContent -split "`n" } else { @() }
        
        # Remove any existing entry for this key
        $lines = $lines | Where-Object { $_ -notmatch "^$([regex]::Escape($Key)):" }
        
        # Add the new key-value pair
        $lines += "$Key`:$Value"
        
        # Sort the lines for better organization
        $lines = $lines | Sort-Object
        
        # Join back into content
        $newContent = $lines -join [Environment]::NewLine
        
        # Create or update the note
        if ($currentNote) {
            # Update existing note using its ID to avoid ambiguity
            $opArgs = @(
                "item", "edit", $currentNote.id,
                "notesPlain=$newContent"
            )
            if ($Vault) {
                $opArgs += "--vault=$Vault"
            }
            
            Write-Host "Updating environment variable '$Key' in 1Password..." -ForegroundColor Yellow
        } else {
            # Create new note
            $opArgs = @(
                "item", "create",
                "--category=secure note",
                "--title=$noteTitle",
                "notesPlain=$newContent"
            )
            if ($Vault) {
                $opArgs += "--vault=$Vault"
            }
            
            Write-Host "Creating Environment Variables note and adding '$Key'..." -ForegroundColor Yellow
        }
        
        $result = & op @opArgs 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Environment variable '$Key' stored successfully in 1Password" -ForegroundColor Green
            if ($Vault) {
                Write-Host "  Vault: $Vault" -ForegroundColor Gray
            }
            Write-Host "  Note: $noteTitle" -ForegroundColor Gray
        } else {
            Write-Error "Failed to store environment variable in 1Password: $result"
        }
    }
    catch {
        Write-Error "Failed to store environment variable in 1Password: $($_.Exception.Message)"
    }
}
