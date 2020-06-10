################################################################################
##  File:  Validate-GitHub-CLI.ps1
##  Desc:  Validate GitHub CLI
################################################################################

if (Get-Command -Name 'gh')
{
    Write-Host 'gh on path'
}
else
{
    Write-Host 'gh is not on path'
    exit 1
}
