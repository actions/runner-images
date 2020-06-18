################################################################################
##  File:  Validate-InnoSetup.ps1
##  Desc:  Validate Inno Setup
################################################################################

if (Get-Command -Name 'iscc')
{
    Write-Host 'iscc is on PATH'
}
else
{
    Write-Host 'iscc is not on PATH'
    exit 1
}

