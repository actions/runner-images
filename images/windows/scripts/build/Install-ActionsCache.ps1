################################################################################
##  File:       Install-ActionsCache.ps1
##  Desc:       Downloads latest release from https://github.com/actions/action-versions
##  Maintainer: #actions-runtime and @TingluoHuang
################################################################################

$actionArchiveCache = "C:\actionarchivecache\"

if (-not (Test-Path $actionArchiveCache)) {
    Write-Host "Creating action archive cache folder"
    New-Item -ItemType Directory -Path $actionArchiveCache | Out-Null
}

$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "actions/action-versions" `
    -Version "latest" `
    -Asset "action-versions.zip"

Write-Host "Download Latest action-versions archive from $downloadUrl"
$actionVersionsArchivePath = Invoke-DownloadWithRetry $downloadUrl

Write-Host "Expand action-versions archive"
Expand-7ZipArchive -Path $actionVersionsArchivePath -DestinationPath $actionArchiveCache

[Environment]::SetEnvironmentVariable("ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE", $actionArchiveCache, "Machine")

Invoke-PesterTests -TestFile "ActionArchiveCache"
