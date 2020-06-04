################################################################################
##  File:  Validate-Vcpkg.ps1
##  Desc:  Validate vcpkg Cli
################################################################################

if (Get-Command -Name 'Vcpkg')
{
    Write-Host 'Vcpkg is succesfully installed:'
    vcpkg version | Write-Host
}
else
{
    Write-Host 'Vcpkg is not on PATH'
    exit 1
}

if ($env:VCPKG_INSTALLATION_ROOT) 
{
    Write-Host 'The VCPKG_INSTALLATION_ROOT environment variable is set'
    Write-Host $env:VCPKG_INSTALLATION_ROOT
}
else
{
    Write-Host 'The VCPKG_INSTALLATION_ROOT environment variable is not set'
    exit 1
}

