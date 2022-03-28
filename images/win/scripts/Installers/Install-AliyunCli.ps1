################################################################################
##  File:  Install-AliyunCli.ps1
##  Desc:  Install Alibaba Cloud CLI
################################################################################

Write-Host "Download Latest aliyun-cli archive"
$ZipballUrl = 'https://aliyuncli.alicdn.com/aliyun-cli-windows-latest-amd64.zip'
$aliyunArchivePath = Start-DownloadWithRetry -Url $ZipballUrl -Name "aliyun-cli.zip"

Write-Host "Expand aliyun-cli archive"
$aliyunPath = "C:\aliyun-cli"
New-Item -Path $aliyunPath -ItemType Directory -Force
Extract-7Zip -Path $aliyunArchivePath -DestinationPath $aliyunPath

# Add aliyun-cli to path
Add-MachinePathItem $aliyunPath

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Aliyun CLI"