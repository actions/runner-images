################################################################################
##  File:  Validate-GitVersion.ps1
##  Desc:  Validate GitVersion
################################################################################

if (Get-Command -Name 'gitversion')
{
    Write-Host 'gitversion on path'
}
else
{
    Write-Host 'gitversion is not on path'
    exit 1
}
