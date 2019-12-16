################################################################################
##  File:  Install-Firefox.ps1
##  Desc:  Install Mozilla Firefox
################################################################################

Import-Module -Name ImageHelpers -Force

$temp_install_dir = 'C:\Windows\Installer'
New-Item -Path $temp_install_dir -ItemType Directory -Force

Install-EXE -Url "https://seleniumwebdrivers.blob.core.windows.net/knownfirefoxversion/FirefoxSetup.exe" -Name "FirefoxSetup.exe" -ArgumentList "-ms"

$path = '{0}\Program Files\Mozilla Firefox\' -f $env:SystemDrive;
New-Item -path $path -Name 'mozilla.cfg' -Value '//
pref("browser.shell.checkDefaultBrowser", false);
pref("app.update.enabled", false);' -ItemType file -force

$path = '{0}\Program Files\Mozilla Firefox\defaults\pref\' -f $env:SystemDrive;
New-Item -path $path -Name 'local-settings.js' -Value 'pref("general.config.obscure_value", 0);
pref("general.config.filename", "mozilla.cfg");' -ItemType file -force
