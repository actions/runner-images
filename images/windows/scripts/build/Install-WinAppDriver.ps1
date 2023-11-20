####################################################################################
##  File:  Install-WinAppDriver.ps1
##  Desc:  Install Windows Application Driver (WinAppDriver)
####################################################################################

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$latestReleaseUrl = 'https://api.github.com/repos/microsoft/WinAppDriver/releases/latest'
$installerUrl = (Invoke-RestMethod -Uri $latestReleaseUrl).assets.browser_download_url

Install-Binary `
  -Url $installerUrl `
  -ExpectedSignature '2485A7AFA98E178CB8F30C9838346B514AEA4769'

Invoke-PesterTests -TestFile "WinAppDriver" -TestName "WinAppDriver"
