################################################################################
##  File:  Install-SeleniumWebDrivers.ps1
##  Desc:  Install Selenium Web Drivers
################################################################################


$json = Invoke-RestMethod -Uri "https://api.github.com/repos/SeleniumHQ/selenium/releases?per_page=100"
$ieDriverUrl = $json.Where{-not $_.prerelease}.assets.browser_download_url | Where-Object { $_ -like "*IEDriverServer_x64_*.zip" } | Select-Object -First 1

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

Write-Host "Get the IEDriver version..."
(Get-Item "$ieDriverPath\IEDriverServer.exe").VersionInfo.FileVersion | Out-File -FilePath "$ieDriverPath\versioninfo.txt"

Write-Host "Setting the IEWebDriver environment variables"
setx IEWebDriver $ieDriverPath /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Internet Explorer"