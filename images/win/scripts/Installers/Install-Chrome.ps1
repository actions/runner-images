################################################################################
##  File:  Install-Chrome.ps1
##  Desc:  Install Google Chrome
################################################################################

# Download and install latest Chrome browser
$ChromeInstallerFile = "googlechromestandaloneenterprise64.msi"
$ChromeInstallerUrl = "https://dl.google.com/tag/s/dl/chrome/install/${ChromeInstallerFile}"
Install-Binary -Url $ChromeInstallerUrl -Name $ChromeInstallerFile -ArgumentList @()

# Prepare firewall rules
Write-Host "Adding the firewall rule for Google update blocking..."
New-NetFirewallRule -DisplayName "BlockGoogleUpdate" -Direction Outbound -Action Block -Program "C:\Program Files (x86)\Google\Update\GoogleUpdate.exe"

$GoogleSvcs = ('gupdate','gupdatem')
$GoogleSvcs | Stop-SvcWithErrHandling -StopOnError
$GoogleSvcs | Set-SvcWithErrHandling -Arguments @{StartupType = "Disabled"}

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

Write-Host "Get the Chrome WebDriver version..."
$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
$ChromePath = (Get-ItemProperty "$RegistryPath\chrome.exe").'(default)'
$ChromeVersionUri = "https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build-with-downloads.json"
$ChromePlatform = 'win64'
[version]$ChromeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($ChromePath).ProductVersion
$ChromeDriverVersions = Invoke-RestMethod -Method GET -Uri $ChromeVersionUri
$ChromeDriverZipDownloadUrl = ($ChromeDriverVersions.Builds."$($ChromeVersion.Major).$($ChromeVersion.Minor).$($ChromeVersion.Build)".downloads.chromedriver | Where-Object { $_.platform -eq $ChromePlatform }).url

Write-Host "Download Chrome WebDriver..."
$ChromeDriverArchPath = Start-DownloadWithRetry -Url $ChromeDriverZipDownloadUrl

Write-Host "Expand Chrome WebDriver archive..."
Extract-7Zip -Path $ChromeDriverArchPath -DestinationPath $ChromeDriverPath

Write-Host "Setting the environment variables..."
setx ChromeWebDriver "$ChromeDriverPath" /M

$regEnvKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\'
$PathValue = Get-ItemPropertyValue -Path $regEnvKey -Name 'Path'
$PathValue += ";$ChromeDriverPath\"
Set-ItemProperty -Path $regEnvKey -Name 'Path' -Value $PathValue

Invoke-PesterTests -TestFile "Browsers" -TestName "Chrome"