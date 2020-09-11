###################################################################################
##  File:  Install-Vsix.ps1
##  Desc:  Install the Visual Studio Extensions from toolset.json
###################################################################################

$ErrorActionPreference = "Stop"

$toolset = Get-ToolsetContent
$VsixPackagesList = $toolset.visualStudio.vsix
if (-not $VsixPackagesList) {
    Write-Host "No extensions to install"
    exit 0
}

$VsVersion = $toolset.visualStudio.Version
$VsixPackagesList | ForEach-Object {
    Install-VsixExtension -url $_.url -name $_.name -VsVersion $VsVersion
}

Invoke-PesterTests -TestFile "Vsix"