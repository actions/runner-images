################################################################################
##  File:  Install-Chrome.ps1
##  Desc:  Install Google Chrome
################################################################################

Import-Module -Name ImageHelpers -Force;

$ChromeInstallerFile = "chrome_installer.exe";
$ChromeInstallerUri = "https://dl.google.com/chrome/install/375.126/${ChromeInstallerFile}";
Install-Exe -Url $ChromeInstallerUri -Name $ChromeInstallerFile -ArgumentList ("/silent", "/install")

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


