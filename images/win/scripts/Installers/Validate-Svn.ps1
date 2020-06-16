################################################################################
##  File:  Validate-Svn.ps1
##  Desc:  Validate Subversion
################################################################################

if (Get-Command -Name 'svn')
{
    Write-Host "Subversion $(svn --version --quiet) is on the path."
}
else
{
    Write-Host "Subversion is not on the path."
    exit 1
}
