################################################################################
##  File:  Validate-Stack.ps1
##  Desc:  Validate Stack for Windows
################################################################################

if (Get-Command -Name 'stack')
{
    Write-Host 'stack is on the path'
}
else
{
    Write-Host 'stack is not on path.'
    exit 1
}

