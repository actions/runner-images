################################################################################
##  File:  Validate-VSWhere.ps1
##  Desc:  Validate vswhere
################################################################################

if (Get-Command -Name 'vswhere')
{
    Write-Host "vswhere $(vswhere) on path"
}
else
{
    Write-Host "vswhere is not on path"
    exit 1
}
