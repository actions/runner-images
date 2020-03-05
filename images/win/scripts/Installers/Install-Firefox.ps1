################################################################################
##  File:  Install-Firefox.ps1
##  Desc:  Install Mozilla Firefox
################################################################################

Import-Module -Name ImageHelpers -Force

$temp_install_dir = 'C:\Windows\Installer'
New-Item -Path $temp_install_dir -ItemType Directory -Force

$versionsJson = Invoke-RestMethod  "https://product-details.mozilla.org/1.0/firefox_versions.json"
$latestVersion = $versionsJson.LATEST_FIREFOX_VERSION
Write-Host "Firefox latest version: $latestVersion"

# url for latest version of firefox
$urlLatestVersion = "https://download.mozilla.org/?product=firefox-${latestVersion}&os=win64&lang=en-US"
Install-EXE -Url $urlLatestVersion -Name "Firefox Setup $latestVersion.exe" -ArgumentList ("/silent", "/install")

# Disable autoupdate
$firefoxDirectoryPath = Join-Path $env:ProgramFiles "Mozilla Firefox"
New-Item -path $firefoxDirectoryPath -Name 'mozilla.cfg' -Value '//
pref("browser.shell.checkDefaultBrowser", false);
pref("app.update.enabled", false);' -ItemType file -force

$firefoxPreferencesFolder = Join-Path $firefoxDirectoryPath "defaults\pref"
New-Item -path $firefoxPreferencesFolder -Name 'local-settings.js' -Value 'pref("general.config.obscure_value", 0);
pref("general.config.filename", "mozilla.cfg");' -ItemType file -force
