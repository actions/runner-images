################################################################################
##  File:  Validate-WDK.ps1
##  Desc:  Validate the installation of the Windows Driver Kit
################################################################################

Import-Module -Name ImageHelpers -Force

function Get-WDKVersion
{
    $WDKVersion = (Get-CimInstance -ClassName Win32_Product -Filter "Name = 'Windows Driver Kit'").Version

    if (!$WDKVersion)
    {
        Write-Host "WDK was not found"
        exit 1
    }

    return $WDKVersion
}

$WDKVersion = Get-WDKVersion
$WDKPackageVersion = Get-VSExtensionVersion -packageName "Microsoft.Windows.DriverKit"

# Adding description of the software to Markdown
$SoftwareName = "Windows Driver Kit"

$Description = @"
_WDK Version:_ $WDKVersion<br/>
_WDK Visual Studio Extension Version:_ $WDKPackageVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
