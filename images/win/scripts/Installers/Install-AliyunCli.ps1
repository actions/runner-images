################################################################################
##  File:  Install-AliyunCli.ps1
##  Desc:  Install Alibaba Cloud CLI
################################################################################

Choco-Install -PackageName aliyun-cli

Invoke-PesterTests -TestFile "Tools" -TestName "AliyunCli"