################################################################################
##  File:  Validate-Jq.ps1
##  Desc:  Validate jq
################################################################################

if (Get-Command -Name 'jq')
{
    Write-Host "jq on path"
}
else
{
    Write-Host 'jq is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "jq"

$Description = @"
_Version:_ $(jq --version)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
