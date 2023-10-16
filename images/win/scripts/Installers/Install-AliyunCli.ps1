################################################################################
##  File:  Install-AliyunCli.ps1
##  Desc:  Install Alibaba Cloud CLI
##  Supply chain security: Alibaba Cloud CLI - checksum validation
################################################################################

Write-Host "Download Latest aliyun-cli archive"
$repoUrl = "https://api.github.com/repos/aliyun/aliyun-cli/releases/latest"
$installerFileName = "aliyun-cli-windows"
$assets = (Invoke-RestMethod -Uri $repoUrl).assets
$downloadUrl = ($assets.browser_download_url -ilike "*aliyun-cli-windows-*-amd64.zip*") | Select-Object -First 1
$packagePath = Start-DownloadWithRetry -Url $downloadUrl -Name "$installerFileName.zip"

#region Supply chain security - Alibaba Cloud CLI
$fileHash = (Get-FileHash -Path $packagePath -Algorithm SHA256).Hash
$hashUrl = ($assets.browser_download_url -ilike "*SHASUMS256.txt*") | Select-Object -First 1
$externalHash = (Invoke-RestMethod -Uri $hashURL).ToString().Split("`n").Where({ $_ -ilike "*$installerFileName*" }).Split(' ')[0]
Use-ChecksumComparison $fileHash $externalHash
#endregion

Write-Host "Expand aliyun-cli archive"
$aliyunPath = "C:\aliyun-cli"
New-Item -Path $aliyunPath -ItemType Directory -Force
Extract-7Zip -Path $packagePath -DestinationPath $aliyunPath

# Add aliyun-cli to path
Add-MachinePathItem $aliyunPath

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Aliyun CLI"
