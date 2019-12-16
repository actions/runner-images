################################################################################
##  File:  Validate-Kind.ps1
##  Desc:  Validate Kind.
################################################################################


if((Get-Command -Name 'kind'))
{
    Write-Host "kind $(kind version) in path"
}
else
{
    Write-Host "kind is not in path"
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "Kind"

$version = $(kind version)

$Description = @"
_Version:_ $version<br/>
_Environment:_
* PATH: contains location of kind.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
