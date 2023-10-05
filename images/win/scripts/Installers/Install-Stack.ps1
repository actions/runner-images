################################################################################
##  File:  Install-Stack.ps1
##  Desc:  Install Stack for Windows
##  Supply chain security: Stack - checksum validation
################################################################################

Write-Host "Get the latest Stack version..."
$StackReleasesJson = Invoke-RestMethod "https://api.github.com/repos/commercialhaskell/stack/releases/latest"
$Version = $StackReleasesJson.name.TrimStart("v")
$DownloadFilePattern = "windows-x86_64.zip"
$DownloadUrl = $StackReleasesJson.assets | Where-Object { $_.name.EndsWith($DownloadFilePattern) } | Select-Object -ExpandProperty "browser_download_url" -First 1

Write-Host "Download stack archive"
$StackToolcachePath = Join-Path $Env:AGENT_TOOLSDIRECTORY "stack\$Version"
$DestinationPath = Join-Path $StackToolcachePath "x64"
$StackArchivePath = Start-DownloadWithRetry -Url $DownloadUrl

#region Supply chain security - Stack
$fileHash = (Get-FileHash -Path $StackArchivePath -Algorithm SHA256).Hash
$hashUrl = $StackReleasesJson.assets | Where-Object { $_.name.EndsWith("$DownloadFilePattern.sha256") } | Select-Object -ExpandProperty "browser_download_url" -First 1
$externalHash = (Invoke-RestMethod -Uri $hashURL).ToString().Split("`n").Where({ $_ -ilike "*$DownloadFilePattern*" }).Split(' ')[0]
Use-ChecksumComparison $fileHash $externalHash
#endregion

Write-Host "Expand stack archive"
Extract-7Zip -Path $StackArchivePath -DestinationPath $DestinationPath

New-Item -Name "x64.complete" -Path $StackToolcachePath

Add-MachinePathItem -PathItem $DestinationPath

Invoke-PesterTests -TestFile "Tools" -TestName "Stack"
