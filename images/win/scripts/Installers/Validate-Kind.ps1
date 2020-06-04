################################################################################
##  File:  Validate-Kind.ps1
##  Desc:  Validate Kind.
################################################################################

if (Get-Command -Name 'kind')
{
    Write-Host "kind $(kind version) in path"
}
else
{
    Write-Host "kind is not in path"
    exit 1
}
