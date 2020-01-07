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

$ChromeDriverPath = "$DestinationPath\SeleniumWebDrivers\ChromeDriver";
Write-Host "Chrome driver path: [$ChromeDriverPath]";
Remove-Item -Path "$ChromeDriverPath\*" -Force;

$ChromePath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(default)';
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

Write-Host "Setting the environment variables";

setx IEWebDriver "C:\SeleniumWebDrivers\IEDriver" /M;
setx GeckoWebDriver "C:\SeleniumWebDrivers\GeckoDriver" /M;
setx ChromeWebDriver "C:\SeleniumWebDrivers\ChromeDriver" /M;

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\';
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path';
$PathValue += ";C:\SeleniumWebDrivers\ChromeDriver\";
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue;

exit 0;

