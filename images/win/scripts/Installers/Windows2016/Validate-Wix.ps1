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

#Gets the extension details from state.json
function Get-WixExtensionPackage {
    $vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
    $instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

    if($instanceFolders -is [array])
    {
        Write-Host "More than one instance installed"
        exit 1
    }

    $stateContent = Get-Content -Path ($instanceFolders.FullName + '\state.packages.json')
    $state = $stateContent | ConvertFrom-Json
    $WixPackage = $state.packages | where { $_.id -eq "WixToolset.VisualStudioExtension.Dev15" }
    return $WixPackage
}

$WixToolSetVersion = Get-WixVersion

if($WixToolSetVersion) {
    Write-Host "Wix Toolset version" $WixPackage.version "installed"
}
else {
    Write-Host "Wix Toolset is not installed"
    exit 1
}

$WixPackage = Get-WixExtensionPackage

if($WixPackage) {
    Write-Host "Wix Extension version" $WixPackage.version "installed"
}
else {
    Write-Host "Wix Extension is not installed"
    exit 1
}


# Adding description of the software to Markdown
$SoftwareName = "WIX Tools"

$Description = @"
_Toolset Version:_ $WixToolSetVersion<br/>
_WIX Toolset Studio 2017 Extension Version:_ $($WixPackage.version)<br/>
_Environment:_
* WIX: Installation root of WIX
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
