################################################################################
##  File:  Validate-AliyunCli.ps1
##  Desc:  Validate Alibaba Cloud CLI
################################################################################

if (Get-Command -Name 'aliyun')
{
    Write-Host 'Alibaba Cloud CLI on path'
}
else
{
    Write-Host 'Alibaba Cloud CLI is not on path'
    exit 1
}
