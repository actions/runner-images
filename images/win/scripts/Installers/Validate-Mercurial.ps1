################################################################################
##  File:  Validate-Mercurial.ps1
##  Desc:  Validate Mercurial
################################################################################

if (Get-Command -Name 'hg')
{
    Write-Host 'Mercurial on path'
}
else
{
    Write-Host 'Mercurial is not on path'
    exit 1
}
