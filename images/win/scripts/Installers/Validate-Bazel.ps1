################################################################################
##  File:  Validate-Bazel.ps1
##  Desc:  Validate Bazel and Bazelisk (A user-friendly launcher for Bazel)
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

if (Get-Command -Name 'bazelisk')
{
    Write-Host "bazelisk on path"
}
else
{
    Write-Host 'bazelisk is not on path'
    exit 1
}

# Adding description of Bazel to Markdown
$SoftwareName = "bazel"

$Description = @"
_Version:_ $(bazel --version)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

# Adding description of Bazelisk to Markdown
$bazelisk_version = ((bazelisk version | Select-String "Bazelisk version:") -Split(" v"))[2]

$SoftwareName = "bazelisk"

$Description = @"
_Version:_ $bazelisk_version<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
