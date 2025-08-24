# Load environment variables from 1Password secure note

try {
    $noteText = op item get "Local Environment Variables" --vault "Environment" --fields "notesPlain"
    
    $lines = $noteText -split "`r?`n"
    $config = @{}
    
    foreach ($line in $lines) {
        if ($line -match "^(.+?):(.+)$") {
            $key = $matches[1].Trim().Trim('"')
            $value = $matches[2].Trim().Trim('"')
            $config[$key] = $value
        }
    }
    
    # Set all environment variables from the note
    $loadedCount = 0
    foreach ($key in $config.Keys) {
        if ($key -and $config[$key]) {
            Set-Item -Path "env:$key" -Value $config[$key]
            $loadedCount++
        }
    }
    
    Write-Host "Loaded $loadedCount environment variables from 1Password" -ForegroundColor Green
    
} catch {
    Write-Host "Failed to load environment variables from 1Password: $($_.Exception.Message)" -ForegroundColor Red
}