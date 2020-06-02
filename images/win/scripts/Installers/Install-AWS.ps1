################################################################################
##  File:  Install-awscli.ps1
##  Desc:  Install awscli
################################################################################

Choco-Install -PackageName awscli

$env:Path = $env:Path + ";$env:ProgramFiles\Amazon\AWSCLIV2"
if (Get-Command -Name 'aws')
{
    Write-Host 'awscli on path'
}
else
{
    Write-Host 'awscli is not on path'
    exit 1
}
