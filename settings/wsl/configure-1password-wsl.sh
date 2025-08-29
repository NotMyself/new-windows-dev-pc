#!/bin/bash
# Configure 1Password service account token in WSL

echo "🔑 Setting up 1Password CLI in WSL"

# Check if 1Password CLI is available
if ! command -v op &> /dev/null; then
    echo "❌ 1Password CLI not found. Please install it first."
    exit 1
fi

# Get service account token from Windows environment
WINDOWS_TOKEN=$(powershell.exe -NoProfile -Command 'Write-Output $env:OP_SERVICE_ACCOUNT_TOKEN' | tr -d '\r')

if [ -z "$WINDOWS_TOKEN" ]; then
    echo "❌ OP_SERVICE_ACCOUNT_TOKEN not found in Windows environment"
    echo "Run the Windows setup first: .\\settings\\1password\\setup-environment-vault.ps1"
    exit 1
fi

# Create WSL config directory
mkdir -p ~/.config/wsl

# Add token to bashrc if not already there
if ! grep -q "OP_SERVICE_ACCOUNT_TOKEN" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# 1Password Service Account Token (from Windows environment)" >> ~/.bashrc
    echo "export OP_SERVICE_ACCOUNT_TOKEN=\"$WINDOWS_TOKEN\"" >> ~/.bashrc
    echo "✅ 1Password service account token added to ~/.bashrc"
else
    echo "✅ 1Password service account token already configured in ~/.bashrc"
fi

# Set token for current session
export OP_SERVICE_ACCOUNT_TOKEN="$WINDOWS_TOKEN"

# Test access
echo "🧪 Testing 1Password access..."
if op vault list &> /dev/null; then
    echo "✅ Successfully authenticated with 1Password"
    echo "Available vaults:"
    op vault list | head -5
else
    echo "❌ Failed to authenticate with 1Password"
    echo "Token may be invalid or expired"
    exit 1
fi

echo "🎉 1Password CLI configured successfully in WSL!"