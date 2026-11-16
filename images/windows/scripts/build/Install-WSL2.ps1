Write-Host "Install WSL package"

$architecture = if (Test-IsArm64) { "arm64" } else { "x64" }
$version = (Get-GithubReleasesByVersion -Repo "microsoft/WSL" -Version "latest").version
$downloadUrl =  Resolve-GithubReleaseAssetUrl `
    -Repo "microsoft/WSL" `
    -Version $version `
    -UrlMatchPattern "wsl.*.$architecture.msi"

Install-Binary -Type MSI `
    -Url $downloadUrl

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "WSL package"

# ARM64 needs the package for non-interactive discovery, not a Linux VM. See #14264.
if (-not (Test-IsArm64)) {
    Write-Host "Performing wsl --install --no-distribution"
    wsl.exe --install --no-distribution
    if ($LASTEXITCODE -ne 0) {
        throw "WSL installation failed with exit code $LASTEXITCODE"
    }

    Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "WSL2"
}
