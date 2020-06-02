################################################################################
##  File:  Validate-Bazel.ps1
##  Desc:  Validate Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

if (Get-Command -Name 'bazel')
{
    Write-Host 'bazel on path'
}
else
{
    Write-Host 'bazel is not on path'
    exit 1
}

if (Get-Command -Name 'bazelisk')
{
    Write-Host 'bazelisk on path'
}
else
{
    Write-Host 'bazelisk is not on path'
    exit 1
}


