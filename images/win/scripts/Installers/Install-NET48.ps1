################################################################################
##  File:  Install-NET48.ps1
##  Desc:  Install .NET 4.8
################################################################################

Import-Module -Name ImageHelpers -Force

# .NET 4.8 Dev pack
$InstallerURI = "https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0307177e14752e359fde5423ab583e43/ndp48-devpack-enu.exe"
$InstallerName = "NDP48-DevPack-ENU.exe"
$ArgumentList = ('Setup', '/passive', '/norestart' )

Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList
