################################################################################
##  File:  Install-Chrome.ps1
##  Desc:  Install Google Chrome
################################################################################

Import-Module -Name ImageHelpers -Force;

$ChromeInstallerFile = "chrome_installer.exe";
$ChromeInstallerUrl = "https://dl.google.com/chrome/install/375.126/${ChromeInstallerFile}";
Install-Binary -Url $ChromeInstallerUrl -Name $ChromeInstallerFile -ArgumentList ("/silent", "/install")

Write-Host "Adding the firewall rule for Google update blocking";
New-NetFirewallRule -DisplayName "BlockGoogleUpdate" -Direction Outbound -Action Block -Program "C:\Program Files (x86)\Google\Update\GoogleUpdate.exe";

$GoogleSvcs = ('gupdate','gupdatem');
$GoogleSvcs | Stop-SvcWithErrHandling -StopOnError;
$GoogleSvcs | Set-SvcWithErrHandling -Arguments @{StartupType = "Disabled"};

$regGoogleUpdatePath = "HKLM:\SOFTWARE\Policies\Google\Update";
$regGoogleUpdateChrome = "HKLM:\SOFTWARE\Policies\Google\Chrome";
($regGoogleUpdatePath, $regGoogleUpdateChrome) | ForEach-Object {
    New-Item -Path $_ -Force;
}

$regGoogleParameters = @(
    @{ Name = "AutoUpdateCheckPeriodMinutes"; Value = 00000000},
    @{ Name = "UpdateDefault"; Value = 00000000 },
    @{ Name = "DisableAutoUpdateChecksCheckboxValue"; Value = 00000001 },
    @{ Name = "Update{8A69D345-D564-463C-AFF1-A69D9E530F96}"; Value = 00000000 },
    @{ Path = $regGoogleUpdateChrome; Name = "DefaultBrowserSettingEnabled"; Value = 00000000 }
)

$regGoogleParameters | ForEach-Object {
    $Arguments = $_;
    if (-not ($Arguments.Path)) {
        $Arguments.Add("Path", $regGoogleUpdatePath);
    }
    $Arguments.Add("Force", $true);
    New-ItemProperty @Arguments;
}

# Reinstall Chrome Web Driver
Write-Host "Install Chrome WebDriver"
$DestinationPath = "$($env:SystemDrive)\";
$ChromeDriverPath = "${DestinationPath}SeleniumWebDrivers\ChromeDriver";

if (-not (Test-Path -Path $ChromeDriverPath)) {
    New-Item -Path $ChromeDriverPath -ItemType "directory"
}

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

Write-Host "Setting the environment variables"

setx ChromeWebDriver "$ChromeDriverPath" /M;

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\';
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path';
$PathValue += ";$ChromeDriverPath\";
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue;
