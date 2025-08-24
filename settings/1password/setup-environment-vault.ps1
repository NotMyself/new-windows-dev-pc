#!/usr/bin/env pwsh

<#
.SYNOPSIS
Sets up 1Password Environment vault and service account for automated access.

.DESCRIPTION
This script creates a new 1Password vault called "Environment" and sets up a service
account with read/write permissions to that vault. The service account token is stored
as a persistent user environment variable for use with the 1Password CLI.

.PARAMETER Force
Force creation even if vault or service account already exists.

.EXAMPLE
.\setup-environment-vault.ps1

.EXAMPLE  
.\setup-environment-vault.ps1 -Force

.NOTES
Requires 1Password CLI (op) to be installed and authenticated.
The service account token will only be displayed once - it's automatically stored as
a persistent environment variable OP_SERVICE_ACCOUNT_TOKEN.
#>

[CmdletBinding()]
param(
    [switch]$Force
)

# Ensure we're running with 1Password CLI available
if (-not (Get-Command op -ErrorAction SilentlyContinue)) {
    Write-Error "1Password CLI (op) not found. Please install 1Password CLI first."
    exit 1
}

# Check if we're signed in
try {
    $accounts = op account list 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Not signed into 1Password. Please sign in first:" -ForegroundColor Yellow
        Write-Host "  op signin" -ForegroundColor Cyan
        exit 1
    }
} catch {
    Write-Error "Failed to check 1Password authentication status. Please sign in with 'op signin'"
    exit 1
}

Write-Host "Setting up 1Password Environment vault and service account..." -ForegroundColor Green
Write-Host ""

# Step 1: Create Environment vault
Write-Host "1. Creating Environment vault..." -ForegroundColor Yellow
try {
    # Check if vault already exists
    $existingVault = op vault get Environment 2>$null
    if ($existingVault -and -not $Force) {
        Write-Host "   ✓ Environment vault already exists" -ForegroundColor Green
    } elseif ($existingVault -and $Force) {
        Write-Host "   ! Environment vault exists, but Force flag is set" -ForegroundColor Yellow
    } else {
        $vaultResult = op vault create Environment --description "Vault for storing environment variables and secrets" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "   ✓ Environment vault created successfully" -ForegroundColor Green
        } else {
            Write-Error "Failed to create Environment vault: $vaultResult"
            exit 1
        }
    }
} catch {
    Write-Error "Failed to create Environment vault: $($_.Exception.Message)"
    exit 1
}

# Step 2: Create service account
Write-Host "2. Creating service account..." -ForegroundColor Yellow
$serviceAccountName = "Environment Service Account"

try {
    # Check if service account already exists by trying to list service accounts
    # Note: There's no direct way to check if a specific service account exists
    $createServiceAccount = $true
    
    if (-not $Force) {
        $confirm = Read-Host "   Create new service account '$serviceAccountName'? This will generate a new token. (Y/n)"
        if ($confirm -and $confirm.ToLower() -ne 'y' -and $confirm.ToLower() -ne 'yes') {
            Write-Host "   Skipped service account creation" -ForegroundColor Yellow
            $createServiceAccount = $false
        }
    }
    
    if ($createServiceAccount) {
        $serviceAccountResult = op service-account create $serviceAccountName --vault "Environment:read_items,write_items" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "   ✓ Service account created successfully" -ForegroundColor Green
            
            # Extract the token from the output
            # The token appears in the output and starts with "ops_"
            $tokenMatches = $serviceAccountResult | Select-String "ops_[A-Za-z0-9_-]+" -AllMatches
            $token = $tokenMatches.Matches[0].Value  # Get only the first match
            
            if ($token) {
                # Step 3: Store token as persistent environment variable
                Write-Host "3. Storing service account token..." -ForegroundColor Yellow
                try {
                    [Environment]::SetEnvironmentVariable("OP_SERVICE_ACCOUNT_TOKEN", $token, "User")
                    Write-Host "   ✓ Service account token stored as OP_SERVICE_ACCOUNT_TOKEN" -ForegroundColor Green
                    
                    # Update current session
                    $env:OP_SERVICE_ACCOUNT_TOKEN = $token
                    
                    Write-Host ""
                    Write-Host "Setup completed successfully!" -ForegroundColor Green
                    Write-Host ""
                    Write-Host "Service account token: $token" -ForegroundColor Cyan
                    Write-Host "Environment variable: OP_SERVICE_ACCOUNT_TOKEN" -ForegroundColor Cyan
                    Write-Host ""
                    Write-Host "The token has been stored as a persistent user environment variable." -ForegroundColor Yellow
                    Write-Host "You may need to restart PowerShell or reload your profile to use it." -ForegroundColor Yellow
                    
                } catch {
                    Write-Error "Failed to store service account token: $($_.Exception.Message)"
                    Write-Host "Manual setup required:" -ForegroundColor Yellow
                    Write-Host "  [Environment]::SetEnvironmentVariable('OP_SERVICE_ACCOUNT_TOKEN', '$token', 'User')" -ForegroundColor Cyan
                    exit 1
                }
            } else {
                Write-Error "Could not extract service account token from output"
                Write-Host "Service account output:" -ForegroundColor Yellow
                Write-Host $serviceAccountResult
                exit 1
            }
        } else {
            Write-Error "Failed to create service account: $serviceAccountResult"
            exit 1
        }
    }
} catch {
    Write-Error "Failed to create service account: $($_.Exception.Message)"
    exit 1
}

# Step 4: Test the setup
Write-Host "4. Testing service account access..." -ForegroundColor Yellow
try {
    # Remove any existing session variables to test service account
    Get-Variable -Name "OP_SESSION_*" -ErrorAction SilentlyContinue | Remove-Variable -ErrorAction SilentlyContinue
    
    # Test vault access
    $testResult = op vault list 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✓ Service account authentication working" -ForegroundColor Green
        
        # Check if Environment vault is accessible
        $environmentVault = op vault get Environment 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "   ✓ Environment vault accessible via service account" -ForegroundColor Green
        } else {
            Write-Warning "Service account may not have access to Environment vault"
            Write-Host "   Test result: $environmentVault" -ForegroundColor Yellow
        }
    } else {
        Write-Warning "Service account authentication may not be working properly"
        Write-Host "   Test result: $testResult" -ForegroundColor Yellow
    }
} catch {
    Write-Warning "Could not test service account setup: $($_.Exception.Message)"
}

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Restart PowerShell or run: refreshenv" -ForegroundColor White
Write-Host "2. Test with: op vault list" -ForegroundColor White
Write-Host "3. Create environment variables with: Set-1PEnvVar -Key 'TEST' -Value 'value' -Vault 'Environment'" -ForegroundColor White