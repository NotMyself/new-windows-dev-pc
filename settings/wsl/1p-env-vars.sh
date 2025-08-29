#!/bin/bash
# Load environment variables from 1Password secure note

load_1password_env() {
    if ! command -v op &> /dev/null; then
        echo "❌ 1Password CLI not found"
        return 1
    fi

    # Check for service account token
    if [ -z "$OP_SERVICE_ACCOUNT_TOKEN" ]; then
        echo "❌ OP_SERVICE_ACCOUNT_TOKEN not set"
        return 1
    fi

    # Load environment variables from 1Password note
    local note_content
    note_content=$(op item get "Local Environment Variables" --vault "Environment" --fields "notesPlain" 2>/dev/null)
    
    if [ $? -ne 0 ]; then
        echo "❌ Failed to load environment variables from 1Password"
        return 1
    fi

    local loaded_count=0
    
    # Parse key:value pairs from note
    while IFS= read -r line; do
        if [[ $line =~ ^([^:]+):(.+)$ ]]; then
            local key="${BASH_REMATCH[1]// /}"  # Remove spaces
            local value="${BASH_REMATCH[2]// /}"  # Remove spaces
            
            # Remove quotes if present
            key="${key//\"/}"
            value="${value//\"/}"
            
            if [ -n "$key" ] && [ -n "$value" ]; then
                export "$key"="$value"
                ((loaded_count++))
            fi
        fi
    done <<< "$note_content"
    
    echo "✅ Loaded $loaded_count environment variables from 1Password"
}

# Function to set up 1Password token from Windows
setup_1password_token() {
    if [ -z "$OP_SERVICE_ACCOUNT_TOKEN" ]; then
        local windows_token
        windows_token=$(powershell.exe -NoProfile -Command 'Write-Output $env:OP_SERVICE_ACCOUNT_TOKEN' 2>/dev/null | tr -d '\r')
        
        if [ -n "$windows_token" ]; then
            export OP_SERVICE_ACCOUNT_TOKEN="$windows_token"
            echo "✅ 1Password service account token loaded from Windows"
        else
            echo "❌ Could not load 1Password token from Windows environment"
            return 1
        fi
    fi
}

# Auto-setup when sourced
setup_1password_token