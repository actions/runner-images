################################################################################
##  File:  Validate-NSIS.ps1
##  Desc:  Validate NSIS installation.
################################################################################

$SoftwareName = 'Nullsoft Install System (NSIS)'

if (Get-Command -Name 'makensis')
{
    Write-Host "$SoftwareName is installed"
}
else
{
    Write-Host "$SoftwareName is not installed"
    exit 1
}

