# Browser
# winget install Microsoft.Edge.Beta
# winget install Google.Chrome.Beta
# winget install Mozilla.Firefox.DeveloperEdition


 
# Windows and CLI
winget install Microsoft.PowerToys # https://github.com/microsoft/PowerToys
winget install Microsoft.WindowsTerminal
winget install Microsoft.PowerShell
winget install JanDeDobbeleer.OhMyPosh
 
# Git
winget install Git.Git
winget install GitHub.GitLFS
winget install GitHub.cli
 
# Development Enviroment
winget install Microsoft.dotnet
winget install Schniz.fnm
 
# IDE
winget install Microsoft.VisualStudio.2022.Professional --override "--passive --config $PSScriptRoot\..\settings\visual-studio\.vsconfig"
winget install Microsoft.VisualStudioCode.Insiders
winget install Microsoft.VisualStudioCode.Insiders.CLI
# winget install Microsoft.SQLServer.2019.Developer
# winget install Microsoft.SQLServerManagementStudio
winget install Microsoft.AzureDataStudio.Insiders
 
winget install JetBrains.ReSharper
