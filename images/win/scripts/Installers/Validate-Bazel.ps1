################################################################################
##  File:  Validate-Bazel.ps1
##  Desc:  Validate Bazel
################################################################################

if (Get-Command -Name 'bazel')
{
    Write-Host "bazel on path"
}
else
{
    Write-Host 'bazel is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "bazel"

$Description = @"
_Version:_ $(bazel --version)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description