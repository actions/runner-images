################################################################################
##  File:  Validate-Perl.ps1
##  Desc:  Validate perl
################################################################################

if (Get-Command -Name 'perl')
{
    Write-Host 'perl on path'
}
else
{
    Write-Host 'perl is not on path'
    exit 1
}

