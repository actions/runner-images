################################################################################
##  File:  Validate-AzureCli.ps1
##  Desc:  Validate Azure CLI
################################################################################

if (Get-Command -Name 'az')
{
    Write-Host "Azure Cli $(az --version) on path"
}
else
{
    Write-Error "Azure Cli not on path"
    exit 1
}

