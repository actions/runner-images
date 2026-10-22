################################################################################
##  File:  Install-Ninja.ps1
##  Desc:  Install Ninja build system (ARM64 only; x64 is installed via Choco)
################################################################################

$installDir = "C:\Tools\Ninja"

Write-Host "Resolve Ninja latest ARM64 download URL"
$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repository "ninja-build/ninja" `
    -Version "latest" `
    -UrlMatchPattern "ninja-winarm64.zip"

Write-Host "Download Ninja ARM64 archive"
$zipPath = Invoke-DownloadWithRetry $downloadUrl

Write-Host "Install Ninja to $installDir"
New-Item -ItemType Directory -Path $installDir -Force | Out-Null
Expand-7ZipArchive -Path $zipPath -DestinationPath $installDir

Add-MachinePathItem $installDir
Update-Environment

Invoke-PesterTests -TestFile "Tools" -TestName "Ninja"
