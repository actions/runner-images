####################################################################################
##  File:  Install-WinAppDriver.ps1
##  Desc:  Install Windows Application Driver (WinAppDriver)
####################################################################################

$LatestReleaseUrl = 'https://api.github.com/repos/microsoft/WinAppDriver/releases/latest'
$InstallerUrl = (Invoke-RestMethod -Uri $LatestReleaseUrl).assets.browser_download_url
$InstallerName = "WindowsApplicationDriver.msi"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-Binary -Url $InstallerUrl -Name $InstallerName

Invoke-PesterTests -TestFile "WinAppDriver"
