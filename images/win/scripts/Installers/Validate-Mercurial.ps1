################################################################################
##  File:  Validate-Mercurial.ps1
##  Desc:  Validate Mercurial
################################################################################

if (Get-Command -Name 'hg')
{
    Write-Host "Mercurial on path"
}
else
{
    Write-Host 'Mercurial is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "Mercurial"
$(hg --version).Split([System.Environment]::NewLine)[0] -match "\d+\.\d+"
$MercurialVersion = $matches[0]

$Description = @"
_Version:_ $MercurialVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
