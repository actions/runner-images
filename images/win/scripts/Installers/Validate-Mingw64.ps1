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

# Adding description of the software to Markdown

# `gcc --version` gives output like:
# gcc.exe (x86_64-posix-seh-rev0, Built by Mingw-w64 project) 5.3.0
# Copyright (C) 2015 Free Software Foundation, Inc.
# This is free software; see the source for copying conditions.  There is NO
# warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$SoftwareName = "Mingw-w64"
$(gcc --version).Split([System.Environment]::NewLine)[0] -match "\d\.\d\.\d$"
$mingw64Version = $matches[0]

$Description = @"
_Version:_ $mingw64Version<br/>
_Environment:_
* PATH: contains location of the Mingw-w64 'bin' directory
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
