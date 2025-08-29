
<#
.SYNOPSIS
    Wraps a command execution with Azure environment variables.

.DESCRIPTION
    This cmdlet executes a specified command while ensuring Azure environment variables 
    (AZURE_*) are properly set in the execution context. It's particularly useful for 
    running MCP servers or other tools that require Azure authentication.

.PARAMETER Command
    The command to execute along with its arguments. This parameter accepts all remaining 
    arguments passed to the cmdlet.

.EXAMPLE
    .\wrap-call.ps1 npx -y @azure/mcp-server
    Runs the Azure MCP server with Azure environment variables set.

.EXAMPLE
    .\wrap-call.ps1 az account show
    Runs Azure CLI command with Azure environment variables set.

.NOTES
    This cmdlet reads all environment variables starting with "AZURE_" and ensures they 
    are available to the wrapped command. It's designed to work with Azure authentication 
    scenarios where environment variables need to be properly propagated.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true, HelpMessage = "The command to execute with Azure environment variables")]
    [string[]]$Command
)

# Read Azure environment variables
$azureEnvVars = @()
Get-ChildItem Env: | Where-Object { $_.Name -like "AZURE_*" } | ForEach-Object {
    $azureEnvVars += "$($_.Name)=$($_.Value)"
}

# Set Azure environment variables if they exist
if ($azureEnvVars.Count -gt 0) {
    $env:AZURE_SUBSCRIPTION_ID = $env:AZURE_SUBSCRIPTION_ID
    $env:AZURE_TENANT_ID = $env:AZURE_TENANT_ID
    $env:AZURE_CLIENT_ID = $env:AZURE_CLIENT_ID
    $env:AZURE_CLIENT_SECRET = $env:AZURE_CLIENT_SECRET
}

# Execute the provided command
& $Command[0] @($Command[1..($Command.Count - 1)])