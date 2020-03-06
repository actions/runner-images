################################################################################
##  File:  Install-Edge.ps1
##  Desc:  Install latest stable version of Microsoft Edge browser
################################################################################

choco install microsoft-edge -y

# Install Microsoft Edge Web Driver
Write-Host "Install Edge WebDriver"
$DestinationPath = "$($env:SystemDrive)\";

$EdgeDriverPath = "${DestinationPath}SeleniumWebDrivers\EdgeDriver"
if (-not (Test-Path -Path $EdgeDriverPath)) {
    New-Item -Path $EdgeDriverPath -ItemType "directory"
}

$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
$EdgePath = (Get-ItemProperty "$RegistryPath\msedge.exe").'(default)'
[version]$EdgeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($EdgePath).ProductVersion
$EdgeDriverVersionUrl = "https://msedgedriver.azureedge.net/LATEST_RELEASE_$($EdgeVersion.Major)"
$EdgeDriverVersionFile = "$EdgeDriverPath\versioninfo.txt"
Invoke-WebRequest -Uri $EdgeDriverVersionUrl -OutFile $EdgeDriverVersionFile

Write-Host "Microsoft Edge driver download started"
$EdgeDriverLatestVersion = Get-Content -Path $EdgeDriverVersionFile
$EdgeDriverDownloadUrl="https://msedgedriver.azureedge.net/${EdgeDriverLatestVersion}/edgedriver_win64.zip"
$DestFile = "$EdgeDriverPath\edgedriver_win64.zip"
Invoke-WebRequest -Uri $EdgeDriverDownloadUrl -OutFile $DestFile

Write-Host "Microsoft Edge driver installation started"
Expand-Archive -Path $DestFile -DestinationPath $EdgeDriverPath -Force
Remove-Item -Path $DestFile -Force

Write-Host "Setting the environment variables"

setx EdgeWebDriver "$EdgeDriverPath" /M;

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\';
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path';
$PathValue += ";$EdgeDriverPath\";
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue;
