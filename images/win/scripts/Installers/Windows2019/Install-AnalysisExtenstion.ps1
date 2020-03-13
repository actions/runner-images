###################################################################################
##  File:  Install-AnalysisExtenstion.ps1
##  Desc:  Install the Microsoft Analysis Services Projects Visual Studio extension
###################################################################################

Import-Module -Name ImageHelpers -Force;

$extensionUrl = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ProBITools/vsextensions/MicrosoftAnalysisServicesModelingProjects/2.9.5/vspackage"
$extensionName = "Microsoft.DataTools.AnalysisServices.vsix"

Install-VsixExtension -Url $extensionUrl -Name $extensionName
