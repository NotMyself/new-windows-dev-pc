# 1Password Service Account Setup

This guide covers the setup and configuration of 1Password service accounts for secure secret management in Claude Code workflows.

## Prerequisites

- 1Password Business account with service account support
- Administrative access to create service accounts
- Windows environment with PowerShell 7+

## Service Account Creation

### 1. Create Service Account in 1Password

1. Sign in to 1Password Business console
2. Navigate to **Integrations** → **Service Accounts**
3. Click **Create Service Account**
4. Configure:
   - **Name**: `Claude-Code-DevOps`
   - **Description**: `Service account for Claude Code Azure DevOps integration`
   - **Vaults**: Select vaults containing development secrets

### 2. Generate Service Account Token

1. After creating the service account, copy the generated token
2. **CRITICAL**: This token is shown only once - store it securely
3. The token format: `ops_xxx_xxxxxxxxxxxxxxxxxxxxxxxxxx`

### 3. Store Token in 1Password

**Important**: Store the service account token itself in 1Password for team access:

1. Create new item in 1Password:
   - **Title**: `Claude Code Service Account Token`
   - **Type**: Password
   - **Password Field**: Paste the service account token
   - **Notes**: Include vault access details and creation date

## Local Environment Configuration

### Windows Environment Variable Setup

Set the service account token as a user environment variable:

```powershell
# Set user environment variable (recommended)
[Environment]::SetEnvironmentVariable("OP_SERVICE_ACCOUNT_TOKEN", "ops_xxx_xxxxxxxxxxxxxxxxxxxxxxxxxx", "User")

# Verify the variable is set
$env:OP_SERVICE_ACCOUNT_TOKEN
```

### Alternative: System-Wide Configuration

For system-wide access (requires Administrator privileges):

```powershell
# Set system environment variable
[Environment]::SetEnvironmentVariable("OP_SERVICE_ACCOUNT_TOKEN", "ops_xxx_xxxxxxxxxxxxxxxxxxxxxxxxxx", "Machine")
```

## 1Password CLI Installation

### Install via WinGet

```powershell
winget install AgileBits.1Password.CLI
```

### Verify Installation

```powershell
op --version
```

### Test Authentication

```powershell
# Test service account authentication
op vault list

# Should show accessible vaults without additional authentication
```

## Vault Organization Best Practices

### Recommended Vault Structure

- **DevOps-Development**: Development environment secrets
- **DevOps-Staging**: Staging environment secrets  
- **DevOps-Production**: Production environment secrets
- **Team-Shared**: Shared development tools and services

### Secret Naming Conventions

Use consistent naming for easy retrieval:

```
Azure-DevOps-PAT-Development
Azure-DevOps-PAT-Production
SQL-Connection-Development
SQL-Connection-Production
```

## Security Considerations

### Token Lifecycle Management

- **Rotation Schedule**: Rotate service account tokens quarterly
- **Access Review**: Review vault access permissions monthly
- **Audit Logging**: Monitor service account usage in 1Password

### Environment Isolation

- Use separate service accounts for different environments
- Limit vault access to minimum required secrets
- Never share service account tokens between team members

### Error Handling

Common issues and solutions:

```powershell
# Check if token is set
if (-not $env:OP_SERVICE_ACCOUNT_TOKEN) {
    Write-Error "OP_SERVICE_ACCOUNT_TOKEN environment variable not set"
    exit 1
}

# Test connectivity before using
try {
    op vault list | Out-Null
    Write-Host "1Password authentication successful"
} catch {
    Write-Error "1Password authentication failed: $_"
    exit 1
}
```

## Team Collaboration

### Onboarding New Team Members

1. Grant access to appropriate vaults in 1Password Business
2. Provide this setup documentation
3. Verify they can retrieve test secrets
4. Document their access in team records

### Shared Configuration

Store common configurations in 1Password items:

- Database connection strings (without credentials)
- API endpoint URLs
- Configuration templates
- Environment-specific settings

## Troubleshooting

### Common Issues

**Token not recognized:**
- Verify environment variable is set correctly
- Check token format (should start with `ops_`)
- Ensure service account has vault access

**Authentication failures:**
- Verify 1Password CLI is installed and updated
- Check network connectivity
- Validate service account status in 1Password console

**Permission denied errors:**
- Review vault permissions for service account
- Check item-level access restrictions
- Verify vault sharing settings

### Getting Help

1. Check 1Password CLI documentation: `op --help`
2. Review 1Password Business console logs
3. Test with minimal vault access first
4. Contact 1Password support for service account issues

## Next Steps

After completing this setup:

1. Review the [Secrets Reference](secrets-reference.md) for available secrets
2. Test secret retrieval in Azure DevOps workflows
3. Configure automated secret rotation if required
4. Document any custom secret patterns for your team