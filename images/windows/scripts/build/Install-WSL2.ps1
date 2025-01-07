Write-Host "Install WSL2"

$version = (Get-GithubReleasesByVersion -Repo "microsoft/WSL" -Version "latest").version
$downloadUrl =  Resolve-GithubReleaseAssetUrl `
    -Repo "microsoft/WSL" `
    -Version $version `
    -UrlMatchPattern "wsl.*.x64.msi"

Install-Binary -Type MSI `
    -Url $downloadUrl `
    -ExpectedSHA256Sum "CD3F2A68A1A5836F6A1CC9965A7F5F54DB267CA221EAA87DF29345AB7957AEC4"

Write-Host "Performing wsl --install --no-distribution"
wsl.exe --install --no-distribution

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "WSL2"
