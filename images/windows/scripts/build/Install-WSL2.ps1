Write-Host "Install WSL2"

$version = (Get-GithubReleasesByVersion -Repo "microsoft/WSL" -Version "latest").version
$downloadUrl =  Resolve-GithubReleaseAssetUrl `
    -Repo "microsoft/WSL" `
    -Version $version `
    -UrlMatchPattern "wsl.*.x64.msi"

Install-Binary -Type MSI `
    -Url $downloadUrl `
    -ExpectedSHA256Sum "FFC88065B767806451B2EADB92C3AD3D4031F2D34B5C93E84250B17CC00DBBF7"

Write-Host "Performing wsl --install --no-distribution"
wsl.exe --install --no-distribution

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "WSL2"
