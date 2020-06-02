################################################################################
##  File:  Validate-OpenSSL.ps1
##  Desc:  Validate openssl
################################################################################

if (Get-Command -Name 'openssl')
{
    Write-Host 'openssl on path'
}
else
{
    Write-Host 'openssl is not on path'
    exit 1
}

