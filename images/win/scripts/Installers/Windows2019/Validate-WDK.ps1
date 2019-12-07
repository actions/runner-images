################################################################################
##  File:  Validate-WDK.ps1
##  Desc:  Validate the installation of the Windows Driver Kit
################################################################################

# Adding description of the software to Markdown
$SoftwareName = "Windows Driver Kit"

$Description = @"
_Version:_ 10.0.18362.0<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
