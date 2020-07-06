################################################################################
##  File:  Validate-Newman.ps1
##  Desc:  Validate Newman Installation
################################################################################

if (Get-Command -Name 'newman')
{
    Write-Host "Newman $(newman --version) is on the path."
}
else
{
    Write-Host "Newman is not on the path."
    exit 1
}
