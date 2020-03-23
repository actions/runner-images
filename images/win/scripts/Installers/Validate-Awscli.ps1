################################################################################
##  File:  Validate-awscli.ps1
##  Desc:  Validate awscli
################################################################################

$command = Get-Command -Name 'awscli'

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
$version = $command.Version.ToString()

$Description = @"
_Version:_ $version<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description