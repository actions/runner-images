################################################################################
##  File:  Install-SeleniumWebDrivers.ps1
##  Desc:  Install Selenium Web Drivers
################################################################################

# https://www.selenium.dev/downloads/
# 32 bit Windows IE (recommended)
try {
    $LatestReleaseUrl = "https://selenium-release.storage.googleapis.com/"
    $LatestReleaseInfo = Invoke-RestMethod -Uri $latestReleaseUrl
    $LatestIEVersion = $latestReleaseInfo.ListBucketResult.Contents | Where-Object Key -match "IEDriverServer_Win32" | Sort-Object LastModified | Select-Object -ExpandProperty Key -Last 1
    $IEDriverUrl = -join ($LatestReleaseUrl, $LatestIEVersion)
} catch {
    Write-Error "[!] Failed to get IEDriver version [$LatestReleaseUrl]: $_"
    exit 1
}

# Download IE selenium driver
try {
    Write-Host "Selenium IEDriverServer download and install..."
    $DriversZipFile = Start-DownloadWithRetry -Url $IEDriverUrl -Name "SeleniumWebDrivers.zip"
}
catch {
    Write-Error "[!] Failed to download $IEDriverUrl"
    exit 1
}

$SeleniumWebDriverPath = Join-Path $env:SystemDrive "SeleniumWebDrivers"
$IEDriverPath = Join-Path $SeleniumWebDriverPath "IEDriver"
if (-not (Test-Path -Path $IEDriverPath)) {
    $null = New-Item -Path $IEDriverPath -ItemType Directory -Force
}

Extract-7Zip -Path $DriversZipFile -DestinationPath $IEDriverPath
Remove-Item $DriversZipFile

Write-Host "Setting the IEWebDriver environment variables"
setx IEWebDriver "C:\SeleniumWebDrivers\IEDriver" /M
