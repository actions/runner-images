################################################################################
##  File:  Install-Chrome.ps1
##  Desc:  Install Google Chrome browser and Chrome WebDriver
################################################################################

# Download and install latest Chrome browser
Install-Binary `
    -Url 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi' `
    -ExpectedSignature '607A3EDAA64933E94422FC8F0C80388E0590986C'

# Prepare firewall rules
Write-Host "Adding the firewall rule for Google update blocking..."
New-NetFirewallRule -DisplayName "BlockGoogleUpdate" -Direction Outbound -Action Block -Program "C:\Program Files (x86)\Google\Update\GoogleUpdate.exe"

$googleServices = Get-Service -Name "GoogleUpdater*"
Stop-Service $googleServices
$googleServices.WaitForStatus('Stopped', "00:01:00")
$googleServices | Set-Service -StartupType Disabled

$regGoogleUpdatePath = "HKLM:\SOFTWARE\Policies\Google\Update"
$regGoogleUpdateChrome = "HKLM:\SOFTWARE\Policies\Google\Chrome"
($regGoogleUpdatePath, $regGoogleUpdateChrome) | ForEach-Object {
    New-Item -Path $_ -Force
}

$regGoogleParameters = @(
    @{ Name = "AutoUpdateCheckPeriodMinutes"; Value = 00000000},
    @{ Name = "UpdateDefault"; Value = 00000000 },
    @{ Name = "DisableAutoUpdateChecksCheckboxValue"; Value = 00000001 },
    @{ Name = "Update{8A69D345-D564-463C-AFF1-A69D9E530F96}"; Value = 00000000 },
    @{ Path = $regGoogleUpdateChrome; Name = "DefaultBrowserSettingEnabled"; Value = 00000000 }
)

$regGoogleParameters | ForEach-Object {
    $arguments = $_
    if (-not ($arguments.Path)) {
        $arguments.Add("Path", $regGoogleUpdatePath)
    }
    $arguments.Add("Force", $true)
    New-ItemProperty @arguments
}
# Install Chrome WebDriver
Write-Host "Install Chrome WebDriver..."
$chromeDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\ChromeDriver"
if (-not (Test-Path -Path $chromeDriverPath)) {
    New-Item -Path $chromeDriverPath -ItemType Directory -Force
}

Write-Host "Get the Chrome WebDriver download URL..."
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
$chromePath = (Get-ItemProperty "$registryPath\chrome.exe").'(default)'
[version] $chromeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($chromePath).ProductVersion
$chromeBuild = "$($chromeVersion.Major).$($chromeVersion.Minor).$($chromeVersion.Build)"
$chromeDriverVersionsUrl = "https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build-with-downloads.json"

Write-Host "Chrome version is $chromeVersion"
$chromeDriverVersions = Invoke-RestMethod -Uri $chromeDriverVersionsUrl
$chromeDriverVersion = $chromeDriverVersions.builds.$chromeBuild

if (-not ($chromeDriverVersion)) {
    $availableVersions = $chromeDriverVersions.builds | Get-Member | Select-Object -ExpandProperty Name
    Write-Host "Available chromedriver builds are $availableVersions"
    throw "Can't determine chromedriver version that matches chrome build $chromeBuild"
}

$chromeDriverVersion.version | Out-File -FilePath "$chromeDriverPath\versioninfo.txt" -Force;

Write-Host "Chrome WebDriver version to install is $($chromeDriverVersion.version)"
$chromeDriverZipDownloadUrl = ($chromeDriverVersion.downloads.chromedriver | Where-Object platform -eq "win64").url

Write-Host "Download Chrome WebDriver from $chromeDriverZipDownloadUrl..."
$chromeDriverArchPath = Invoke-DownloadWithRetry $chromeDriverZipDownloadUrl

Write-Host "Expand Chrome WebDriver archive (without using directory names)..."
Expand-7ZipArchive -Path $chromeDriverArchPath -DestinationPath $chromeDriverPath -ExtractMethod "e"

Write-Host "Setting the environment variables..."
[Environment]::SetEnvironmentVariable("ChromeWebDriver", $chromeDriverPath, "Machine")
Add-MachinePathItem $chromeDriverPath
Update-Environment

Invoke-PesterTests -TestFile "Browsers" -TestName "Chrome"
