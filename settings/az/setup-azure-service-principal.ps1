#!/usr/bin/env pwsh

<#
.SYNOPSIS
Sets up Azure CLI authentication and creates a service principal for automated access.

.DESCRIPTION
This script checks for Azure CLI availability, handles authentication, creates a service 
principal named "CLI Service Account", and stores the credentials (AZURE_CLIENT_ID, 
AZURE_CLIENT_SECRET, AZURE_SUBSCRIPTION_ID, AZURE_TENANT_ID) in 1Password using Set-1PEnvVar.

.PARAMETER ServicePrincipalName
Name for the service principal. Default is "CLI Service Account".

.PARAMETER SubscriptionId
Specific Azure subscription ID to use. If not provided, uses the default subscription.

.PARAMETER Vault
1Password vault name to store credentials. Default is "Environemnt".

.PARAMETER Force
Force creation of new service principal even if one exists.

.EXAMPLE
.\setup-azure-service-principal.ps1

.EXAMPLE
.\setup-azure-service-principal.ps1 -ServicePrincipalName "MyApp Service Principal" -Force

.EXAMPLE
.\setup-azure-service-principal.ps1 -SubscriptionId "12345678-1234-1234-1234-123456789012"

.NOTES
Requires Azure CLI (az) and 1Password CLI (op) to be installed and configured.
The service principal will have Contributor role on the subscription by default.
#>

[CmdletBinding()]
param(
    [string]$ServicePrincipalName = "CLI Service Account",
    [string]$SubscriptionId,
    [string]$Vault = "Environment",
    [switch]$Force
)

function Write-Step {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "  ✅ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "  ⚠️ $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "  ❌ $Message" -ForegroundColor Red
}

function Test-Command {
    param([string]$CommandName)
    return [bool](Get-Command -Name $CommandName -ErrorAction SilentlyContinue)
}

try {
    Write-Host ""
    Write-Host "Azure Service Principal Setup" -ForegroundColor Blue
    Write-Host "=============================" -ForegroundColor Blue
    Write-Host ""

    # Step 1: Check prerequisites
    Write-Step "Checking prerequisites..."
    
    if (-not (Test-Command 'az')) {
        Write-Error "Azure CLI (az) not found. Please install Azure CLI first."
        Write-Host ""
        Write-Host "Install Azure CLI:" -ForegroundColor Yellow
        Write-Host "• Windows: winget install Microsoft.AzureCLI" -ForegroundColor White
        Write-Host "• Or download from: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli" -ForegroundColor White
        exit 1
    }
    Write-Success "Azure CLI found"

    if (-not (Test-Command 'op')) {
        Write-Error "1Password CLI (op) not found. Please install and configure 1Password CLI first."
        Write-Host ""
        Write-Host "Run the 1Password setup script:" -ForegroundColor Yellow
        Write-Host "• .\settings\1password\setup-environment-vault.ps1" -ForegroundColor White
        exit 1
    }
    Write-Success "1Password CLI found"

    if (-not (Test-Command 'Set-1PEnvVar')) {
        Write-Error "Set-1PEnvVar function not found. Please ensure 1Password PowerShell module is loaded."
        Write-Host ""
        Write-Host "This function should be available after running:" -ForegroundColor Yellow
        Write-Host "• .\settings\1password\setup-environment-vault.ps1" -ForegroundColor White
        exit 1
    }
    Write-Success "1Password PowerShell functions available"

    # Step 2: Azure CLI Authentication
    Write-Host ""
    Write-Step "Azure CLI Authentication..."
    
    # Check if already authenticated
    try {
        $currentAccount = az account show --output json 2>$null | ConvertFrom-Json
        if ($currentAccount) {
            Write-Success "Already authenticated with Azure"
            Write-Host "    Account: $($currentAccount.user.name)" -ForegroundColor Gray
            Write-Host "    Subscription: $($currentAccount.name) ($($currentAccount.id))" -ForegroundColor Gray
            Write-Host "    Tenant: $($currentAccount.tenantId)" -ForegroundColor Gray
        }
    } catch {
        Write-Host "  Not currently authenticated with Azure" -ForegroundColor Yellow
        Write-Host ""
        
        # Attempt interactive login automatically
        Write-Host "  🚀 Starting interactive Azure authentication..." -ForegroundColor Green
        Write-Host "  This will open a browser window for authentication." -ForegroundColor Gray
        Write-Host ""
        
        try {
            Write-Host "  Running: az login" -ForegroundColor Gray
            $loginResult = az login --output json 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Success "Azure authentication successful!"
                
                # Get current account info
                $currentAccount = az account show --output json | ConvertFrom-Json
                Write-Host "    Account: $($currentAccount.user.name)" -ForegroundColor Gray
                Write-Host "    Subscription: $($currentAccount.name) ($($currentAccount.id))" -ForegroundColor Gray
                Write-Host "    Tenant: $($currentAccount.tenantId)" -ForegroundColor Gray
            } else {
                Write-Error "Interactive authentication failed"
                Write-Host ""
                Write-Host "  Alternative authentication options:" -ForegroundColor Yellow
                Write-Host "    Device code login: az login --use-device-code" -ForegroundColor Cyan
                Write-Host "    Service principal:  az login --service-principal -u <client-id> -p <client-secret> --tenant <tenant-id>" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "  Please authenticate manually and run this script again." -ForegroundColor Green
                exit 1
            }
        } catch {
            Write-Error "Authentication process failed: $($_.Exception.Message)"
            Write-Host ""
            Write-Host "  Please try manual authentication:" -ForegroundColor Yellow
            Write-Host "    az login" -ForegroundColor Cyan
            Write-Host "  Or device code login if browser is unavailable:" -ForegroundColor Yellow
            Write-Host "    az login --use-device-code" -ForegroundColor Cyan
            exit 1
        }
    }

    # Step 3: Set subscription if specified
    if ($SubscriptionId) {
        Write-Host ""
        Write-Step "Setting Azure subscription..."
        try {
            az account set --subscription $SubscriptionId
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Subscription set to: $SubscriptionId"
            } else {
                Write-Error "Failed to set subscription: $SubscriptionId"
                exit 1
            }
        } catch {
            Write-Error "Failed to set subscription: $($_.Exception.Message)"
            exit 1
        }
    }

    # Get current subscription details
    $currentAccount = az account show --output json | ConvertFrom-Json
    $subscriptionId = $currentAccount.id
    $tenantId = $currentAccount.tenantId
    
    Write-Host ""
    Write-Step "Using subscription: $($currentAccount.name) ($subscriptionId)"

    # Step 4: Create service principal
    Write-Host ""
    Write-Step "Creating service principal '$ServicePrincipalName'..."
    
    try {
        # Check if service principal already exists
        $existingSp = az ad sp list --display-name $ServicePrincipalName --output json | ConvertFrom-Json
        
        if ($existingSp -and $existingSp.Count -gt 0 -and -not $Force) {
            Write-Warning "Service principal '$ServicePrincipalName' already exists"
            Write-Host "    App ID: $($existingSp[0].appId)" -ForegroundColor Gray
            Write-Host "    Object ID: $($existingSp[0].id)" -ForegroundColor Gray
            Write-Host ""
            
            $continue = Read-Host "  Use existing service principal? (Y/n)"
            if ($continue -and $continue.ToLower() -ne 'y' -and $continue.ToLower() -ne 'yes' -and $continue -ne '') {
                Write-Host "  Operation cancelled by user" -ForegroundColor Yellow
                exit 0
            }
            
            $clientId = $existingSp[0].appId
            $clientSecret = $null # Cannot retrieve existing secret
            
            Write-Warning "Cannot retrieve existing client secret"
            Write-Host "    You'll need to create a new client secret manually or use -Force to create a new service principal" -ForegroundColor Gray
            
            # For existing SP, we'll need to create a new client secret
            Write-Step "Creating new client secret for existing service principal..."
            $secretResult = az ad app credential reset --id $clientId --append --display-name "Generated by setup script" --output json | ConvertFrom-Json
            
            if ($secretResult) {
                $clientSecret = $secretResult.password
                Write-Success "New client secret created for existing service principal"
            } else {
                Write-Error "Failed to create new client secret"
                exit 1
            }
            
        } elseif ($existingSp -and $existingSp.Count -gt 0 -and $Force) {
            Write-Warning "Service principal '$ServicePrincipalName' exists, but Force flag is set"
            Write-Step "Deleting existing service principal..."
            
            az ad sp delete --id $existingSp[0].id
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Existing service principal deleted"
            }
            
            # Create new service principal
            Write-Step "Creating new service principal..."
            $spResult = az ad sp create-for-rbac --name $ServicePrincipalName --role Contributor --scopes "/subscriptions/$subscriptionId" --output json | ConvertFrom-Json
            
            if ($spResult) {
                $clientId = $spResult.appId
                $clientSecret = $spResult.password
                Write-Success "Service principal created successfully"
                Write-Host "    App ID: $clientId" -ForegroundColor Gray
            } else {
                Write-Error "Failed to create service principal"
                exit 1
            }
            
        } else {
            # Create new service principal
            Write-Step "Creating new service principal..."
            $spResult = az ad sp create-for-rbac --name $ServicePrincipalName --role Contributor --scopes "/subscriptions/$subscriptionId" --output json | ConvertFrom-Json
            
            if ($spResult) {
                $clientId = $spResult.appId
                $clientSecret = $spResult.password
                Write-Success "Service principal created successfully"
                Write-Host "    App ID: $clientId" -ForegroundColor Gray
            } else {
                Write-Error "Failed to create service principal"
                exit 1
            }
        }

    } catch {
        Write-Error "Failed to create service principal: $($_.Exception.Message)"
        exit 1
    }

    # Step 5: Store credentials in 1Password
    Write-Host ""
    Write-Step "Storing Azure credentials in 1Password vault '$Vault'..."
    
    if (-not $clientSecret) {
        Write-Error "No client secret available to store"
        Write-Host ""
        Write-Host "  Manual steps required:" -ForegroundColor Yellow
        Write-Host "    1. Generate a new client secret for the service principal" -ForegroundColor White
        Write-Host "    2. Store the credentials manually using Set-1PEnvVar" -ForegroundColor White
        exit 1
    }

    try {
        # Store each credential with small delays to ensure proper processing
        Write-Host "  Storing AZURE_CLIENT_ID..." -ForegroundColor Gray
        Set-1PEnvVar -Key "AZURE_CLIENT_ID" -Value $clientId -Vault $Vault
        Write-Success "AZURE_CLIENT_ID stored"
        Start-Sleep -Milliseconds 500

        Write-Host "  Storing AZURE_CLIENT_SECRET..." -ForegroundColor Gray  
        Set-1PEnvVar -Key "AZURE_CLIENT_SECRET" -Value $clientSecret -Vault $Vault
        Write-Success "AZURE_CLIENT_SECRET stored"
        Start-Sleep -Milliseconds 500

        Write-Host "  Storing AZURE_SUBSCRIPTION_ID..." -ForegroundColor Gray
        Set-1PEnvVar -Key "AZURE_SUBSCRIPTION_ID" -Value $subscriptionId -Vault $Vault  
        Write-Success "AZURE_SUBSCRIPTION_ID stored"
        Start-Sleep -Milliseconds 500

        Write-Host "  Storing AZURE_TENANT_ID..." -ForegroundColor Gray
        Set-1PEnvVar -Key "AZURE_TENANT_ID" -Value $tenantId -Vault $Vault
        Write-Success "AZURE_TENANT_ID stored"

        Write-Host ""
        Write-Success "All Azure credentials stored in 1Password vault '$Vault'"

    } catch {
        Write-Error "Failed to store credentials in 1Password: $($_.Exception.Message)"
        Write-Host ""
        Write-Host "  Manual storage required:" -ForegroundColor Yellow
        Write-Host "    Set-1PEnvVar -Key 'AZURE_CLIENT_ID' -Value '$clientId' -Vault '$Vault'" -ForegroundColor Cyan
        Write-Host "    Set-1PEnvVar -Key 'AZURE_CLIENT_SECRET' -Value '$clientSecret' -Vault '$Vault'" -ForegroundColor Cyan
        Write-Host "    Set-1PEnvVar -Key 'AZURE_SUBSCRIPTION_ID' -Value '$subscriptionId' -Vault '$Vault'" -ForegroundColor Cyan
        Write-Host "    Set-1PEnvVar -Key 'AZURE_TENANT_ID' -Value '$tenantId' -Vault '$Vault'" -ForegroundColor Cyan
        exit 1
    }

    # Step 6: Test service principal authentication
    Write-Host ""
    Write-Step "Testing service principal authentication..."
    
    try {
        # Test login with service principal
        $testLogin = az login --service-principal -u $clientId -p $clientSecret --tenant $tenantId --output json 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Service principal authentication test passed"
            
            # Switch back to user authentication
            az login --output none 2>$null
        } else {
            Write-Warning "Service principal authentication test failed"
            Write-Host "    This might be due to propagation delay. Try again in a few minutes." -ForegroundColor Gray
        }
    } catch {
        Write-Warning "Could not test service principal authentication: $($_.Exception.Message)"
    }

    # Step 7: Summary and next steps
    Write-Host ""
    Write-Host "Setup Complete! 🎉" -ForegroundColor Green
    Write-Host "=================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Azure Service Principal Details:" -ForegroundColor White
    Write-Host "• Name: $ServicePrincipalName" -ForegroundColor Gray
    Write-Host "• Client ID: $clientId" -ForegroundColor Gray
    Write-Host "• Subscription: $subscriptionId" -ForegroundColor Gray
    Write-Host "• Tenant: $tenantId" -ForegroundColor Gray
    Write-Host "• Role: Contributor (subscription scope)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Credentials stored in 1Password vault '$Vault':" -ForegroundColor White
    Write-Host "• AZURE_CLIENT_ID" -ForegroundColor Gray
    Write-Host "• AZURE_CLIENT_SECRET" -ForegroundColor Gray
    Write-Host "• AZURE_SUBSCRIPTION_ID" -ForegroundColor Gray
    Write-Host "• AZURE_TENANT_ID" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Cyan
    Write-Host "1. Restart PowerShell or run: refreshenv" -ForegroundColor White
    Write-Host "2. Test environment variables: Get-1PEnvVar -Key 'AZURE_CLIENT_ID' -Vault '$Vault'" -ForegroundColor White
    Write-Host "3. Test Azure CLI with service principal: az login --service-principal -u `$env:AZURE_CLIENT_ID -p `$env:AZURE_CLIENT_SECRET --tenant `$env:AZURE_TENANT_ID" -ForegroundColor White
    Write-Host ""

} catch {
    Write-Error "Setup failed: $($_.Exception.Message)"
    Write-Host ""
    Write-Host "Please check the error details above and try again." -ForegroundColor Gray
    exit 1
}