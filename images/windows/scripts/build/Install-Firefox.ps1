################################################################################
##  File:  Install-Firefox.ps1
##  Desc:  Install Mozilla Firefox browser and Gecko WebDriver
##  Supply chain security: Firefox browser - checksum validation
################################################################################

# Install and configure Firefox browser
Write-Host "Get the latest Firefox version..."
$versionsManifest = Invoke-RestMethod "https://product-details.mozilla.org/1.0/firefox_versions.json"

Write-Host "Install Firefox browser..."
$installerUrl = "https://download.mozilla.org/?product=firefox-$($versionsManifest.LATEST_FIREFOX_VERSION)&os=win64&lang=en-US"
$hashUrl = "https://archive.mozilla.org/pub/firefox/releases/$($versionsManifest.LATEST_FIREFOX_VERSION)/SHA256SUMS"

$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url $hashUrl `
    -FileName "win64/en-US/Firefox Setup*exe"

Install-Binary -Type EXE `
    -Url $installerUrl `
    -InstallArgs @("/silent", "/install") `
    -ExpectedSHA256Sum $externalHash

Write-Host "Disable autoupdate..."
$firefoxDirectoryPath = Join-Path $env:ProgramFiles "Mozilla Firefox"
New-Item -path $firefoxDirectoryPath -Name 'mozilla.cfg' -Value '//
pref("browser.shell.checkDefaultBrowser", false);
pref("app.update.enabled", false);' -ItemType file -force

$firefoxPreferencesFolder = Join-Path $firefoxDirectoryPath "defaults\pref"
New-Item -path $firefoxPreferencesFolder -Name 'local-settings.js' -Value 'pref("general.config.obscure_value", 0);
pref("general.config.filename", "mozilla.cfg");' -ItemType file -force

# Download and install Gecko WebDriver
Write-Host "Install Gecko WebDriver..."
$geckoDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\GeckoDriver"
if (-not (Test-Path -Path $geckoDriverPath)) {
    New-Item -Path $geckoDriverPath -ItemType Directory -Force
}

Write-Host "Get the Gecko WebDriver version..."
$geckoDriverVersion = (Get-GithubReleasesByVersion -Repo "mozilla/geckodriver" -Version "latest").version
$geckoDriverVersion | Out-File -FilePath "$geckoDriverPath\versioninfo.txt" -Force

Write-Host "Download Gecko WebDriver WebDriver..."
$geckoDriverDownloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "mozilla/geckodriver" `
    -Version $geckoDriverVersion `
    -UrlMatchPattern "geckodriver-*-win64.zip"
$geckoDriverArchPath = Invoke-DownloadWithRetry $geckoDriverDownloadUrl

Write-Host "Expand Gecko WebDriver archive..."
Expand-7ZipArchive -Path $geckoDriverArchPath -DestinationPath $geckoDriverPath

# Validate Gecko WebDriver signature
$geckoDriverSignatureThumbprint = "40890F2FE1ACAE18072FA7F3C0AE456AACC8570D"
Test-FileSignature -Path "$geckoDriverPath/geckodriver.exe" -ExpectedThumbprint $geckoDriverSignatureThumbprint

Write-Host "Setting the environment variables..."
Add-MachinePathItem -PathItem $geckoDriverPath
[Environment]::SetEnvironmentVariable("GeckoWebDriver", $geckoDriverPath, "Machine")

Invoke-PesterTests -TestFile "Browsers" -TestName "Firefox"
