Write-Host "Install WSL2"

$version = (Get-GithubReleasesByVersion -Repo "microsoft/WSL" -Version "latest").version
$downloadUrl =  Resolve-GithubReleaseAssetUrl `
    -Repo "microsoft/WSL" `
    -Version $version `
    -UrlMatchPattern "wsl.*.x64.msi"

Install-Binary -Type MSI `
    -Url $downloadUrl `
    -ExpectedSHA256Sum "5A890C175A6A56ABE5D3D98AABD65E90023AAB18ACA4619390B6338A89CE1DDF"

Write-Host "Performing wsl --install --no-distribution"
wsl.exe --install --no-distribution

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "WSL2"
