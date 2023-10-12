####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DacFx) for Windows
####################################################################################

$InstallerName = "DacFramework.msi"
$InstallerUrl = "https://aka.ms/dacfx-msi"
$SignatureThumbprint = "72105B6D5F370B62FD5C82F1512F7AD7DEE5F2C0"

Install-Binary -Url $InstallerUrl -Name $InstallerName -ExpectedSignature $SignatureThumbprint

Invoke-PesterTests -TestFile "Tools" -TestName "DACFx"
