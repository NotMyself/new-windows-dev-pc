[CmdletBinding()]
param(
    [switch]$Force,
    [switch]$SkipConfirmation,
    [string]$WSLDistro = "Ubuntu-22.04"
)

# Check PowerShell version - require PowerShell 7+
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "❌ This script requires PowerShell 7 or later for proper Unicode and emoji support." -ForegroundColor Red
    Write-Host "Current version: PowerShell $($PSVersionTable.PSVersion)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To install PowerShell 7+:" -ForegroundColor Cyan
    Write-Host "  1. Run the main installation script first: .\install.ps1" -ForegroundColor White
    Write-Host "  2. Or visit: https://github.com/PowerShell/PowerShell#get-powershell" -ForegroundColor White
    Write-Host "  3. Then run this script with: pwsh .\configure.ps1" -ForegroundColor White
    Write-Host ""
    exit 1
}

# Check if Developer Mode is enabled (allows symbolic links without Admin)
function Test-DeveloperMode {
    try {
        $devModeKey = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -ErrorAction SilentlyContinue
        return ($devModeKey.AllowDevelopmentWithoutDevLicense -eq 1)
    }
    catch {
        return $false
    }
}

$isDeveloperModeEnabled = Test-DeveloperMode
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

# Check if we have permission to create symbolic links
if (-not $isDeveloperModeEnabled -and -not $isAdmin) {
    Write-Host ""
    Write-Host "❌ PERMISSION REQUIRED" -ForegroundColor Red
    Write-Host ("=" * 50) -ForegroundColor Red
    Write-Host ""
    Write-Host "This script creates symbolic links, which requires Windows Developer Mode to be enabled." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🛠️  HOW TO ENABLE DEVELOPER MODE:" -ForegroundColor Cyan
    Write-Host "   1. Open Windows Settings (Win + I)" -ForegroundColor White
    Write-Host "   2. Go to Privacy & Security → For developers" -ForegroundColor White
    Write-Host "   3. Turn ON 'Developer Mode'" -ForegroundColor White
    Write-Host "   4. Click 'Yes' when prompted" -ForegroundColor White
    Write-Host ""
    Write-Host "💡 WHY DEVELOPER MODE?" -ForegroundColor Cyan
    Write-Host "   • Allows creating symbolic links without Administrator privileges" -ForegroundColor Gray
    Write-Host "   • Improves development workflow and tool integration" -ForegroundColor Gray
    Write-Host "   • Enables modern development features on Windows" -ForegroundColor Gray
    Write-Host ""
    Write-Host "🔄 AFTER ENABLING:" -ForegroundColor Cyan
    Write-Host "   Run this script again: pwsh .\configure.ps1" -ForegroundColor White
    Write-Host ""
    Write-Host "Alternatively, you can run this script as Administrator, but Developer Mode is recommended." -ForegroundColor Gray
    Write-Host ""
    exit 1
} else {
    # Show status message about permissions
    if ($isDeveloperModeEnabled) {
        Write-Host "✅ Developer Mode enabled - symbolic links supported" -ForegroundColor Green
    } elseif ($isAdmin) {
        Write-Host "✅ Running as Administrator - symbolic links supported" -ForegroundColor Green
    }
}

function Write-Step {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor Cyan
}

function Show-ConfigurationPlan {
    param([array]$ConfigurationTools)
    
    Write-Host ""
    Write-Host ("=" * 80) -ForegroundColor Cyan
    Write-Host " CONFIGURATION PLAN" -ForegroundColor White
    Write-Host ("=" * 80) -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "The following tools will be configured:" -ForegroundColor Yellow
    Write-Host ""
    
    for ($i = 0; $i -lt $ConfigurationTools.Count; $i++) {
        $tool = $ConfigurationTools[$i]
        $stepNum = $i + 1
        Write-Host "  $stepNum. " -ForegroundColor Gray -NoNewline
        Write-Host "$($tool.Description)" -ForegroundColor White
        Write-Host "     🔧 What: $($tool.Details)" -ForegroundColor Gray
        Write-Host "     💡 Why: $($tool.WhyNeeded)" -ForegroundColor DarkYellow
        if ($tool.HasWindows11Features) {
            Write-Host "     🚀 Bonus: Includes Windows 11 enhanced features" -ForegroundColor Green
        }
        Write-Host ""
    }
    
    Write-Host "Each step will:" -ForegroundColor Yellow
    Write-Host "  • Create symbolic links to centralized configuration files" -ForegroundColor Gray
    Write-Host "  • Preserve existing configurations (backup if needed)" -ForegroundColor Gray  
    Write-Host "  • Apply tool-specific optimizations" -ForegroundColor Gray
    Write-Host ""
}

function Confirm-ConfigurationStep {
    param(
        [string]$ToolName,
        [string]$Description,
        [string]$Details,
        [string]$WhyNeeded,
        [int]$StepNumber,
        [int]$TotalSteps,
        [bool]$HasWindows11Features = $false
    )
    
    if ($SkipConfirmation) {
        return $true
    }
    
    Write-Host ""
    Write-Host ("=" * 70) -ForegroundColor DarkCyan
    Write-Host " STEP $StepNumber of ${TotalSteps}: $Description" -ForegroundColor White
    Write-Host ("=" * 70) -ForegroundColor DarkCyan
    Write-Host ""
    Write-Host "🔧 What: " -ForegroundColor Cyan -NoNewline
    Write-Host $Details -ForegroundColor Gray
    Write-Host "💡 Why: " -ForegroundColor Cyan -NoNewline  
    Write-Host $WhyNeeded -ForegroundColor Yellow
    
    if ($HasWindows11Features) {
        Write-Host "🚀 Bonus: " -ForegroundColor Cyan -NoNewline
        Write-Host "Includes Windows 11 enhanced features for better terminal experience" -ForegroundColor Green
    }
    Write-Host ""
    
    do {
        Write-Host "Continue with this configuration step?" -ForegroundColor Yellow
        Write-Host "  [Y] Yes (default)" -ForegroundColor Green
        Write-Host "  [S] Skip this step" -ForegroundColor Yellow  
        Write-Host "  [A] Yes to All (skip remaining prompts)" -ForegroundColor Cyan
        Write-Host "  [Q] Quit configuration" -ForegroundColor Red
        Write-Host ""
        $choice = Read-Host "Choice [Y/S/A/Q]"
        
        switch ($choice.ToUpper()) {
            "Y" { return $true }
            "" { return $true }  # Default to Yes
            "S" { 
                Write-Host "⏭️ [SKIP] Skipping $ToolName configuration" -ForegroundColor Yellow
                return $false 
            }
            "A" { 
                Write-Host "✅ [OK] Continuing with all remaining steps..." -ForegroundColor Green
                $script:SkipConfirmation = $true
                return $true 
            }
            "Q" { 
                Write-Host "❌ [CANCEL] Configuration cancelled by user" -ForegroundColor Red
                exit 0
            }
            default { 
                Write-Host "Invalid choice. Please enter Y, S, A, or Q." -ForegroundColor Red 
            }
        }
    } while ($true)
}

function Invoke-ConfigurationScript {
    param(
        [string]$ToolName,
        [hashtable]$Parameters = @{},
        [string]$Description = "",
        [string]$Details = "",
        [string]$WhyNeeded = "",
        [int]$StepNumber = 1,
        [int]$TotalSteps = 1,
        [bool]$HasWindows11Features = $false
    )
    
    # Check if user wants to proceed with this step
    if (-not (Confirm-ConfigurationStep -ToolName $ToolName -Description $Description -Details $Details -WhyNeeded $WhyNeeded -StepNumber $StepNumber -TotalSteps $TotalSteps -HasWindows11Features $HasWindows11Features)) {
        return "skipped"
    }
    
    # Map tool names to their respective script names
    $scriptMap = @{
        'git' = 'configure-git-windows.ps1'
        'vscode' = 'configure-vscode-windows.ps1'
        'pwsh' = 'configure-pwsh-windows.ps1'
        'windows-terminal' = 'configure-windows-terminal.ps1'
        'nuget' = 'configure-nuget-windows.ps1'
        'markdownlint' = 'configure-markdownlint-windows.ps1'
    }
    
    $scriptName = $scriptMap[$ToolName]
    if (-not $scriptName) {
        Write-Warning "No configuration script mapping found for tool: $ToolName"
        return $false
    }
    
    $scriptPath = "$PSScriptRoot\settings\$ToolName\$scriptName"
    
    if (Test-Path $scriptPath) {
        try {
            Write-Host "🚀 [START] Configuring $Description..." -ForegroundColor Green
            & $scriptPath @Parameters
            Write-Host "✅ [DONE] $Description configuration completed successfully" -ForegroundColor Green
            return $true
        }
        catch {
            Write-Warning "❌ [ERROR] Failed to configure $ToolName - $($_.Exception.Message)"
            return $false
        }
    } else {
        Write-Warning "❌ [ERROR] Configuration script not found for $ToolName at: $scriptPath"
        return $false
    }
}

try {
    # WSL Mode Configuration - Always performed
    Write-Step "Configuring Claude Code for WSL development..."
    
    # Verify WSL is available
    if (-not (Get-Command "wsl" -ErrorAction SilentlyContinue)) {
        Write-Error "WSL not found. Please run .\install.ps1 first"
        exit 1
    }
    
    # Check if specified distro exists
    $installedDistros = wsl --list --quiet 2>$null | ForEach-Object { $_.Trim() }
    if ($WSLDistro -notin $installedDistros) {
        Write-Error "$WSLDistro not found. Please run .\install.ps1 first"
        exit 1
    }
    
    # Set up Claude Code WSL configuration
    Write-Host "🔧 Configuring Claude Code for WSL environment..." -ForegroundColor Yellow
    
    $wslSettingsPath = "$PSScriptRoot\settings\claude\settings-wsl.json"
    $wslAgentsPath = "$PSScriptRoot\settings\claude\agents"
    
    if (Test-Path $wslSettingsPath) {
        # Create .claude directory in WSL filesystem
        wsl bash -c "mkdir -p ~/.claude"
        
        # Backup existing settings if they exist in WSL
        $backupResult = wsl bash -c "if [ -f ~/.claude/settings.json ]; then cp ~/.claude/settings.json ~/.claude/settings.json.backup.$(date +%Y%m%d-%H%M%S) && echo 'backed up'; fi"
        if ($backupResult -eq 'backed up') {
            Write-Host "  ✓ Backed up existing WSL settings" -ForegroundColor Green
        }
        
        # Copy WSL settings to WSL filesystem
        wsl bash -c "cp /mnt/c/Users/bobby/src/new-windows-dev-pc/settings/claude/settings-wsl.json ~/.claude/settings.json"
        
        # Copy Claude agents to WSL filesystem
        if (Test-Path $wslAgentsPath) {
            wsl bash -c "mkdir -p ~/.claude/agents && cp -r /mnt/c/Users/bobby/src/new-windows-dev-pc/settings/claude/agents/* ~/.claude/agents/"
            Write-Host "  ✓ Claude agents synced to WSL filesystem" -ForegroundColor Green
        }
        
        Write-Host "  ✓ Claude Code configured for WSL ($WSLDistro)" -ForegroundColor Green
    } else {
        Write-Error "WSL settings file not found: $wslSettingsPath"
        exit 1
    }
    
    # Set up 1Password in WSL
    Write-Host "🔑 Setting up 1Password integration in WSL..." -ForegroundColor Yellow
    $wsl1pScript = "$PSScriptRoot\settings\wsl\configure-1password-wsl.sh"
    if (Test-Path $wsl1pScript) {
        # Make script executable
        wsl -d $WSLDistro -- chmod +x "/mnt/c$($wsl1pScript.Replace('C:', '').Replace('\', '/'))"
        # Run 1Password setup
        wsl -d $WSLDistro -- bash "/mnt/c$($wsl1pScript.Replace('C:', '').Replace('\', '/'))"
        Write-Host "  ✓ 1Password integration configured in WSL" -ForegroundColor Green
    } else {
        Write-Warning "1Password WSL setup script not found: $wsl1pScript"
    }
    
    Write-Host ""
    Write-Host "✅ WSL configuration completed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Claude Code is now configured to use:" -ForegroundColor Cyan
    Write-Host "  • WSL ($WSLDistro) for tool execution" -ForegroundColor White
    Write-Host "  • bash shell instead of PowerShell" -ForegroundColor White  
    Write-Host "  • prettier and markdownlint tools" -ForegroundColor White
    Write-Host "  • 1Password integration for secure environment variables" -ForegroundColor White
    Write-Host "  • Separate Git identity for Claude Code commits" -ForegroundColor White
    Write-Host ""
    Write-Host "Test WSL setup:" -ForegroundColor Yellow
    Write-Host "  wsl -d $WSLDistro -- prettier --version" -ForegroundColor Gray
    Write-Host "  wsl -d $WSLDistro -- markdownlint --version" -ForegroundColor Gray
    Write-Host ""
    
    Write-Step "Configuring development environment..."
    
    # Ask for Windows 11 features permission upfront
    $EnableWindows11Features = $false
    if (-not $SkipConfirmation) {
        # Detect Windows 11
        $IsWindows11 = [System.Environment]::OSVersion.Version.Build -ge 22000
        if ($IsWindows11) {
            Write-Host ""
            Write-Host "🚀 Windows 11 Enhanced Features Available!" -ForegroundColor Green
            Write-Host "Your system supports advanced Windows 11 features including:" -ForegroundColor Yellow
            Write-Host "  • Custom Windows Terminal themes with enhanced color schemes" -ForegroundColor Gray
            Write-Host "  • Optimized environment variables for modern development" -ForegroundColor Gray
            Write-Host "  • Advanced terminal fragments with ligature support" -ForegroundColor Gray
            Write-Host ""
            do {
                $w11Choice = Read-Host "Enable Windows 11 enhanced features? [Y/N] (default: Y)"
                switch ($w11Choice.ToUpper()) {
                    "Y" { $EnableWindows11Features = $true; break }
                    "" { $EnableWindows11Features = $true; break }
                    "N" { $EnableWindows11Features = $false; break }
                    default { Write-Host "Please enter Y or N" -ForegroundColor Red }
                }
            } while ($w11Choice.ToUpper() -notin @("Y", "N", ""))
        }
    }
    
    # Prepare parameters for modular configuration scripts
    $configParams = @{ 'Force' = $Force }
    $enhancedParams = @{ 'Force' = $Force; 'EnableWindows11Features' = $EnableWindows11Features }
    
    # Configuration tools with detailed descriptions and explanations
    $configurationTools = @(
        @{ 
            Name = 'git'; 
            Params = $configParams;
            Description = 'Git Version Control';
            Details = 'Configure Git with VSCode integration, helpful aliases, and optimized settings';
            WhyNeeded = 'Essential for version control, code collaboration, and integrates with all development tools';
            HasWindows11Features = $false
        },
        @{ 
            Name = 'vscode'; 
            Params = $configParams;
            Description = 'Visual Studio Code';
            Details = 'Set up VSCode settings, keybindings, and development environment preferences';
            WhyNeeded = 'Provides consistent editor configuration across projects and development team';
            HasWindows11Features = $false
        },
        @{ 
            Name = 'pwsh'; 
            Params = $configParams;
            Description = 'PowerShell Profile & Theme';
            Details = 'Configure Oh My Posh theme, aliases, functions, and development shortcuts';
            WhyNeeded = 'Enhances command-line productivity with visual indicators and helpful shortcuts';
            HasWindows11Features = $false
        },
        @{ 
            Name = 'windows-terminal'; 
            Params = $enhancedParams;
            Description = 'Windows Terminal';
            Details = 'Configure terminal settings, color schemes, and enhanced terminal experience';
            WhyNeeded = 'Modern terminal with tabbed interface, color schemes, and better font rendering';
            HasWindows11Features = $EnableWindows11Features
        },
        @{ 
            Name = 'nuget'; 
            Params = $configParams;
            Description = 'NuGet Package Manager';
            Details = 'Set up NuGet configuration for .NET package management';
            WhyNeeded = 'Configures package sources and authentication for .NET development';
            HasWindows11Features = $false
        },
        @{ 
            Name = 'markdownlint'; 
            Params = $configParams;
            Description = 'Markdownlint Configuration';
            Details = 'Configure Markdown linting rules for documentation consistency';
            WhyNeeded = 'Ensures consistent documentation formatting across all projects';
            HasWindows11Features = $false
        }
    )
    
    # Show configuration plan to user
    Show-ConfigurationPlan -ConfigurationTools $configurationTools
    
    # Get overall confirmation if not skipping
    if (-not $SkipConfirmation) {
        Write-Host "Ready to configure your development environment?" -ForegroundColor Yellow
        Write-Host "  [Y] Yes, start configuration (default)" -ForegroundColor Green
        Write-Host "  [N] No, cancel" -ForegroundColor Red
        Write-Host "  [S] Skip confirmations and proceed" -ForegroundColor Cyan
        Write-Host ""
        $overallChoice = Read-Host "Choice [Y/N/S]"
        
        switch ($overallChoice.ToUpper()) {
            "N" { 
                Write-Host "❌ [CANCEL] Configuration cancelled by user" -ForegroundColor Red
                exit 0
            }
            "S" { 
                Write-Host "⚡ [FAST] Skipping confirmations and proceeding..." -ForegroundColor Cyan
                $SkipConfirmation = $true
            }
            default { 
                # Continue with confirmations
            }
        }
    }
    
    # Execute configuration for each tool
    $successCount = 0
    $skippedCount = 0
    $failedCount = 0
    $totalCount = $configurationTools.Count
    $skippedTools = @()
    
    for ($i = 0; $i -lt $configurationTools.Count; $i++) {
        $tool = $configurationTools[$i]
        $stepNumber = $i + 1
        
        $result = Invoke-ConfigurationScript `
            -ToolName $tool.Name `
            -Parameters $tool.Params `
            -Description $tool.Description `
            -Details $tool.Details `
            -WhyNeeded $tool.WhyNeeded `
            -StepNumber $stepNumber `
            -TotalSteps $totalCount `
            -HasWindows11Features $tool.HasWindows11Features
        
        if ($result -eq "skipped") {
            $skippedCount++
            $skippedTools += $tool.Description
        } elseif ($result -eq $true) {
            $successCount++
        } else {
            $failedCount++
        }
    }
    
    Write-Host ""
    Write-Host ("=" * 70) -ForegroundColor Green
    Write-Host " CONFIGURATION COMPLETE" -ForegroundColor White
    Write-Host ("=" * 70) -ForegroundColor Green
    Write-Host ""
    Write-Host "📊 [RESULTS] Summary:" -ForegroundColor Cyan
    Write-Host "  ✅ [OK] Successful: $successCount/$totalCount" -ForegroundColor Green
    if ($skippedCount -gt 0) {
        Write-Host "  ⏭️ [SKIP] Skipped: $skippedCount/$totalCount" -ForegroundColor Yellow
    }
    if ($failedCount -gt 0) {
        Write-Host "  ❌ [ERROR] Failed: $failedCount/$totalCount" -ForegroundColor Red
    }
    Write-Host ""
    
    # Notify about skipped configurations
    if ($skippedCount -gt 0) {
        Write-Host "⚠️ [WARNING] SKIPPED CONFIGURATIONS:" -ForegroundColor Yellow
        Write-Host "The following configurations were skipped:" -ForegroundColor Gray
        foreach ($skippedTool in $skippedTools) {
            Write-Host "  • $skippedTool" -ForegroundColor Yellow
        }
        Write-Host ""
        Write-Host "💡 [TIP] To configure these tools later, run:" -ForegroundColor Cyan
        Write-Host "   .\configure.ps1" -ForegroundColor White
        Write-Host "   (You can skip the tools you've already configured)" -ForegroundColor Gray
        Write-Host ""
    }
    
    # 1Password Environment Vault Setup
    Write-Host ""
    Write-Host "Configuring 1Password Environment Vault..." -ForegroundColor Cyan
    $onePasswordSetupScript = "$PSScriptRoot\settings\1password\setup-environment-vault.ps1"
    
    if (Test-Path $onePasswordSetupScript) {
        try {
            # Check if 1Password CLI is available
            if (Get-Command op -ErrorAction SilentlyContinue) {
                Write-Host "  🔐 Running 1Password environment vault setup..." -ForegroundColor Cyan
                Write-Host ""
                
                # Execute the 1Password setup script
                & $onePasswordSetupScript
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host ""
                    Write-Host "  ✅ 1Password environment vault setup completed" -ForegroundColor Green
                } else {
                    Write-Warning "  ⚠️ 1Password setup completed with warnings (exit code: $LASTEXITCODE)"
                }
            } else {
                Write-Host "  ⚠️ 1Password CLI not found - skipping environment vault setup" -ForegroundColor Yellow
                Write-Host "    Install 1Password CLI and run: .\settings\1password\setup-environment-vault.ps1" -ForegroundColor Gray
            }
        } catch {
            Write-Warning "  ❌ Failed to run 1Password setup: $($_.Exception.Message)"
            Write-Host "    You can run it manually: .\settings\1password\setup-environment-vault.ps1" -ForegroundColor Gray
        }
    } else {
        Write-Warning "  ❌ 1Password setup script not found at: $onePasswordSetupScript"
    }
    
    Write-Host ""
    Write-Step "Configuration completed successfully!"
    Write-Host "Restart your terminal and VSCode to apply the new settings." -ForegroundColor Green
    
    if ($EnableWindows11Features) {
        Write-Host ""
        Write-Host "🚀 Windows 11 Enhanced Features:" -ForegroundColor Cyan
        Write-Host "  • Custom Windows Terminal theme with Claude Code branding" -ForegroundColor Gray
        Write-Host "  • Optimized environment variables for Claude Code integration" -ForegroundColor Gray
        Write-Host "  • Enhanced terminal experience with ligatures and color schemes" -ForegroundColor Gray
    } else {
        Write-Host ""
        Write-Host "💡 Tip: Run this script again and enable Windows 11 features for enhanced optimizations" -ForegroundColor Gray
    }
}
catch {
    Write-Error "Configuration failed: $($_.Exception.Message)"
    exit 1
}