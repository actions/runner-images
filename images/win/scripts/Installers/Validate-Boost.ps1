################################################################################
##  File:  Validate-Boost.ps1
##  Desc:  Validate Boost
################################################################################

function Validate-BoostVersion
{
    Param
    (
        [String]$BoostRootPath,
        [String]$BoostRelease
    )

    $ReleasePath = Join-Path -Path $BoostRootPath -ChildPath $BoostRelease

    if ((Test-Path "$ReleasePath\b2.exe") -and (Test-Path "$ReleasePath\bjam.exe"))
    {
        Write-Host "Boost.Build $BoostRelease is successfully installed"
        Write-Host "Boost.Jam $BoostRelease is successfully installed"
        return
    }

    Write-Host "$BoostRelease not found"
    exit 1
}

# Verify that Boost is on the path
if ((Get-Command -Name 'b2') -and (Get-Command -Name 'bjam'))
{
    Write-Host "Boost is on the path"
}
else
{
    Write-Host "Boost is not on the path"
    exit 1
}

# Adding description of the software to Markdown
$tmplMark = @"
#### {0}

_Environment:_
* {1}: root directory of the Boost version {0} installation

"@

$tmplMarkRoot = @"
#### {0}

* PATH: contains the location of Boost version {0}
* BOOST_ROOT: root directory of the Boost version {0} installation
* {1}: root directory of the Boost version {0} installation
"@

$SoftwareName = 'Boost'
$Description = New-Object System.Text.StringBuilder
$BoostRootDirectory = Join-Path -Path $env:ProgramFiles -ChildPath "Boost"
$BoostVersionsToInstall = $env:BOOST_VERSIONS.split(",")

foreach($Boost in $BoostVersionsToInstall)
{
    Validate-BoostVersion -BoostRootPath $BoostRootDirectory -BoostRelease $Boost
    $BoostVersionTag = "BOOST_ROOT_{0}" -f $Boost.Replace('.', '_')

    if($boost -eq $env:BOOST_DEFAULT)
    {
        $null = $Description.AppendLine(($tmplMarkRoot -f $BoostVersion, $BoostVersionTag))
    }
    else
    {
        $null = $Description.AppendLine(($tmplMark -f $BoostVersion, $BoostVersionTag))
    }
}

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description.ToString()
