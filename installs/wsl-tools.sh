#!/bin/bash
# WSL Development Environment Setup
# Sets up all tools needed for Claude Code development in WSL

set -e

echo "🚀 Setting up WSL development environment..."

# Update system
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install essential tools
echo "🔧 Installing essential development tools..."
sudo apt install -y \
    curl \
    wget \
    git \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    jq \
    zip \
    unzip

# Install Node.js (LTS via NodeSource)
echo "📦 Installing Node.js LTS..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Verify Node.js installation
node_version=$(node --version)
npm_version=$(npm --version)
echo "✅ Node.js $node_version and npm $npm_version installed"

# Install global npm packages for development
echo "📦 Installing global npm packages..."
npm install -g \
    markdownlint-cli \
    prettier \
    typescript \
    eslint \
    @typescript-eslint/parser \
    @typescript-eslint/eslint-plugin

# Install .NET SDK (latest)
echo "📦 Installing .NET SDK..."
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update
sudo apt install -y dotnet-sdk-8.0

# Verify .NET installation
dotnet_version=$(dotnet --version)
echo "✅ .NET SDK $dotnet_version installed"

# Install Azure CLI
echo "📦 Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Verify Azure CLI installation
az_version=$(az --version | head -1)
echo "✅ Azure CLI installed: $az_version"

# Install 1Password CLI
echo "📦 Installing 1Password CLI..."
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo apt update && sudo apt install -y 1password-cli

# Verify 1Password CLI installation
op_version=$(op --version)
echo "✅ 1Password CLI $op_version installed"

# Configure Git for Claude Code identity
echo "🔧 Configuring Git for Claude Code..."
git config --global user.name "Claude Code"
git config --global user.email "claude-code@anthropic.com"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main

# Create source directory symlinks
echo "🔗 Creating source directory symlinks..."
mkdir -p ~/src
if [ ! -L ~/src/new-windows-dev-pc ]; then
    ln -sf /mnt/c/Users/bobby/src/new-windows-dev-pc ~/src/new-windows-dev-pc
    echo "✅ Created symlink: ~/src/new-windows-dev-pc -> /mnt/c/Users/bobby/src/new-windows-dev-pc"
fi

# Create root source directory for easier access
sudo mkdir -p /root/src
if [ ! -L /root/src/new-windows-dev-pc ]; then
    sudo ln -sf /mnt/c/Users/bobby/src/new-windows-dev-pc /root/src/new-windows-dev-pc
    echo "✅ Created root symlink: /root/src/new-windows-dev-pc"
fi

# Verify tool installations
echo ""
echo "🧪 Verifying tool installations..."
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "prettier: $(prettier --version)"
echo "markdownlint: $(markdownlint --version)"
echo ".NET: $(dotnet --version)"
echo "Azure CLI: $(az version --output tsv --query '"azure-cli"')"
echo "1Password CLI: $(op --version)"
echo "Git: $(git --version)"

# Test npm global packages
echo ""
echo "🧪 Testing npm global packages..."
if command -v prettier &> /dev/null; then
    echo "✅ prettier available globally"
else
    echo "❌ prettier not found in PATH"
fi

if command -v markdownlint &> /dev/null; then
    echo "✅ markdownlint available globally"
else
    echo "❌ markdownlint not found in PATH"
fi

# Display tool locations
echo ""
echo "📍 Tool locations:"
echo "Node.js: $(which node)"
echo "npm: $(which npm)"
echo "prettier: $(which prettier)"
echo "markdownlint: $(which markdownlint)"
echo "dotnet: $(which dotnet)"
echo "az: $(which az)"
echo "op: $(which op)"
echo "git: $(which git)"

echo ""
echo "🎉 WSL development environment setup complete!"
echo ""
echo "Next steps:"
echo "1. Run 1Password setup: ./settings/wsl/configure-1password-wsl.sh"
echo "2. Configure Claude Code WSL settings"
echo "3. Test formatting tools: prettier --check . && markdownlint ."