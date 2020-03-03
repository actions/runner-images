################################################################################
##  File:  Validate-Bazelisk.ps1
##  Desc:  Validate Bazelisk (A user-friendly launcher for Bazel)
################################################################################

if (Get-Command -Name 'bazelisk')
{
    Write-Host "bazelisk on path"
}
else
{
    Write-Host 'bazelisk is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "bazelisk"

$Description = @"
_Version:_ $(bazelisk version)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description