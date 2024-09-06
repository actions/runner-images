################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install and warm-up Azure CLI
################################################################################

Write-Host 'Install the latest Azure CLI release'

$azureCliConfigPath = 'C:\azureCli'
# Store azure-cli cache outside of the provisioning user's profile
[Environment]::SetEnvironmentVariable('AZURE_CONFIG_DIR', $azureCliConfigPath, "Machine")

$azureCliExtensionPath = Join-Path $env:CommonProgramFiles 'AzureCliExtensionDirectory'
New-Item -ItemType 'Directory' -Path $azureCliExtensionPath | Out-Null
[Environment]::SetEnvironmentVariable('AZURE_EXTENSION_DIR', $azureCliExtensionPath, "Machine")

Install-Binary -Type MSI `
    -Url 'https://aka.ms/installazurecliwindowsx64' `
    -ExpectedSignature 'F9A7CF9FBE13BAC767F4781061332DA6E8B4E0EE'

Update-Environment

# Warm-up Azure CLI
Write-Host "Warmup 'az'"
az --help | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Command 'az --help' failed"
}

Invoke-PesterTests -TestFile 'CLI.Tools' -TestName 'Azure CLI'
