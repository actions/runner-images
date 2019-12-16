################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install Azure CLI
################################################################################

choco install azure-cli -y

$AzureCliExtensionPath = Join-Path $Env:CommonProgramFiles 'AzureCliExtensionDirectory'
New-Item -ItemType "directory" -Path $AzureCliExtensionPath

[Environment]::SetEnvironmentVariable("AZURE_EXTENSION_DIR", $AzureCliExtensionPath, [System.EnvironmentVariableTarget]::Machine)
$Env:AZURE_EXTENSION_DIR = $AzureCliExtensionPath
