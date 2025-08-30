# Secrets Reference Guide

This document catalogs available secrets in 1Password vaults and provides secure retrieval patterns for Claude Code workflows.

## Available Secrets by Category

### Azure DevOps Integration

#### Personal Access Tokens
```powershell
# Development environment PAT
$devopsPAT = op item get "Azure-DevOps-PAT-Development" --field password

# Production environment PAT  
$devopsPATProduction = op item get "Azure-DevOps-PAT-Production" --field password
```

#### Service Connections
```powershell
# Azure service principal credentials
$azureClientId = op item get "Azure-Service-Principal" --field "Client ID"
$azureClientSecret = op item get "Azure-Service-Principal" --field password
$azureTenantId = op item get "Azure-Service-Principal" --field "Tenant ID"
$azureSubscriptionId = op item get "Azure-Service-Principal" --field "Subscription ID"
```

### Database Connections

#### SQL Server
```powershell
# Development database
$dbConnectionDev = op item get "SQL-Connection-Development" --field password

# Production database (restricted access)
$dbConnectionProd = op item get "SQL-Connection-Production" --field password
```

#### Connection String Assembly
```powershell
# Build connection string securely
$server = op item get "SQL-Server-Development" --field "Server"
$database = op item get "SQL-Server-Development" --field "Database"  
$username = op item get "SQL-Server-Development" --field "Username"
$password = op item get "SQL-Server-Development" --field password

$connectionString = "Server=$server;Database=$database;User Id=$username;Password=$password;Encrypt=true;"
```

### API Keys and Tokens

#### External Services
```powershell
# GitHub integration
$githubToken = op item get "GitHub-PAT-Integration" --field password

# NuGet package publishing
$nugetApiKey = op item get "NuGet-API-Key" --field password

# Third-party APIs
$externalApiKey = op item get "External-Service-API" --field password
```

## Secure Retrieval Patterns

### Basic Retrieval with Error Handling

```powershell
function Get-SecureSecret {
    param(
        [Parameter(Mandatory)]
        [string]$ItemName,
        
        [string]$FieldName = "password"
    )
    
    try {
        $secret = op item get $ItemName --field $FieldName
        if ([string]::IsNullOrEmpty($secret)) {
            throw "Secret is empty or null"
        }
        return $secret
    }
    catch {
        Write-Error "Failed to retrieve secret '$ItemName': $_"
        throw
    }
}

# Usage
$azurePAT = Get-SecureSecret -ItemName "Azure-DevOps-PAT-Development"
```

### Batch Secret Retrieval

```powershell
function Get-AzureDevOpsSecrets {
    $secrets = @{}
    
    $secretMappings = @{
        'PAT' = 'Azure-DevOps-PAT-Development'
        'ClientId' = 'Azure-Service-Principal|Client ID'
        'ClientSecret' = 'Azure-Service-Principal|password'
        'TenantId' = 'Azure-Service-Principal|Tenant ID'
        'SubscriptionId' = 'Azure-Service-Principal|Subscription ID'
    }
    
    foreach ($key in $secretMappings.Keys) {
        $itemAndField = $secretMappings[$key] -split '\|'
        $itemName = $itemAndField[0]
        $fieldName = if ($itemAndField.Length -gt 1) { $itemAndField[1] } else { 'password' }
        
        try {
            $secrets[$key] = op item get $itemName --field $fieldName
        }
        catch {
            Write-Warning "Failed to retrieve $key from $itemName"
            throw
        }
    }
    
    return $secrets
}
```

### Environment Variable Injection

```powershell
function Set-SecureEnvironmentVariables {
    # Set Azure DevOps environment variables
    $env:AZURE_DEVOPS_EXT_PAT = op item get "Azure-DevOps-PAT-Development" --field password
    $env:AZURE_CLIENT_ID = op item get "Azure-Service-Principal" --field "Client ID"  
    $env:AZURE_CLIENT_SECRET = op item get "Azure-Service-Principal" --field password
    $env:AZURE_TENANT_ID = op item get "Azure-Service-Principal" --field "Tenant ID"
    $env:AZURE_SUBSCRIPTION_ID = op item get "Azure-Service-Principal" --field "Subscription ID"
    
    Write-Host "Environment variables set securely from 1Password"
}
```

## Claude Code Integration Patterns

### Azure DevOps API Authentication

```powershell
# Secure Azure DevOps REST API calls
function Invoke-AzureDevOpsAPI {
    param(
        [Parameter(Mandatory)]
        [string]$Uri,
        
        [string]$Method = "GET",
        [hashtable]$Body = $null
    )
    
    $pat = op item get "Azure-DevOps-PAT-Development" --field password
    $encodedPat = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$pat"))
    
    $headers = @{
        'Authorization' = "Basic $encodedPat"
        'Content-Type' = 'application/json'
    }
    
    $params = @{
        Uri = $Uri
        Method = $Method
        Headers = $headers
    }
    
    if ($Body) {
        $params.Body = $Body | ConvertTo-Json -Depth 10
    }
    
    try {
        return Invoke-RestMethod @params
    }
    catch {
        Write-Error "Azure DevOps API call failed: $_"
        throw
    }
}
```

### Git Operations with PAT

```bash
# Secure git operations using 1Password CLI
git_with_token() {
    local repo_url="$1"
    local operation="$2"
    
    local github_token=$(op item get "GitHub-PAT-Integration" --field password)
    
    # Clone with token authentication
    git clone "https://${github_token}@${repo_url#https://}"
}
```

## Security Best Practices

### Never Log Secrets

```powershell
# ❌ WRONG - Never do this
Write-Host "Using token: $secret"
Write-Output "Connection string: $connectionString"

# ✅ CORRECT - Log safely
Write-Host "Authentication successful"
Write-Output "Database connection established"
```

### Secure Variable Scope

```powershell
function Invoke-SecureOperation {
    # Use local scope for secrets
    $secret = op item get "API-Key" --field password
    
    try {
        # Use secret for operation
        $result = Invoke-APICall -ApiKey $secret
        return $result
    }
    finally {
        # Clear secret from memory
        $secret = $null
        [System.GC]::Collect()
    }
}
```

### Validation and Sanitization

```powershell
function Test-SecretFormat {
    param([string]$Secret, [string]$ExpectedPattern)
    
    if ([string]::IsNullOrWhiteSpace($Secret)) {
        throw "Secret is null or empty"
    }
    
    if ($ExpectedPattern -and $Secret -notmatch $ExpectedPattern) {
        throw "Secret format is invalid"
    }
    
    return $true
}

# Usage
$pat = op item get "Azure-DevOps-PAT" --field password
Test-SecretFormat -Secret $pat -ExpectedPattern '^[a-zA-Z0-9]{52}$'
```

## Environment-Specific Patterns

### Development Environment

```powershell
# Development secrets (more permissive logging for debugging)
function Get-DevelopmentSecrets {
    $secrets = @{
        'DevOps' = op item get "Azure-DevOps-PAT-Development" --field password
        'Database' = op item get "SQL-Connection-Development" --field password
    }
    
    # Safe to log connection success in development
    Write-Host "Development secrets loaded successfully"
    return $secrets
}
```

### Production Environment

```powershell
# Production secrets (minimal logging, maximum security)
function Get-ProductionSecrets {
    $secrets = @{}
    
    try {
        $secrets['DevOps'] = op item get "Azure-DevOps-PAT-Production" --field password
        $secrets['Database'] = op item get "SQL-Connection-Production" --field password
        
        # Minimal logging in production
        Write-Host "Production authentication configured"
        return $secrets
    }
    catch {
        Write-Error "Production secret retrieval failed"
        throw
    }
}
```

## Troubleshooting Secret Retrieval

### Common Error Scenarios

```powershell
function Test-SecretAccess {
    $testResults = @{}
    
    # Test 1Password CLI accessibility
    try {
        op vault list | Out-Null
        $testResults['1PasswordCLI'] = 'Success'
    }
    catch {
        $testResults['1PasswordCLI'] = "Failed: $_"
    }
    
    # Test specific secret access
    try {
        $testSecret = op item get "Azure-DevOps-PAT-Development" --field password
        $testResults['SecretAccess'] = if ($testSecret) { 'Success' } else { 'Empty' }
    }
    catch {
        $testResults['SecretAccess'] = "Failed: $_"
    }
    
    return $testResults
}
```

### Debug Helpers

```powershell
function Debug-SecretConfiguration {
    Write-Host "=== 1Password Secret Configuration Debug ==="
    
    # Check environment variable
    if ($env:OP_SERVICE_ACCOUNT_TOKEN) {
        Write-Host "✓ OP_SERVICE_ACCOUNT_TOKEN is set"
    } else {
        Write-Host "✗ OP_SERVICE_ACCOUNT_TOKEN is not set"
    }
    
    # Check CLI installation
    try {
        $version = op --version
        Write-Host "✓ 1Password CLI version: $version"
    }
    catch {
        Write-Host "✗ 1Password CLI not installed or not in PATH"
    }
    
    # Test authentication
    try {
        $vaults = op vault list
        Write-Host "✓ Authentication successful, accessible vaults: $($vaults.Count)"
    }
    catch {
        Write-Host "✗ Authentication failed: $_"
    }
}
```

## Migration from Other Secret Stores

### From Azure Key Vault

```powershell
# Migrate secrets from Azure Key Vault to 1Password
function Copy-AzureKeyVaultTo1Password {
    param(
        [string]$KeyVaultName,
        [hashtable]$SecretMappings
    )
    
    foreach ($azSecret in $SecretMappings.Keys) {
        $onePasswordItem = $SecretMappings[$azSecret]
        
        # Get from Azure Key Vault
        $secret = Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $azSecret
        
        # Store in 1Password (requires manual creation of items first)
        Write-Host "Migrate '$azSecret' to 1Password item '$onePasswordItem'"
    }
}
```

## Documentation Maintenance

Keep this reference updated:

1. **Add new secrets** when creating 1Password items
2. **Update patterns** when changing naming conventions  
3. **Review quarterly** for unused or expired secrets
4. **Validate examples** when updating 1Password CLI

Last updated: [Update this when modifying the file]