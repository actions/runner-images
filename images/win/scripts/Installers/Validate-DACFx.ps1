####################################################################################
##  File:  Validate-DACFx.ps1
##  Desc:  Validate SQL Server® Data-Tier Application Framework (DACFx) for Windows
####################################################################################

$env:PATH = $env:Path + ';C:\Program Files\Microsoft SQL Server\120\DAC\bin;C:\Program Files\Microsoft SQL Server\130\DAC\bin;C:\Program Files\Microsoft SQL Server\140\DAC\bin;C:\Program Files\Microsoft SQL Server\150\DAC\bin'

if(Get-Command -Name 'SqlPackage')
{

    Write-Host "DACFx is installed at path" (Get-Command -Name 'SqlPackage').Source
}
else
{
    throw "DACFx is not installed!"
}

function Get-DacFxVersion
{
    $regKey = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Data-Tier Application Framework\CurrentVersion"
    $Version = (Get-ItemProperty -Path $regKey).'(Default)'
    return $Version
}


# Adding description of the software to Markdown
$SoftwareName = "SQL Server Data Tier Application Framework (x64)"

$Description = @"
_Version:_ $(Get-DacFxVersion)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
