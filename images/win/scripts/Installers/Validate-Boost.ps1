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

# Adding description of the software to Markdown
$tmplMark = @"
#### {0} [{2}]

_Environment:_
* {1}: root directory of the Boost version {0} installation

"@

$Description = New-Object System.Text.StringBuilder
$SoftwareName = 'Boost'
$BoostRootDirectory = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $SoftwareName
$BoostTools = Get-ToolsByName -SoftwareName $SoftwareName

foreach ($BoostTool in $BoostTools)
{
    $BoostToolsetName = $BoostTool.Architecture
    $BoostVersionsToInstall = $BoostTool.Versions | Foreach-Object {"{0}.0" -f $_}
    foreach($BoostVersion in $BoostVersionsToInstall)
    {
        Validate-BoostVersion -BoostRootPath $BoostRootDirectory -BoostRelease $BoostVersion
        $BoostVersionTag = "BOOST_ROOT_{0}" -f $BoostVersion.Replace('.', '_')

        $null = $Description.AppendLine(($tmplMark -f $BoostVersion, $BoostVersionTag, $BoostToolsetName))
    }
}

$CMakeFindBoostInfo = @"

#### _Notes:_

> ``BOOST_ROOT`` is not set on images but it is required by CMake. Please make sure you set this variable
> value to either ``BOOST_ROOT_1_69_0`` or ``BOOST_ROOT_1_72_0`` depending on the Boost version you are using.

Link: https://cmake.org/cmake/help/latest/module/FindBoost.html

If Boost was built using the ``boost-cmake`` project or from ``Boost 1.70.0`` on it provides a package
configuration file for use with find\_package's config mode. This module looks for the package
configuration file called BoostConfig.cmake or boost-config.cmake and stores the result in CACHE entry "Boost_DIR".
If found, the package configuration file is loaded and this module returns with no further action.
See documentation of the Boost CMake package configuration for details on what it provides.

Set ``Boost_NO_BOOST_CMAKE to ON``, to disable the search for boost-cmake.
"@

$null = $Description.AppendLine($CMakeFindBoostInfo)
Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description.ToString()
