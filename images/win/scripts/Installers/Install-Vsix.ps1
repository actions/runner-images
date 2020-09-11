###################################################################################
##  File:  Install-Vsix.ps1
##  Desc:  Install the Visual Studio Extensions from toolset.json
###################################################################################

Import-Module -Name ImageHelpers -Force
$ErrorActionPreference = "Stop"

$toolset = Get-ToolsetContent
$requiredVsixs = $toolset.visualStudio.vsix

if (Test-IsWin19) {
    $VsVersion = '2019'
}
else {
    $VsVersion = '2017'
}

$requiredVsixs | ForEach-Object {
    Install-VsixExtension -url $_.url -name $_.name -VsVersion $VsVersion
}

Invoke-PesterTests -TestFile "Vsix"