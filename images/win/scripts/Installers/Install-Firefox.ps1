################################################################################
##  File:  Install-Firefox.ps1
##  Desc:  Install Mozilla Firefox
################################################################################

Import-Module -Name ImageHelpers -Force
# https://github.com/mozilla/geckodriver/releases/latest - geckodriver for firefox
$temp_install_dir = 'C:\Windows\Installer'
New-Item -Path $temp_install_dir -ItemType Directory -Force

$firefoxJson = Invoke-WebRequest  "https://product-details.mozilla.org/1.0/firefox_versions.json" | ConvertFrom-Json

Write-Host "Firefox json"
Write-Host $firefoxJson

$latestVersion = $($firefoxJson.LATEST_FIREFOX_VERSION)
Write-Host "Firefox latest version $latestVersion"

Install-EXE -Url "https://seleniumwebdrivers.blob.core.windows.net/knownfirefoxversion/FirefoxSetup.exe" -Name "Firefox Setup $latestVersion" -ArgumentList "-ms"

$path = '{0}\Program Files\Mozilla Firefox\' -f $env:SystemDrive;
New-Item -path $path -Name 'mozilla.cfg' -Value '//
pref("browser.shell.checkDefaultBrowser", false);
pref("app.update.enabled", false);' -ItemType file -force

$path = '{0}\Program Files\Mozilla Firefox\defaults\pref\' -f $env:SystemDrive;
New-Item -path $path -Name 'local-settings.js' -Value 'pref("general.config.obscure_value", 0);
pref("general.config.filename", "mozilla.cfg");' -ItemType file -force

# section for installing selenium web driver
Write-Host "Install selenium"

gci env:* | sort-object name

$DestinationPath = "$($env:SystemDrive)\";

$geckodriverJson = Invoke-RestMethod "https://api.github.com/repos/mozilla/geckodriver/releases/latest"
  $geckodriverJson.assets | ForEach-Object -Process {
      if ($_.name -Match "win64")
      {
          $name = $_.name
          $adress = $_.browser_download_url
      }
      }


Write-Host "Name of firefox zip file $name"
Write-Host "Install url $adress"

$DriversZipFile = $name
Write-Host "Destination path: [$DestinationPath]";
Write-Host "Selenium drivers download and install...";

$FireFoxDriverPath = "${DestinationPath}SeleniumWebDrivers\GeckoDriver";

# Install Fire Fox Web Driver
Write-Host "FireFox driver download...."
if (-not (Test-Path -Path $FireFoxDriverPath)) {
    New-Item -Path $FireFoxDriverPath -ItemType "directory"
}

$DestFile = "$FireFoxDriverPath\$name"
$EdgeDriverDownloadUrl = $adress
try{
    Invoke-WebRequest -Uri $EdgeDriverDownloadUrl -OutFile $DestFile
} catch {
    Write-Error "[!] Failed to download $name";
    exit 1;
}

Write-Host "FireFox driver install...."
Expand-Archive -Path $DestFile -DestinationPath $FireFoxDriverPath -Force
Remove-Item -Path $DestFile -Force


Write-Host "Setting the environment variables"
setx GeckoWebDriver "$FireFoxDriverPath" /M;

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\';
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path';
$PathValue += ";$FireFoxDriverPath";
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue
exit 0;