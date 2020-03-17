################################################################################
##  File:  Validate-SSDTExtensions.ps1
##  Desc:  Validate SQL Server Data Tools Visual Studio extensions
################################################################################

Import-Module -Name ImageHelpers -Force

#These extensions don't have any proper name in the state.packages.json file, only id is available, which can be found on extension marketplace download page
$AnalysisPackageVersion = Get-VSExtensionVersion -packageName "04a86fc2-dbd5-4222-848e-911638e487fe"
$IntegrationPackageVersion = Get-VSExtensionVersion -packageName "851E7A09-7B2B-4F06-A15D-BABFCB26B970"
$ReportingPackageVersion = Get-VSExtensionVersion -packageName "717ad572-c4b7-435c-c166-c2969777f718"

# Adding description of the software to Markdown
$SoftwareName = "Microsoft SSDT Visual Studio 2019 Extensions"

$Description = @"
_Microsoft Analysis Services Projects Version:_ $AnalysisPackageVersion<br/>
_SQL Server Integration Services Projects Version:_ $IntegrationPackageVersion<br/>
_Microsoft Reporting Services Projects Version:_ $ReportingPackageVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
