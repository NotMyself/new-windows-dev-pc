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
 
Set-Alias -Name code -Value code-insiders

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
  $ProfilePath = Get-Item $profile | Select-Object -ExpandProperty Target
  $ExtensionFile = [System.IO.Path]::GetDirectoryName($ProfilePath) + '\..\vscode\extensions'
  code --list-extensions > $ExtensionFile
}

 function sln {
  Get-ChildItem *.sln | Invoke-Item
}
