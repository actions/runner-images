################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install Azure CLI
################################################################################

Write-Host 'Install the latest Azure CLI release'

$azureCliConfigPath = 'C:\azureCli'
# Store azure-cli cache outside of the provisioning user's profile
[Environment]::SetEnvironmentVariable('AZURE_CONFIG_DIR', $azureCliConfigPath, [System.EnvironmentVariableTarget]::Machine)
# make variable to be available in the current session
${env:AZURE_CONFIG_DIR} = $azureCliConfigPath

$azCliUrl = 'https://aka.ms/installazurecliwindowsx64'
$azCliSignatureThumbprint = "72105B6D5F370B62FD5C82F1512F7AD7DEE5F2C0"
Install-Binary -Url $azCliUrl -Name 'azure-cli.msi' -ExpectedSignature $azCliSignatureThumbprint

$azureCliExtensionPath = Join-Path $Env:CommonProgramFiles 'AzureCliExtensionDirectory'
$null = New-Item -ItemType 'Directory' -Path $azureCliExtensionPath

[Environment]::SetEnvironmentVariable('AZURE_EXTENSION_DIR', $azureCliExtensionPath, [System.EnvironmentVariableTarget]::Machine)
# make variable to be available in the current session
${env:AZURE_EXTENSION_DIR} = $azureCliExtensionPath

# Warm-up Azure CLI

Write-Host "Warmup 'az'"

$env:PATH = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
az --help | Out-Null
if ($LASTEXITCODE -ne 0) {
   throw "Command 'az --help' failed"
}

Invoke-PesterTests -TestFile 'CLI.Tools' -TestName 'Azure CLI'
