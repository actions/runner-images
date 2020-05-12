################################################################################
##  File:  Validate-GitHub-CLI.ps1
##  Desc:  Validate GitHub CLI
################################################################################

$command = Get-Command -Name 'gh'

if ($command)
{
    Write-Host "gh on path"
}
else
{
    Write-Host 'gh is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "GitHub CLI"

$version = (gh --version).Split()[2]

$Description = @"
_Version:_ $version<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description