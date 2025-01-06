####################################################################################
##  File:  Install-WinAppDriver.ps1
##  Desc:  Install Windows Application Driver (WinAppDriver)
####################################################################################

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "microsoft/WinAppDriver" `
    -Version "latest" `
    -UrlMatchPattern "WindowsApplicationDriver_*.msi"

Install-Binary `
    -Url $downloadUrl `
    -ExpectedSignature '2485A7AFA98E178CB8F30C9838346B514AEA4769'

Invoke-PesterTests -TestFile "WinAppDriver" -TestName "WinAppDriver"
