# enable oh my posh prompt
oh-my-posh init pwsh --config ~/.theme.omp.json | Invoke-Expression

# enable fnm fast node manager
fnm completions --shell powershell | Out-String | Invoke-Expression
fnm env --use-on-cd | Out-String | Invoke-Expression

# History
 
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
 
# Alias
 
function ~ {
  Set-Location ~
}

function .. {
  Set-Location ..
}

function .... {
  Set-Location ../../
}

function ...... {
  Set-Location ../../../
}

function oss {
  Set-Location "~/src/oss/$args"
}

function work {
  Set-Location "~/src/ofm/$args"
}

function touch {
  New-Item -ItemType File -Name $args[0]
}

function mkdir {
  New-Item -ItemType Directory -Name $args[0]
}

function rmdir {
  Remove-Item -Recurse -Force $args[0]
}

function rm {
  Remove-Item -Force $args[0]
}

function mv {
  Move-Item $args[0] $args[1]
}

function cp {
  Copy-Item $args[0] $args[1]
}

function ls {
  Get-ChildItem $args[0]
}

function backup-vs {
    <#
    .SYNOPSIS
    Backs up currently installed VSCode extensions to the extensions file.
    #>
    try {
        if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
            Write-Error "VSCode CLI not found. Please ensure VSCode is installed and in PATH."
            return
        }
        
        $ProfilePath = Get-Item $profile | Select-Object -ExpandProperty Target
        $ExtensionFile = Join-Path (Split-Path $ProfilePath -Parent) "..\vscode\extensions"
        
        if (-not (Test-Path (Split-Path $ExtensionFile -Parent))) {
            Write-Error "VSCode settings directory not found: $(Split-Path $ExtensionFile -Parent)"
            return
        }
        
        $extensions = code --list-extensions
        $extensions | Sort-Object | Out-File -FilePath $ExtensionFile -Encoding UTF8
        
        Write-Host "VSCode extensions backed up to: $ExtensionFile" -ForegroundColor Green
        Write-Host "Found $($extensions.Count) extensions" -ForegroundColor Cyan
    }
    catch {
        Write-Error "Failed to backup VSCode extensions: $($_.Exception.Message)"
    }
}

function sln {
    <#
    .SYNOPSIS
    Opens the first .sln file found in the current directory.
    #>
    try {
        $slnFiles = Get-ChildItem -Filter "*.sln"
        
        if ($slnFiles.Count -eq 0) {
            Write-Warning "No .sln files found in the current directory."
            return
        }
        
        if ($slnFiles.Count -eq 1) {
            Write-Host "Opening: $($slnFiles[0].Name)" -ForegroundColor Green
            Invoke-Item $slnFiles[0]
        } else {
            Write-Host "Multiple .sln files found:" -ForegroundColor Yellow
            for ($i = 0; $i -lt $slnFiles.Count; $i++) {
                Write-Host "  [$i] $($slnFiles[$i].Name)"
            }
            $selection = Read-Host "Select file to open (0-$($slnFiles.Count-1))"
            
            if ($selection -match '^\d+$' -and [int]$selection -lt $slnFiles.Count) {
                Write-Host "Opening: $($slnFiles[[int]$selection].Name)" -ForegroundColor Green
                Invoke-Item $slnFiles[[int]$selection]
            } else {
                Write-Error "Invalid selection: $selection"
            }
        }
    }
    catch {
        Write-Error "Failed to open solution file: $($_.Exception.Message)"
    }
}

# Additional utility functions
function which {
    param([Parameter(Mandatory)][string]$Command)
    Get-Command $Command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source
}

function grep {
    param(
        [Parameter(Mandatory)][string]$Pattern,
        [string]$Path = "."
    )
    Select-String -Pattern $Pattern -Path $Path -Recurse
}

function find {
    param(
        [Parameter(Mandatory)][string]$Name,
        [string]$Path = "."
    )
    Get-ChildItem -Path $Path -Recurse -Filter $Name -ErrorAction SilentlyContinue
}
