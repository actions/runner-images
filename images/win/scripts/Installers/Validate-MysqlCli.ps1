################################################################################
##  File:  Validate-MysqlCli.ps1
##  Desc:  Validate Mysql Cli
################################################################################

if (Get-Command -Name 'mysql')
{
    Write-Host 'Mysql is on path'
}
else
{
    Write-Host 'Mysql not on path'
    exit 1
}

