################################################################################
##  File:  Install-Dokany.ps1
##  Desc:  Install the Dokany user-mode filesystem kernel driver
################################################################################

$version = "2.3.1.1000"
$downloadUrl = "https://github.com/dokan-dev/dokany/releases/download/v${version}/Dokan_x64.msi"

Install-Binary `
    -Url $downloadUrl `
    -ExpectedSHA256Sum "69ff8cb37bfec3a75921c85ffd1c6370b50a9ec4ecef2cf3a009d488dcbf5465"

Invoke-PesterTests -TestFile "Dokany"
