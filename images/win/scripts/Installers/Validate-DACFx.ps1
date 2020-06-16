####################################################################################
##  File:  Validate-DACFx.ps1
##  Desc:  Validate SQL Server® Data-Tier Application Framework (DACFx) for Windows
####################################################################################

$env:PATH = $env:Path + ';C:\Program Files\Microsoft SQL Server\120\DAC\bin;C:\Program Files\Microsoft SQL Server\130\DAC\bin;C:\Program Files\Microsoft SQL Server\140\DAC\bin;C:\Program Files\Microsoft SQL Server\150\DAC\bin'

if (Get-Command -Name 'SqlPackage')
{
    Write-Host "DACFx is installed at path" (Get-Command -Name 'SqlPackage').Source
}
else
{
    throw "DACFx is not installed!"
}

if (Get-Command -Name 'SqlLocalDB')
{
    Write-Host "SQL Server Express LocalDB is available at " (Get-Command -Name SqlLocalDB).Source
}
else
{
    throw "SqlLocalDB is not installed!"
}
