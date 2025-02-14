Write-Host "Install WSL2"

$version = (Get-GithubReleasesByVersion -Repo "microsoft/WSL" -Version "latest").version
$downloadUrl =  Resolve-GithubReleaseAssetUrl `
    -Repo "microsoft/WSL" `
    -Version $version `
    -UrlMatchPattern "wsl.*.x64.msi"

Install-Binary -Type MSI `
    -Url $downloadUrl `
    -ExpectedSHA256Sum "5A1EAD8E553ABBFB4DBB8291A329F3CA859DB2B8D887849F3F8CD19F7FABEF21"

Write-Host "Performing wsl --install --no-distribution"
wsl.exe --install --no-distribution

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "WSL2"
