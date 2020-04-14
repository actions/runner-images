####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DACFx) for Windows
####################################################################################

Import-Module -Name ImageHelpers -Force

$InstallerName = "DacFramework.msi"
$InstallerUrl = "https://download.microsoft.com/download/f/1/9/f19eaee6-0728-4a0b-9755-9808acc8af0b/EN/x64/${InstallerName}"

Install-Binary -Url $InstallerUrl -Name $InstallerName