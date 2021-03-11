################################################################################
##  File:  Install-zstd.ps1
##  Desc:  Install zstd
################################################################################

Write-Host "Download Latest zstd-win64 archive"
$url = "https://api.github.com/repos/facebook/zstd/releases/latest"
# Explicitly set type to string since match returns array by default
[System.String] $zstdLatest = (Invoke-RestMethod -Uri $url).assets.browser_download_url -match "zstd-.+-win64.zip$"
$zstdArchivePath = Start-DownloadWithRetry -Url $zstdLatest -Name "zstd-win64.zip"

Write-Host "Expand zstd-win64 archive"
$zstdPath = "C:\tools\zstd"
New-Item -Path $zstdPath -ItemType Directory -Force
Extract-7Zip -Path $zstdArchivePath -DestinationPath $zstdPath

# Add zstd-win64 to PATH
Add-MachinePathItem $zstdPath

Invoke-PesterTests -TestFile "Tools" -TestName "Zstd"
