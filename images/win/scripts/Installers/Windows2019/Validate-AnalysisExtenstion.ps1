################################################################################
##  File:  Validate-AnalysisExtenstion.ps1
##  Desc:  Validate Microsoft Analysis Services Projects Visual Studio extension
################################################################################

Import-Module -Name ImageHelpers -Force

#AnalysisPackage doesn't have any proper name in the state.packages.json file, only id is available
$AnalysisPackageVersion = Get-VS19ExtensionVersion -packageName "04a86fc2-dbd5-4222-848e-911638e487fe"

# Adding description of the software to Markdown
$SoftwareName = "Microsoft Analysis Services Projects Visual Studio Extension"

$Description = @"
_Version:_ $AnalysisPackageVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description