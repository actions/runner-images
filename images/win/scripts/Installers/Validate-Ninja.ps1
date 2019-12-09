################################################################################
##  File:  Validate-Ninja.ps1
##  Desc:  Validate ninja
################################################################################

if (Get-Command -Name 'ninja')
{
    Write-Host "ninja on path"
}
else
{
    Write-Host 'ninja is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "ninja"

$Description = @"
_Version:_ $(ninja --version)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
