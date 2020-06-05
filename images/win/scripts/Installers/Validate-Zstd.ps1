################################################################################
##  File:  Validate-zstd.ps1
##  Desc:  Validate zstd
################################################################################

if (Get-Command -Name 'zstd')
{
    Write-Host 'zstd on path'
}
else
{
    Write-Host 'zstd is not on path'
    exit 1
}

