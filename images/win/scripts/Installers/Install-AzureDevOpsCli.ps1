################################################################################
##  File:  Install-AzureDevOpsCli.ps1
##  Desc:  Install Azure DevOps CLI
################################################################################

# Store azure-devops-cli cache outside of the provisioning user's profile
$azureDevOpsCliConfigPath = Join-Path $Env:CommonProgramFiles 'AzureDevOpsCliConfigDirectory'
$null = New-Item -ItemType "Directory" -Path $azureDevOpsCliConfigPath
$env:AZURE_DEVOPS_EXT_CONFIG_DIR = Set-SystemVariable -SystemVariable "AZURE_DEVOPS_EXT_CONFIG_DIR" -value $azureDevOpsCliConfigPath

$azureDevOpsCliCachePath = Join-Path $azureDevOpsCliConfigPath "cache"
$null = New-Item -ItemType "Directory" -Path $azureDevOpsCliCachePath
$env:AZURE_DEVOPS_CACHE_DIR = Set-SystemVariable -SystemVariable "AZURE_DEVOPS_CACHE_DIR" -value $azureDevOpsCliCachePath

Invoke-ValidateCommand -Command "az extension add -n azure-devops"

# Warm-up Azure DevOps CLI

Write-Host "Warmup 'az-devops'"
@("devops", "pipelines", "boards", "repos", "artifacts") | ForEach-Object {
    Invoke-ValidateCommand -Command "az $_ --help"
}

# az devops login requires python package 'keyring~=17.1.1' unfortunately it won't install
# when az devops is running in a non-interactive session by calling `az devops login`
echo "dummy" | az devops login --debug
az devops logout --debug

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure DevOps CLI"
