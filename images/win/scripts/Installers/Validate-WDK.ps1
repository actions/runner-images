################################################################################
##  File:  Validate-WDK.ps1
##  Desc:  Validate the installation of the Windows Driver Kit
################################################################################

function Get-WDKVersion
{
    $WDKVersion = (Get-CimInstance -ClassName Win32_Product -Filter "Name = 'Windows Driver Kit'").Version

    if (!$WDKVersion)
    {
        Write-Host "WDK was not found"
        exit 1
    }
}

Get-WDKVersion
$null = Get-VSExtensionVersion -packageName "Microsoft.Windows.DriverKit"

