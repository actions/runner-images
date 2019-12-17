################################################################################
##  File:  Validate-ServiceFabricSDK.ps1
##  Desc:  Validate ServiceFabricSDK
################################################################################

$modules = Get-Module -Name ServiceFabric -ListAvailable

if(($modules | Measure-Object).Count -gt 0)
{
    $modules
}
else {
    Write-Host "ServiceFabric Module is not present, it might not be installed"
    throw "ServiceFabric Module is not present, it might not be installed"
}


function Get-ServiceFabricSDKVersion
{
    $regKey = "HKLM:\Software\Microsoft\Service Fabric SDK"
    $installedApplications = Get-ItemProperty -Path $regKey
    $Version = (Get-ItemProperty -Path $regKey).FabricSDKVersion
    return $Version
}


function Get-ServiceFabricVersion
{
    $regKey = "HKLM:\Software\Microsoft\Service Fabric"
    $installedApplications = Get-ItemProperty -Path $regKey
    $Version = (Get-ItemProperty -Path $regKey).FabricVersion
    return $Version
}


# Adding description of the software to Markdown
$SoftwareName = "Azure Service Fabric"

$Description = @"
_SDK Version:_ $(Get-ServiceFabricSDKVersion)<br/>
_Runtime Version:_ $(Get-ServiceFabricVersion)
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
