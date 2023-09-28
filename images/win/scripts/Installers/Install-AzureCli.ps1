################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install Azure CLI
################################################################################

Write-Host "Install the latest Azure CLI release"
$azCliUrl = "https://aka.ms/installazurecliwindowsx64"
$azCliSignatureThumbprint = "72105B6D5F370B62FD5C82F1512F7AD7DEE5F2C0"
Install-Binary -Url $azCliUrl -Name "azure-cli.msi" -ExpectedSignature $azCliSignatureThumbprint

$azureCliExtensionPath = Join-Path $Env:CommonProgramFiles 'AzureCliExtensionDirectory'
$null = New-Item -ItemType "Directory" -Path $azureCliExtensionPath

[Environment]::SetEnvironmentVariable("AZURE_EXTENSION_DIR", $azureCliExtensionPath, [System.EnvironmentVariableTarget]::Machine)

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure CLI"
