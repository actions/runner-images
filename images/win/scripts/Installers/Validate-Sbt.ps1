################################################################################
##  File:  Validate-Sbt.ps1
##  Desc:  Validate sbt for Windows
################################################################################

if (Get-Command -Name 'sbt')
{
    Write-Host 'sbt is on the path'
}
else
{
    Write-Host 'sbt is not on path.'
    exit 1
}

