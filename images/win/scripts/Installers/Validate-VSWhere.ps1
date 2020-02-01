################################################################################
##  File:  Validate-VSWhere.ps1
##  Desc:  Validate vswhere
################################################################################

if(Get-Command -Name 'vswhere')
{
    Write-Host "vswhere $(vswhere) on path"
}
else
{
    Write-Host "vswhere is not on path"
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "VSWhere"
$VswhereVersion = $(vswhere)

$Description = @"
_Version_: $VswhereVersion<br/>
* PATH: contains location of vswhere.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description