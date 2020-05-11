################################################################################
##  File:  Validate-AliyunCli.ps1
##  Desc:  Validate Alibaba Cloud CLI
################################################################################

if (Get-Command -Name 'aliyun')
{
    Write-Host "Alibaba Cloud CLI on path"
}
else
{
    Write-Host 'Alibaba Cloud CLI is not on path'
    exit 1
}

# Adding description of the software to Markdown
$aliyun_version = ((aliyun --version | Select-String "Alibaba Cloud Command Line Interface Version ") -Split(" "))[6]

$SoftwareName = "Alibaba Cloud CLI"
$Description = @"
_Version:_ $aliyun_version<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description