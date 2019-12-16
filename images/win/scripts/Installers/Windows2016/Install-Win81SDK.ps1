################################################################################
##  File:  Install-Win81SDK.ps1
##  Desc:  Install Windows 8.1 SDK
################################################################################

Import-Module -Name ImageHelpers -Force

$InstallerURI = 'http://download.microsoft.com/download/B/0/C/B0C80BA3-8AD6-4958-810B-6882485230B5/standalonesdk/sdksetup.exe'
$InstallerName = 'sdksetup.exe'
$ArgumentList = ('/quiet', '/norestart')

$exitCode = Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList

exit $exitCode
