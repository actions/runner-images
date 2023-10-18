################################################################################
##  File:  Install-AzureDevOpsCli.ps1
##  Desc:  Install Azure DevOps CLI
################################################################################

$azureDevOpsCliConfigPath = 'C:\azureDevOpsCli'
# Store azure-devops-cli cache outside of the provisioning user's profile
[Environment]::SetEnvironmentVariable('AZURE_DEVOPS_EXT_CONFIG_DIR', $azureDevOpsCliConfigPath, [System.EnvironmentVariableTarget]::Machine)
# make variable to be available in the current session
${env:AZURE_DEVOPS_EXT_CONFIG_DIR} = $azureDevOpsCliConfigPath

$azureDevOpsCliCachePath = Join-Path $azureDevOpsCliConfigPath 'cache'
$null = New-Item -ItemType 'Directory' -Path $azureDevOpsCliCachePath

[Environment]::SetEnvironmentVariable('AZURE_DEVOPS_CACHE_DIR', $azureDevOpsCliCachePath, [System.EnvironmentVariableTarget]::Machine)
# make variable to be available in the current session
${env:AZURE_DEVOPS_CACHE_DIR} = $azureDevOpsCliCachePath

az extension add -n azure-devops
if ($LASTEXITCODE -ne 0)
{
   throw "Command 'az extension add -n azure-devops' failed"
}

# Warm-up Azure DevOps CLI

Write-Host "Warmup 'az-devops'"
@('devops', 'pipelines', 'boards', 'repos', 'artifacts') | ForEach-Object {

    az $_ --help
    if ($LASTEXITCODE -ne 0)
    {
       throw "Command 'az $_ --help' failed"
    }

}

# calling az devops login to force it to install `keyring`. Login will actually fail, redirecting error to null
Write-Output 'fake token' | az devops login | Out-Null
# calling az devops logout to be sure no credentials remain.
az devops logout | out-null

Invoke-PesterTests -TestFile 'CLI.Tools' -TestName 'Azure DevOps CLI'
