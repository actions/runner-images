################################################################################
##  File:  Validate-7zip.ps1
##  Desc:  Validate 7zip
################################################################################

if (Get-Command -Name '7z')
{
    Write-Host "7zip on path"
}
else
{
    Write-Host '7zip is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "7zip"
$(7z --help).Split([System.Environment]::NewLine)[1] -match "\d+\.\d+"
$7zipVersion = $matches[0]

$Description = @"
_Version:_ $7zipVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
