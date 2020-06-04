################################################################################
##  File:  Validate-PowershellCore.ps1
##  Desc:  Validate Powershell Core
################################################################################

if (Get-Command -Name 'pwsh')
{
    Write-Host 'pwsh is on PATH'
}
else
{
    Write-Host 'pwsh is not on PATH'
    exit 1
}

