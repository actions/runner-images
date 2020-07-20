################################################################################
##  File:  Validate-R.ps1
##  Desc:  Validate R.
################################################################################

# Validate Rscript
if (Get-Command -Name 'Rscript')
{
    Write-Host "Rscript on path"
}
else
{
    Write-Host 'Rscript is not on path'
    exit 1
}