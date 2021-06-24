####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DacFx) for Windows
####################################################################################

$InstallerName = "DacFramework.msi"
$InstallerUrl = "https://go.microsoft.com/fwlink/?linkid=2165211"

Install-Binary -Url $InstallerUrl -Name $InstallerName

Invoke-PesterTests -TestFile "Tools" -TestName "DACFx"