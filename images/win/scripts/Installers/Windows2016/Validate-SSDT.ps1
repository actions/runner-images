################################################################################
##  File:  Validate-SSDT.ps1
##  Desc:  Validate SQL Server Data Tools for Windows
################################################################################

Import-Module -Name ImageHelpers -Force

$SSDTPackageVersion = Get-VSExtensionVersion -packageName "SSDT"

# Adding description of the software to Markdown
$SoftwareName = "SQL Server Data Tools for VS 2017"

$Description = @"
_Version:_ $SSDTPackageVersion<br/>

The following components are installed:

* SQL Server Data Tools
* SQL Server Analysis Services Designer
* SQL Server Integration Services Designer
* SQL Server Reporting Services Designers
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
