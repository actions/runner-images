####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DACFx) for Windows
####################################################################################

Import-Module -Name ImageHelpers -Force

$InstallerName = "DacFramework.msi"
$InstallerUrl = "https://go.microsoft.com/fwlink/?linkid=2128142"

Install-Binary -Url $InstallerUrl -Name $InstallerName