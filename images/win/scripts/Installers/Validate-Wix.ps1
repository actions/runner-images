################################################################################
##  File:  Validate-Wix.ps1
##  Desc:  Validate WIX.
################################################################################

Import-Module -Name ImageHelpers -Force

function Get-WixVersion {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    $Version = ($installedApplications | Where-Object { $_.DisplayName -and $_.DisplayName.toLower().Contains("wix") } | Select-Object -First 1).DisplayVersion
    return $Version
}

$WixToolSetVersion = Get-WixVersion

if ($WixToolSetVersion) {
    Write-Host "Wix Toolset version" $WixPackage.version "installed"
}
else {
    Write-Host "Wix Toolset is not installed"
    exit 1
}

if (Test-IsWin19)
{
    $null = Get-VSExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev16"
}
else
{
    $null = Get-VSExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev15"
}

