################################################################################
##  File:  Install-Nuget.ps1
##  Desc:  Install NuGet.CommandLine
################################################################################

Choco-Install -PackageName NuGet.CommandLine

$env:Path = $env:Path + ";$env:ChocolateyInstall\bin"
if (Get-Command -Name 'nuget.exe')
{
    Write-Host 'nuget on path'
}
else
{
    Write-Host 'nuget is not on path'
    exit 1
}
