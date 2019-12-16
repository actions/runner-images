####################################################################################
##  File:  Install-WinAppDriver.ps1
##  Desc:  Install Windows Application Driver (WinAppDriver)
####################################################################################

Import-Module -Name ImageHelpers -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-MSI -MsiUrl "https://github.com/Microsoft/WinAppDriver/releases/download/v1.1/WindowsApplicationDriver.msi" -MsiName "WindowsApplicationDriver.msi"
