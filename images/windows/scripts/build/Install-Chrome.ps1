################################################################################
##  File:  Install-Chrome.ps1
##  Desc:  Install Google Chrome browser and Chrome WebDriver
################################################################################

# Download and install latest Chrome browser
Install-Binary `
    -Url 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi' `
    -ExpectedSignature '2673EA6CC23BEFFDA49AC715B121544098A1284C'

# Prepare firewall rules
Write-Host "Adding the firewall rule for Google update blocking..."
New-NetFirewallRule -DisplayName "BlockGoogleUpdate" -Direction Outbound -Action Block -Program "C:\Program Files (x86)\Google\Update\GoogleUpdate.exe"

$googleServices = @('gupdate', 'gupdatem') | Get-Service
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
    $Arguments = $_
    if (-not ($Arguments.Path))
    {
        $Arguments.Add("Path", $regGoogleUpdatePath)
    }
    $Arguments.Add("Force", $true)
    New-ItemProperty @Arguments
}

# Install Chrome WebDriver
Write-Host "Install Chrome WebDriver..."
$ChromeDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\ChromeDriver"
if (-not (Test-Path -Path $ChromeDriverPath))
{
    New-Item -Path $ChromeDriverPath -ItemType Directory -Force
}

Write-Host "Get the Chrome WebDriver download URL..."
$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
$ChromePath = (Get-ItemProperty "$RegistryPath\chrome.exe").'(default)'
[version]$ChromeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($ChromePath).ProductVersion
$ChromeBuild = "$($ChromeVersion.Major).$($ChromeVersion.Minor).$($ChromeVersion.Build)"
$ChromeDriverVersionsUrl = "https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build-with-downloads.json"

Write-Host "Chrome version is $ChromeVersion"
$ChromeDriverVersions = Invoke-RestMethod -Uri $ChromeDriverVersionsUrl
$ChromeDriverVersion = $ChromeDriverVersions.builds.$ChromeBuild

if (-not ($ChromeDriverVersion)) {
    $availableVersions = $ChromeDriverVersions.builds | Get-Member | Select-Object -ExpandProperty Name
    Write-Host "Available chromedriver builds are $availableVersions"
    Throw "Can't determine chromedriver version that matches chrome build $ChromeBuild"
}

$ChromeDriverVersion.version | Out-File -FilePath "$ChromeDriverPath\versioninfo.txt" -Force;

Write-Host "Chrome WebDriver version to install is $($ChromeDriverVersion.version)"
$ChromeDriverZipDownloadUrl = ($ChromeDriverVersion.downloads.chromedriver | Where-Object platform -eq "win64").url

Write-Host "Download Chrome WebDriver from $ChromeDriverZipDownloadUrl..."
$ChromeDriverArchPath = Start-DownloadWithRetry -Url $ChromeDriverZipDownloadUrl

Write-Host "Expand Chrome WebDriver archive (without using directory names)..."
Expand-7ZipArchive -Path $ChromeDriverArchPath -DestinationPath $ChromeDriverPath -ExtractMethod "e"

Write-Host "Setting the environment variables..."
[Environment]::SetEnvironmentVariable("ChromeWebDriver", $ChromeDriverPath, "Machine")

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\'
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path'
$PathValue += ";$ChromeDriverPath\"
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue

Invoke-PesterTests -TestFile "Browsers" -TestName "Chrome"
