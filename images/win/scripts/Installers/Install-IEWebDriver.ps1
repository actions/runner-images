################################################################################
##  File:  Install-IEWebDriver.ps1
##  Desc:  Install IE Web Driver
################################################################################

$seleniumMajorVersion = (Get-ToolsetContent).selenium.version
$ieDriverUrl = Get-GitHubPackageDownloadUrl `
    -RepoOwner "SeleniumHQ" `
    -RepoName "selenium" `
    -BinaryName "IEDriverServer_x64" `
    -Version $seleniumMajorVersion `
    -UrlFilter "*{BinaryName}_{Version}.zip" `
    -LatestReleaseOnly $false

# Download IE selenium driver
try {
    Write-Host "Selenium IEDriverServer download and install..."
    $driverZipFile = Start-DownloadWithRetry -Url $ieDriverUrl -Name "SeleniumWebDrivers.zip"
} catch {
    Write-Error "[!] Failed to download $ieDriverUrl"
    exit 1
}

$ieDriverPath = "C:\SeleniumWebDrivers\IEDriver"
if (-not (Test-Path -Path $ieDriverPath)) {
    $null = New-Item -Path $ieDriverPath -ItemType Directory -Force
}

Extract-7Zip -Path $driverZipFile -DestinationPath $ieDriverPath
Remove-Item $driverZipFile

Write-Host "Get the IEDriver version..."
(Get-Item "$ieDriverPath\IEDriverServer.exe").VersionInfo.FileVersion | Out-File -FilePath "$ieDriverPath\versioninfo.txt"

Write-Host "Setting the IEWebDriver environment variables"
setx IEWebDriver $ieDriverPath /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Internet Explorer"
