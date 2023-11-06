####################################################################################
##  File:  Install-WinAppDriver.ps1
##  Desc:  Install Windows Application Driver (WinAppDriver)
####################################################################################

$LatestReleaseUrl = 'https://api.github.com/repos/microsoft/WinAppDriver/releases/latest'
$InstallerUrl = (Invoke-RestMethod -Uri $LatestReleaseUrl).assets.browser_download_url
$InstallerName = "WindowsApplicationDriver.msi"
$InstallerSignatureThumbprint = "2485A7AFA98E178CB8F30C9838346B514AEA4769"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-Binary -Url $InstallerUrl -Name $InstallerName -ExpectedSignature $InstallerSignatureThumbprint

Invoke-PesterTests -TestFile "WinAppDriver" -TestName "WinAppDriver"
