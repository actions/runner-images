################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install Azure CLI
################################################################################

Write-Host "Install the latest Azure CLI release"
$assets = Invoke-RestMethod -Uri 'https://api.github.com/repos/Azure/azure-cli/releases/latest'
$azCliUrl = $assets.assets.browser_download_url
$azCliName = [IO.Path]::GetFileName($azCliUrl)
Install-Binary -Url $azCliUrl -Name $azCliName -ArgumentList ("/qn", "/norestart")

$azureCliExtensionPath = Join-Path $Env:CommonProgramFiles 'AzureCliExtensionDirectory'
$null = New-Item -ItemType "Directory" -Path $azureCliExtensionPath

[Environment]::SetEnvironmentVariable("AZURE_EXTENSION_DIR", $azureCliExtensionPath, [System.EnvironmentVariableTarget]::Machine)

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure CLI"