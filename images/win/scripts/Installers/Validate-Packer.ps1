################################################################################
##  File:  Validate-Packer.ps1
##  Desc:  Validate Packer
################################################################################

if (Get-Command -Name 'packer')
{
    Write-Host "Packer is on path"
}
else
{
    Write-Host 'Packer is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "Packer"
$PackerVersion = packer --version

$Description = @"
_Version:_ $PackerVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
