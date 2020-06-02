################################################################################
##  File:  Validate-7zip.ps1
##  Desc:  Validate 7zip
################################################################################

if (Get-Command -Name '7z')
{
    Write-Host '7zip on path'
}
else
{
    Write-Host '7zip is not on path'
    exit 1
}

