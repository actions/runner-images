################################################################################
##  File:  Install-NET48.ps1
##  Desc:  Install .NET 4.8
################################################################################

Import-Module -Name ImageHelpers -Force

# .NET 4.8 Dev pack
$InstallerURI = "https://download.visualstudio.microsoft.com/download/pr/7afca223-55d2-470a-8edc-6a1739ae3252/c8c829444416e811be84c5765ede6148/NDP48-DevPack-ENU.exe"
$InstallerName = "NDP48-DevPack-ENU.exe"
$ArgumentList = ('Setup', '/passive', '/norestart' )

Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList
