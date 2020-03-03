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
$BazelName = "bazel"
$BazeliskName = "bazelisk"

$BazelDescription = @"
_Version:_ $(bazel --version)<br/>
"@
$BazeliskDescription = @"
_Version:_ $(bazelisk version)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $BazelName -DescriptionMarkdown $BazelDescription
Add-SoftwareDetailsToMarkdown -SoftwareName $BazeliskName -DescriptionMarkdown $BazeliskDescription