################################################################################
##  File:  Validate-AWS-SAM.ps1
##  Desc:  Validate aws sam cli
################################################################################

$command = Get-Command -Name 'sam'

if ($command)
{
    Write-Host "AWS SAM CLI on path"
}
else
{
    Write-Host 'AWS SAM CLI is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "AWS SAM CLI"

$version = (sam --version).Split(" ")[3]

$Description = @"
_Version:_ $version<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description