################################################################################
##  File:  Install-awscli.ps1
##  Desc:  Install awscli
################################################################################

choco install awscli -y

refreshenv

$command = Get-Command -Name 'aws'

if ($command)
{
    Write-Host "awscli on path"
}
else
{
    Write-Host 'awscli is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "AWS CLI"

$version = (aws --version).Split(" ")[0].Replace("/"," ")

$Description = @"
_Version:_ $version<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description