################################################################################
##  File:  Install-NET472.ps1
##  Desc:  Install .NET 4.7.2
################################################################################

Import-Module -Name ImageHelpers -Force

# .NET 4.7.2 Dev pack
$InstallerURI = "https://download.microsoft.com/download/3/B/F/3BFB9C35-405D-45DF-BDAF-0EB57D047888/NDP472-DevPack-ENU.exe"
$InstallerName = "NDP472-DevPack-ENU.exe"
$ArgumentList = ('Setup', '/passive', '/norestart' )

Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList
