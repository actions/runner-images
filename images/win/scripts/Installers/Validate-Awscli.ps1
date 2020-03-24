################################################################################
##  File:  Validate-awscli.ps1
##  Desc:  Validate awscli
################################################################################

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
$SoftwareName = "Aws CLI"

$AwsVersion = (aws --version).Split(" ")[0].Replace("/"," ")

$Description = @"
_Version:_ $AwsVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description