################################################################################
##  File:  Validate-MongoDB.ps1
##  Desc:  Validate MongoDB
################################################################################

if (Get-Command -Name 'mongod')
{
    Write-Host 'mongod is on path'
}
else
{
    Write-Host 'mongod not on path'
    exit 1
}

if (Get-Command -Name 'mongo')
{
    Write-Host 'mongo is on path'
}
else
{
    Write-Host 'mongo not on path'
    exit 1
}
