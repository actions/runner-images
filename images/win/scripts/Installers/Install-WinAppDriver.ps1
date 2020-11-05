####################################################################################
##  File:  Install-WinAppDriver.ps1
##  Desc:  Install Windows Application Driver (WinAppDriver)
####################################################################################

$InstallerName = "WindowsApplicationDriver_1.2.1.msi"
$InstallerUrl = "https://github.com/Microsoft/WinAppDriver/releases/download/v1.2.1/${InstallerName}"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-Binary -Url $InstallerUrl -Name $InstallerName

Invoke-PesterTests -TestFile "WinAppDriver"
