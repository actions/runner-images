################################################################################
##  File:  Install-SeleniumWebDrivers.ps1
##  Desc:  Install Selenium Web Drivers
################################################################################

# https://www.selenium.dev/downloads/
# 32 bit Windows IE (recommended)
try {
    $latestReleaseUrl = "https://selenium-release.storage.googleapis.com/"
    $latestReleaseInfo = Invoke-RestMethod -Uri $latestReleaseUrl
    $latestIEVersion = $latestReleaseInfo.ListBucketResult.Contents | Where-Object Key -match "IEDriverServer_Win32" | Sort-Object LastModified | Select-Object -ExpandProperty Key -Last 1
    $ieDriverUrl = -join ($latestReleaseUrl, $latestIEVersion)
} catch {
    Write-Error "[!] Failed to get IEDriver version [$latestReleaseUrl]: $_"
    exit 1
}

# Download IE selenium driver
try {
    Write-Host "Selenium IEDriverServer download and install..."
    $driverZipFile = Start-DownloadWithRetry -Url $ieDriverUrl -Name "SeleniumWebDrivers.zip"
}
catch {
    Write-Error "[!] Failed to download $ieDriverUrl"
    exit 1
}

$ieDriverPath = "C:\SeleniumWebDrivers\IEDriver"
if (-not (Test-Path -Path $ieDriverPath)) {
    $null = New-Item -Path $ieDriverPath -ItemType Directory -Force
}

Extract-7Zip -Path $driverZipFile -DestinationPath $ieDriverPath
Remove-Item $driverZipFile

Write-Host "Setting the IEWebDriver environment variables"
setx IEWebDriver $ieDriverPath /M
