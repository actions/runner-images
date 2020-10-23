################################################################################
##  File:  Install-OpenSSH.ps1
##  Desc:  Install OpenSSH-Win64
################################################################################

Write-Host "Download Latest OpenSSH-Win64 archive"
$url = 'https://api.github.com/repos/PowerShell/Win32-OpenSSH/releases/latest'
$name = 'OpenSSH-Win64.zip'
# Explicitly set type to string since match returns array by default
[string]$opensshLatest = (Invoke-RestMethod -Uri $url).assets.browser_download_url -match $name
$opensshArchivePath = Start-DownloadWithRetry -Url $opensshLatest -Name $name
Write-Host "Expand OpenSSH-Win64 archive"
Extract-7Zip -Path $opensshArchivePath -DestinationPath $env:ProgramFiles