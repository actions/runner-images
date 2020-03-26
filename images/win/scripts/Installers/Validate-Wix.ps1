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

if(Test-IsWin19)
{
    $WixPackageVersion = Get-VSExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev16"
    $VSver = "2019"
}
else
{
    $WixPackageVersion = Get-VSExtensionVersion -packageName "WixToolset.VisualStudioExtension.Dev15"
    $VSver = "2017"
}

# Adding description of the software to Markdown
$SoftwareName = "WIX Tools"

$Description = @"
_Toolset Version:_ $WixToolSetVersion<br/>
_WIX Toolset Studio $VSver Extension Version:_ $WixPackageVersion<br/>
_Environment:_
* WIX: Installation root of WIX
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
