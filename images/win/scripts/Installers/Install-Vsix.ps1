###################################################################################
##  File:  Install-Vsix.ps1
##  Desc:  Install the Visual Studio Extensions from toolset.json
###################################################################################

$ErrorActionPreference = "Stop"

$toolset = Get-ToolsetContent
$requiredVsixs = $toolset.visualStudio.vsix
if(-not $requiredVsixs) {
    Write-Host "No requiered VSIX extensions"
    exit 0
}

$VsVersion = $toolset.visualStudio.Version
$requiredVsixs | ForEach-Object {
    Install-VsixExtension -url $_.url -name $_.name -VsVersion $VsVersion
}

Invoke-PesterTests -TestFile "Vsix"