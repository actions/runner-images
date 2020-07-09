################################################################################
##  File:  Validate-WSL.ps1
##  Desc:  Validate WSL CLI existst
################################################################################

if (Get-Command -Name 'wsl')
{
    Write-Host 'wsl is on path'
}
else
{
    Write-Host 'wsl not on path'
    exit 1
}
