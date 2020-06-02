################################################################################
##  File:  Validate-Boost.ps1
##  Desc:  Validate Boost
################################################################################

Import-Module -Name ImageHelpers

function Validate-BoostVersion
{
    Param
    (
        [String]$BoostRootPath,
        [String]$BoostRelease
    )

    $ReleasePath = Join-Path -Path $BoostRootPath -ChildPath $BoostRelease

    if (Test-Path "$ReleasePath\b2.exe")
    {
        Write-Host "Boost.Build $BoostRelease is successfully installed"
        return
    }

    Write-Host "$BoostRelease not found"
    exit 1
}

$SoftwareName = 'Boost'
$BoostRootDirectory = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $SoftwareName
$BoostTools = Get-ToolsByName -SoftwareName $SoftwareName

foreach ($BoostTool in $BoostTools)
{
    $BoostVersionsToInstall = $BoostTool.Versions | Foreach-Object {"{0}.0" -f $_}
    foreach($BoostVersion in $BoostVersionsToInstall)
    {
        Validate-BoostVersion -BoostRootPath $BoostRootDirectory -BoostRelease $BoostVersion
    }
}
