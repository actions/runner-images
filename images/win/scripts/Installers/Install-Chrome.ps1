################################################################################
##  File:  Install-Chrome.ps1
##  Desc:  Install Google Chrome
################################################################################

# Get versions info
$ChromeVersionsUrl = "https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json"
$ChromeVersions = Invoke-RestMethod -Uri $ChromeVersionsUrl
$ChromeVersionInfo = $ChromeVersions.channels.Stable

# Install Google Chrome for Testing
$ChromeVersion = $ChromeVersionInfo.version
$ChromeUrl = ($ChromeVersionInfo.downloads.chrome | Where-Object platform -eq "win64").url

Write-Host "Installing Google Chrome for Testing version $ChromeVersion"
$ChromePath = "$($env:SystemDrive)\Program Files\Google\Chrome"
if (-not (Test-Path -Path $ChromePath)) {
    New-Item -Path $ChromePath -ItemType Directory -Force
}

$ChromeArchivePath = Start-DownloadWithRetry -Url $ChromeUrl
Extract-7Zip -Path $ChromeArchivePath -DestinationPath $ChromePath
Rename-Item "$ChromePath\chrome-win64" "$ChromePath\Application"

$chromeRegPath = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe"
New-Item $chromeRegPath
Set-ItemProperty $chromeRegPath "(default)" "$ChromePath\Application\chrome.exe"

# Install Chrome Driver
$ChromeDriverVersion = $ChromeVersionInfo.version
$ChromeDriverUrl = ($ChromeVersionInfo.downloads.chromedriver | Where-Object platform -eq "win64").url

Write-Host "Installing ChromeDriver version $ChromeDriverVersion"
$ChromeDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\ChromeDriver"
if (-not (Test-Path -Path $ChromeDriverPath)) {
    New-Item -Path $ChromeDriverPath -ItemType Directory -Force
}

$ChromeDriverVersion | Out-File -FilePath "$ChromeDriverPath\versioninfo.txt" -Force;
$ChromeDriverArchivePath = Start-DownloadWithRetry -Url $ChromeDriverUrl
Extract-7Zip -Path $ChromeDriverArchivePath -DestinationPath $ChromeDriverPath -ExtractMethod "e"

setx ChromeWebDriver "$ChromeDriverPath" /M

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\'
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path'
$PathValue += ";$ChromeDriverPath\"
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue

Invoke-PesterTests -TestFile "Browsers" -TestName "Chrome"