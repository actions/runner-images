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

if($WixToolSetVersion) {
    Write-Host "Wix Toolset version" $WixPackage.version "installed"
}
else {
    Write-Host "Wix Toolset is not installed"
    exit 1
}

$WixPackageVersion = Get-VS19ExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev16"

# Adding description of the software to Markdown
$SoftwareName = "WIX Tools"

$Description = @"
_Toolset Version:_ $WixToolSetVersion<br/>
_WIX Toolset Visual Studio Extension Version:_ $WixPackageVersion<br/>
_Environment:_
* WIX: Installation root of WIX
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
