Write-Host "Install WSL2"

$version = (Get-GithubReleasesByVersion -Repo "microsoft/WSL" -Version "latest").version
$downloadUrl =  Resolve-GithubReleaseAssetUrl `
    -Repo "microsoft/WSL" `
    -Version $version `
    -UrlMatchPattern "wsl.*.x64.msi"

Install-Binary -Type MSI `
    -Url $downloadUrl `
    -ExpectedSHA256Sum "AF1C1CBDB2F8E323A74224F200B3A4E25C0CF6DD5DAE7D0D14CB64109E429ED8"

Write-Host "Performing wsl --install --no-distribution"
wsl.exe --install --no-distribution

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "WSL2"
