################################################################################
##  File:  Install-EdgeDriver.ps1
##  Desc:  Install Edge WebDriver and configure Microsoft Edge
################################################################################

# Disable Edge auto-updates
Rename-Item -Path "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" -NewName "Disabled_MicrosoftEdgeUpdate.exe" -ErrorAction Stop

# Install Microsoft Edge WebDriver
Write-Host "Install Edge WebDriver..."
$EdgeDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\EdgeDriver"
if (-not (Test-Path -Path $EdgeDriverPath)) {
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
Expand-7ZipArchive -Path $EdgeDriverArchPath -DestinationPath $EdgeDriverPath

#Validate the EdgeDriver signature
$EdgeDriverSignatureThumbprint = "CB9C4FBEA1D87D2D468AC5A9CAAB0163F6AD8401"
Test-FileSignature -FilePath "$EdgeDriverPath\msedgedriver.exe" -ExpectedThumbprint $EdgeDriverSignatureThumbprint

Write-Host "Setting the environment variables..."
[Environment]::SetEnvironmentVariable("EdgeWebDriver", $EdgeDriverPath, "Machine")

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\'
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path'
$PathValue += ";$EdgeDriverPath\"
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue

Invoke-PesterTests -TestFile "Browsers" -TestName "Edge"
