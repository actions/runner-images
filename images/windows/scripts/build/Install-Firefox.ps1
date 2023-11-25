################################################################################
##  File:  Install-Firefox.ps1
##  Desc:  Install Mozilla Firefox browser and Gecko WebDriver
##  Supply chain security: Firefox browser - checksum validation
################################################################################

# Install and configure Firefox browser
Write-Host "Get the latest Firefox version..."
$VersionsManifest = Invoke-RestMethod "https://product-details.mozilla.org/1.0/firefox_versions.json"

Write-Host "Install Firefox browser..."
$installerUrl = "https://download.mozilla.org/?product=firefox-$($VersionsManifest.LATEST_FIREFOX_VERSION)&os=win64&lang=en-US"
$hashUrl = "https://archive.mozilla.org/pub/firefox/releases/$($VersionsManifest.LATEST_FIREFOX_VERSION)/SHA256SUMS"
$externalHash = (Invoke-RestMethod -Uri $hashURL).ToString().Split("`n").Where({ $_ -ilike "*win64/en-US/Firefox Setup*exe*" }).Split(' ')[0]

Install-Binary -Type EXE `
    -Url $installerUrl `
    -InstallArgs @("/silent", "/install") `
    -ExpectedSHA256Sum $externalHash

Write-Host "Disable autoupdate..."
$FirefoxDirectoryPath = Join-Path $env:ProgramFiles "Mozilla Firefox"
New-Item -path $FirefoxDirectoryPath -Name 'mozilla.cfg' -Value '//
pref("browser.shell.checkDefaultBrowser", false);
pref("app.update.enabled", false);' -ItemType file -force

$FirefoxPreferencesFolder = Join-Path $FirefoxDirectoryPath "defaults\pref"
New-Item -path $FirefoxPreferencesFolder -Name 'local-settings.js' -Value 'pref("general.config.obscure_value", 0);
pref("general.config.filename", "mozilla.cfg");' -ItemType file -force

# Download and install Gecko WebDriver
Write-Host "Install Gecko WebDriver..."
$GeckoDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\GeckoDriver"
if (-not (Test-Path -Path $GeckoDriverPath)) {
    New-Item -Path $GeckoDriverPath -ItemType Directory -Force
}

Write-Host "Get the Gecko WebDriver version..."
$GeckoDriverJson = Invoke-RestMethod "https://api.github.com/repos/mozilla/geckodriver/releases/latest"
$GeckoDriverWindowsAsset = $GeckoDriverJson.assets | Where-Object { $_.name -Match "win64" } | Select-Object -First 1
$GeckoDriverVersion = $GeckoDriverJson.tag_name
$GeckoDriverVersion.Substring(1) | Out-File -FilePath "$GeckoDriverPath\versioninfo.txt" -Force;

Write-Host "Download Gecko WebDriver WebDriver..."
$GeckoDriverArchName = $GeckoDriverWindowsAsset.name
$GeckoDriverDownloadUrl = $GeckoDriverWindowsAsset.browser_download_url

$GeckoDriverArchPath = Start-DownloadWithRetry -Url $GeckoDriverDownloadUrl -Name $GeckoDriverArchName

Write-Host "Expand Gecko WebDriver archive..."
Expand-7ZipArchive -Path $GeckoDriverArchPath -DestinationPath $GeckoDriverPath

# Validate Gecko WebDriver signature
$GeckoDriverSignatureThumbprint = "1326B39C3D5D2CA012F66FB439026F7B59CB1974"
Test-FileSignature -FilePath "$GeckoDriverPath/geckodriver.exe" -ExpectedThumbprint $GeckoDriverSignatureThumbprint

Write-Host "Setting the environment variables..."
Add-MachinePathItem -PathItem $GeckoDriverPath
[Environment]::SetEnvironmentVariable("GeckoWebDriver", $GeckoDriverPath, "Machine")

Invoke-PesterTests -TestFile "Browsers" -TestName "Firefox"
