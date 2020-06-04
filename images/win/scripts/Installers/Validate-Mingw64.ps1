################################################################################
##  File:  Validate-Mingw64.ps1
##  Desc:  Validate Mingw64
################################################################################

if (Get-Command -Name 'gcc')
{
    Write-Host "gcc is successfully installed:"
    gcc --version | Write-Host
}
else
{
    Write-Host "gcc is not on PATH"
    exit 1
}

if (Get-Command -Name 'g++')
{
    Write-Host "g++ is successfully installed:"
    g++ --version | Write-Host
}
else
{
    Write-Host "g++ is not on PATH"
    exit 1
}

if (Get-Command -Name 'make')
{
    Write-Host "make is successfully installed:"
    make --version | Write-Host
}
else
{
    Write-Host "make is not on PATH"
    exit 1
}
