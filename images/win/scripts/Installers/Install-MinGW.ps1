################################################################################
##  File:  Install-MinGW.ps1
##  Desc:  Install GNU tools for Windows to C:\tools\mingw64
################################################################################

Import-Module -Name ImageHelpers -Force

Choco-Install -PackageName mingw

# Make a copy of mingw32-make.exe to make.exe, which is a more discoverable name
# and so the same command line can be used on Windows as on macOS and Linux
$path = where.exe mingw32-make.exe | Get-Item
Copy-Item -Path $path -Destination (Join-Path $path.Directory 'make.exe')
