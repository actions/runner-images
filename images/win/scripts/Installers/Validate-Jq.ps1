################################################################################
##  File:  Validate-Jq.ps1
##  Desc:  Validate jq
################################################################################

if (Get-Command -Name 'jq')
{
    Write-Host 'jq on path'
}
else
{
    Write-Host 'jq is not on path'
    exit 1
}

