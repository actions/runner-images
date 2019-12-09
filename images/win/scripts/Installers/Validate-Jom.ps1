################################################################################
##  File:  Validate-Jom.ps1
##  Desc:  Validate jom
################################################################################

if (Get-Command -Name 'jom')
{
    Write-Host "jom on path"
}
else
{
    Write-Host 'jom is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "jom"

$Description = @"
_Version:_ $(jom /VERSION)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
