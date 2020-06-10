################################################################################
##  File:  Validate-DotnetSDK.ps1
##  Desc:  Validate dotnet
################################################################################

if (Get-Command -Name 'dotnet')
{
    Write-Host "dotnet $(dotnet --version) on path"
}
else
{
    Write-Host "dotnet is not on path"
    exit 1
}


