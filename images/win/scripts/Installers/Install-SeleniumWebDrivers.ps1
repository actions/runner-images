################################################################################
##  File:  Install-SeleniumWebDrivers.ps1
##  Desc:  Install Selenium Web Drivers
################################################################################
$DestinationPath = "C:\";
Write-Debug "Destination path: [$DestinationPath]";
Write-Debug "Selenium drivers download and install...";
Invoke-WebRequest -UseBasicParsing -Uri "https://seleniumwebdrivers.blob.core.windows.net/seleniumwebdrivers/SeleniumWebDrivers.zip" -OutFile SeleniumWebDrivers.zip;
Expand-Archive -Path SeleniumWebDrivers.zip -DestinationPath $DestinationPath -Force;
Remove-Item SeleniumWebDrivers.zip;

$ChromeDriverPath = "$DestinationPath\SeleniumWebDrivers\ChromeDriver";
Write-Debug "Chrome driver path: [$ChromeDriverPath]";
Remove-Item -Path "$ChromeDriverPath\*" -Force;

$ChromePath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(default)';
[version]$ChromeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($ChromePath).ProductVersion;
Write-Debug "Chrome version: [$ChromeVersion]";

$ChromeDriverVersionUri = "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$($ChromeVersion.Major).$($ChromeVersion.Minor).$($ChromeVersion.Build)";
Write-Debug "Chrome driver version Uri [$ChromeDriverVersionUri]";
Write-Debug "Getting the Chrome driver version...";
$ChromeDriverVersion = Invoke-WebRequest -Uri $ChromeDriverVersionUri;
Write-Debug "Current Chrome driver version: [$ChromeDriverVersion]";

$ChromeDriverZipDownloadUri = "https://chromedriver.storage.googleapis.com/$($ChromeDriverVersion.ToString())/chromedriver_win32.zip";
Write-Debug "Chrome driver zip file download Uri: [$ChromeDriverZipDownloadUri]";

$DestFile= "$ChromeDriverPath\chromedriver_win32.zip";
$ChromeDriverVersion.Content | Out-File -FilePath "$ChromeDriverPath\versioninfo.txt" -Force;

Write-Debug "Chrome driver download....";
Invoke-WebRequest -Uri $ChromeDriverZipDownloadUri -OutFile $DestFile;

Write-Debug "Chrome driver install....";
Expand-Archive -Path "$ChromeDriverPath\chromedriver_win32.zip" -DestinationPath $ChromeDriverPath -Force;
Remove-Item -Path "$ChromeDriverPath\chromedriver_win32.zip" -Force;

Write-Debug "Setting the environment variables";

setx IEWebDriver "C:\SeleniumWebDrivers\IEDriver" /M;
setx GeckoWebDriver "C:\SeleniumWebDrivers\GeckoDriver" /M;
setx ChromeWebDriver "C:\SeleniumWebDrivers\ChromeDriver" /M;

exit 0;

