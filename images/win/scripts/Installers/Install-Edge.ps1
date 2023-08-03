################################################################################
##  File:  Install-Edge.ps1
##  Desc:  Configure Edge browser and install Edge WebDriver
################################################################################

# Disable Edge auto-updates
Rename-Item -Path "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" -NewName "Disabled_MicrosoftEdgeUpdate.exe" -ErrorAction Stop

# Install Microsoft Edge WebDriver
Write-Host "Install Edge WebDriver..."
$EdgeDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\EdgeDriver"
if (-not (Test-Path -Path $EdgeDriverPath))
{
    New-Item -Path $EdgeDriverPath -ItemType Directory -Force
}

Write-Host "Get the Microsoft Edge WebDriver version..."
$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
$EdgePath = (Get-ItemProperty "$RegistryPath\msedge.exe").'(default)'
[version]$EdgeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($EdgePath).ProductVersion
$EdgeDriverVersionUrl = "https://msedgedriver.azureedge.net/LATEST_RELEASE_$($EdgeVersion.Major)_WINDOWS"

$EdgeDriverVersionFile = Start-DownloadWithRetry -Url $EdgeDriverVersionUrl -Name "versioninfo.txt" -DownloadPath $EdgeDriverPath

Write-Host "Download Microsoft Edge WebDriver..."
$EdgeDriverLatestVersion = Get-Content -Path $EdgeDriverVersionFile
$EdgeDriverArchName = "edgedriver_win64.zip"

$EdgeDriverDownloadUrl = "https://msedgedriver.azureedge.net/${EdgeDriverLatestVersion}/${EdgeDriverArchName}"

$EdgeDriverArchPath = Start-DownloadWithRetry -Url $EdgeDriverDownloadUrl -Name $EdgeDriverArchName

Write-Host "Expand Microsoft Edge WebDriver archive..."
Extract-7Zip -Path $EdgeDriverArchPath -DestinationPath $EdgeDriverPath

Write-Host "Setting the environment variables..."
setx EdgeWebDriver "$EdgeDriverPath" /M

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\'
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path'
$PathValue += ";$EdgeDriverPath\"
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue

Invoke-PesterTests -TestFile "Browsers" -TestName "Edge"
