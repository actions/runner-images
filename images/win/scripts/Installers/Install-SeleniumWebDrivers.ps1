################################################################################
##  File:  Install-SeleniumWebDrivers.ps1
##  Desc:  Install Selenium Web Drivers
################################################################################
$DestinationPath = "$($env:SystemDrive)\";
$DriversZipFile = "SeleniumWebDrivers.zip"
Write-Host "Destination path: [$DestinationPath]";
Write-Host "Selenium drivers download and install...";
try {
    Invoke-WebRequest -UseBasicParsing -Uri "https://seleniumwebdrivers.blob.core.windows.net/seleniumwebdrivers/${DriversZipFile}" -OutFile $DriversZipFile;
}
catch {
    Write-Error "[!] Failed to download $DriverZipFile";
    exit 1;
}

Expand-Archive -Path $DriversZipFile -DestinationPath $DestinationPath -Force;
Remove-Item $DriversZipFile;

$ChromeDriverPath = "${DestinationPath}SeleniumWebDrivers\ChromeDriver";
Write-Host "Chrome driver path: [$ChromeDriverPath]";
Remove-Item -Path "$ChromeDriverPath\*" -Force;

# Reinstall Chrome Web Driver
$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
$ChromePath = (Get-ItemProperty "$RegistryPath\chrome.exe").'(default)';
[version]$ChromeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($ChromePath).ProductVersion;
Write-Host "Chrome version: [$ChromeVersion]";

$ChromeDriverVersionUri = "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$($ChromeVersion.Major).$($ChromeVersion.Minor).$($ChromeVersion.Build)";
Write-Host "Chrome driver version Uri [$ChromeDriverVersionUri]";
Write-Host "Getting the Chrome driver version...";
$ChromeDriverVersion = Invoke-WebRequest -Uri $ChromeDriverVersionUri;
Write-Host "Current Chrome driver version: [$ChromeDriverVersion]";

$ChromeDriverZipDownloadUri = "https://chromedriver.storage.googleapis.com/$($ChromeDriverVersion.ToString())/chromedriver_win32.zip";
Write-Host "Chrome driver zip file download Uri: [$ChromeDriverZipDownloadUri]";

$DestFile= "$ChromeDriverPath\chromedriver_win32.zip";
$ChromeDriverVersion.Content | Out-File -FilePath "$ChromeDriverPath\versioninfo.txt" -Force;

Write-Host "Chrome driver download....";
Invoke-WebRequest -Uri $ChromeDriverZipDownloadUri -OutFile $DestFile;

Write-Host "Chrome driver install....";
Expand-Archive -Path "$ChromeDriverPath\chromedriver_win32.zip" -DestinationPath $ChromeDriverPath -Force;
Remove-Item -Path "$ChromeDriverPath\chromedriver_win32.zip" -Force;

# Install Microsoft Edge Web Driver
Write-Host "Microsoft Edge driver download...."
$EdgeDriverPath = "${DestinationPath}SeleniumWebDrivers\EdgeDriver"
if (-not (Test-Path -Path $EdgeDriverPath)) {
    New-Item -Path $EdgeDriverPath -ItemType "directory"
}

$EdgePath = (Get-ItemProperty "$RegistryPath\msedge.exe").'(default)'
[version]$EdgeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($EdgePath).ProductVersion
$EdgeDriverVersionUrl = "https://msedgedriver.azureedge.net/LATEST_RELEASE_$($EdgeVersion.Major)"
$EdgeDriverVersionFile = "$EdgeDriverPath\versioninfo.txt"
Invoke-WebRequest -Uri $EdgeDriverVersionUrl -OutFile $EdgeDriverVersionFile

$EdgeDriverLatestVersion = Get-Content -Path $EdgeDriverVersionFile
$EdgeDriverDownloadUrl="https://msedgedriver.azureedge.net/${EdgeDriverLatestVersion}/edgedriver_win64.zip"
$DestFile = "$EdgeDriverPath\edgedriver_win64.zip"
Invoke-WebRequest -Uri $EdgeDriverDownloadUrl -OutFile $DestFile

Write-Host "Microsoft Edge driver install...."
Expand-Archive -Path $DestFile -DestinationPath $EdgeDriverPath -Force
Remove-Item -Path $DestFile -Force

Write-Host "Setting the environment variables"

setx IEWebDriver "C:\SeleniumWebDrivers\IEDriver" /M;
setx GeckoWebDriver "C:\SeleniumWebDrivers\GeckoDriver" /M;
setx ChromeWebDriver "$ChromeDriverPath" /M;
setx EdgeWebDriver "$EdgeDriverPath" /M;

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\';
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path';
$PathValue += ";$ChromeDriverPath\";
$PathValue += ";$EdgeDriverPath\";
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue;

exit 0;
