################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install Azure CLI
################################################################################

# Temporary hardcode 2.5.1 installation until version 2.7.0 with the fix for the issue is not released https://github.com/actions/virtual-environments/issues/948
Choco-Install -PackageName azure-cli -ArgumentList "--version=2.5.1"

$AzureCliExtensionPath = Join-Path $Env:CommonProgramFiles 'AzureCliExtensionDirectory'
New-Item -ItemType "directory" -Path $AzureCliExtensionPath

[Environment]::SetEnvironmentVariable("AZURE_EXTENSION_DIR", $AzureCliExtensionPath, [System.EnvironmentVariableTarget]::Machine)
$Env:AZURE_EXTENSION_DIR = $AzureCliExtensionPath
