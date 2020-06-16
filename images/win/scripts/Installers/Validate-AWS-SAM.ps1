################################################################################
##  File:  Validate-AWS-SAM.ps1
##  Desc:  Validate aws sam cli
################################################################################

if (Get-Command -Name 'sam')
{
    Write-Host 'AWS SAM CLI on path'
}
else
{
    Write-Host 'AWS SAM CLI is not on path'
    exit 1
}
