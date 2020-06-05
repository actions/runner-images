################################################################################
##  File:  Validate-CloudFoundryCli.ps1
##  Desc:  Validate Cloud Foundry CLI
################################################################################

if (Get-Command -Name 'cf')
{
    Write-Host 'cf on path'
}
else
{
    Write-Host 'cf is not on path'
    exit 1
}

