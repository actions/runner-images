####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DACFx) for Windows
####################################################################################

Import-Module -Name ImageHelpers -Force

# DacFx version 18.4.1
$exitcode = Install-MSI -MsiUrl "https://download.microsoft.com/download/0/9/6/096a3fac-40ec-4dee-ae9d-6fc0fb3cfa81/x64/DacFramework.msi" -MsiName "DacFramework.msi"

exit $exitcode
