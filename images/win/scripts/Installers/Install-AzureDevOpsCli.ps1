################################################################################
##  File:  Install-AzureDevOpsCli.ps1
##  Desc:  Install Azure DevOps CLI
################################################################################

# Store azure-devops-cli cache outside of the provisioning user's profile
$azureDevOpsCliConfigPath = Join-Path $Env:CommonProgramFiles 'AzureDevOpsCliConfigDirectory'
$null = New-Item -ItemType "Directory" -Path $azureDevOpsCliConfigPath
[Environment]::SetEnvironmentVariable("AZURE_DEVOPS_EXT_CONFIG_DIR", $azureDevOpsCliConfigPath, [System.EnvironmentVariableTarget]::Machine)


$azureDevOpsCliCachePath = Join-Path $azureDevOpsCliConfigPath "cache"
$null = New-Item -ItemType "Directory" -Path $azureDevOpsCliCachePath
[Environment]::SetEnvironmentVariable("AZURE_DEVOPS_CACHE_DIR", $azureDevOpsCliCachePath, [System.EnvironmentVariableTarget]::Machine)

az extension add -n azure-devops

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure DevOps CLI"
