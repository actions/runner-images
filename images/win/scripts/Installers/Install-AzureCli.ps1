################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install Azure CLI
################################################################################

# Stick to 2.18.0 since 2.19 contains a bug https://github.com/Azure/azure-cli/issues/16908
Choco-Install -PackageName azure-cli --version 2.18.0

$AzureCliExtensionPath = Join-Path $Env:CommonProgramFiles 'AzureCliExtensionDirectory'
New-Item -ItemType "directory" -Path $AzureCliExtensionPath

[Environment]::SetEnvironmentVariable("AZURE_EXTENSION_DIR", $AzureCliExtensionPath, [System.EnvironmentVariableTarget]::Machine)

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure CLI"