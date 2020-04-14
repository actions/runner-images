################################################################################
##  File:  Install-NET472.ps1
##  Desc:  Install .NET 4.7.2
################################################################################

Import-Module -Name ImageHelpers -Force

# .NET 4.7.2 Dev pack
$InstallerName = "NDP472-DevPack-ENU.exe"
$InstallerUrl = "https://download.microsoft.com/download/3/B/F/3BFB9C35-405D-45DF-BDAF-0EB57D047888/${InstallerName}"
$ArgumentList = ('Setup', '/passive', '/norestart' )

Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList
