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
    -ExpectedSubject $script:MicrosoftPublisherSubject

Invoke-PesterTests -TestFile "WinAppDriver" -TestName "WinAppDriver"
