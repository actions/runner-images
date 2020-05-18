################################################################################
##  File:  Install-Stack.ps1
##  Desc:  Install Stack for Windows
################################################################################

Write-Host "Get the latest Stack version..."
$StackReleasesJson = Invoke-RestMethod "https://api.github.com/repos/commercialhaskell/stack/releases/latest"
$DownloadFilePattern = "windows-x86_64.zip"
$DownloadUrl = $StackReleasesJson.assets | Where-Object { $_.name.EndsWith($DownloadFilePattern) } | Select-Object -ExpandProperty "browser_download_url" -First 1

Write-Host "Download stack archive"
$DestinationPath = Join-Path $Env:AGENT_TOOLSDIRECTORY "stack\x64"
$StackArchivePath = Start-DownloadWithRetry -Url $DownloadUrl

Write-Host "Expand stack archive"
Extract-7Zip -Path $StackArchivePath -DestinationPath $DestinationPath

New-Item -Name "x64.complete" -Path $DestinationPath

Add-MachinePathItem -PathItem $DestinationPath