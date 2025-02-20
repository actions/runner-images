################################################################################
##  File:  Install-Zstd.ps1
##  Desc:  Install zstd
################################################################################
# Temporarily pin the version
$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "facebook/zstd" `
    -Version "1.5.6" `
    -UrlMatchPattern "zstd-*-win64.zip"
$zstdArchivePath = Invoke-DownloadWithRetry $downloadUrl
$zstdName = [IO.Path]::GetFileNameWithoutExtension($zstdArchivePath)

$toolPath = "C:\tools"
$zstdPath = Join-Path $toolPath zstd
$filesInArchive = 7z l $zstdArchivePath | Out-String

if ($filesInArchive.Contains($zstdName)) {
    Expand-7ZipArchive -Path $zstdArchivePath -DestinationPath $toolPath
    Invoke-ScriptBlockWithRetry -Command {
        Move-Item -Path "${zstdPath}*" -Destination $zstdPath -ErrorAction Stop
    }
} else {
    Expand-7ZipArchive -Path $zstdArchivePath -DestinationPath $zstdPath
}

# Add zstd-win64 to PATH
Add-MachinePathItem $zstdPath

Invoke-PesterTests -TestFile "Tools" -TestName "Zstd"
