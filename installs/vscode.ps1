Get-Content $PSScriptRoot\..\settings/vscode/extensions | ForEach-Object {
  Write-Output "Installing Extension $_"
  code-insiders --install-extension $_ --force
}