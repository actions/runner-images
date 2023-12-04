################################################################################
##  File:  Install-IEWebDriver.ps1
##  Desc:  Install IE Web Driver
################################################################################

$seleniumMajorVersion = (Get-ToolsetContent).selenium.version
$ieDriverUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "SeleniumHQ/selenium" `
    -Version "$seleniumMajorVersion.*" `
    -Asset "IEDriverServer_x64_*.zip"

# Download IE selenium driver
Write-Host "Selenium IEDriverServer download and install..."
$driverZipFile = Invoke-DownloadWithRetry $ieDriverUrl

$ieDriverPath = "C:\SeleniumWebDrivers\IEDriver"
if (-not (Test-Path -Path $ieDriverPath)) {
    New-Item -Path $ieDriverPath -ItemType Directory -Force | Out-Null
}

Expand-7ZipArchive -Path $driverZipFile -DestinationPath $ieDriverPath
Remove-Item $driverZipFile

Write-Host "Get the IEDriver version..."
(Get-Item "$ieDriverPath\IEDriverServer.exe").VersionInfo.FileVersion | Out-File -FilePath "$ieDriverPath\versioninfo.txt"

Write-Host "Setting the IEWebDriver environment variables"
[Environment]::SetEnvironmentVariable("IEWebDriver", $ieDriverPath, "Machine")

Invoke-PesterTests -TestFile "Browsers" -TestName "Internet Explorer"
