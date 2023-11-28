################################################################################
##  File:       Install-ActionsCache.ps1
##  Desc:       Downloads latest release from https://github.com/actions/action-versions
##  Maintainer: #actions-runtime and @TingluoHuang
################################################################################

if (-not (Test-Path $env:ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE)) {
    Write-Host "Creating action archive cache folder"
    New-Item -ItemType Directory -Path $env:ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE | Out-Null
}

$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "actions/action-versions" `
    -Version "latest" `
    -Asset "action-versions.zip"

Write-Host "Download Latest action-versions archive from $downloadUrl"
$actionVersionsArchivePath = Start-DownloadWithRetry -Url $downloadUrl -Name "action-versions.zip"

Write-Host "Expand action-versions archive"
Expand-7ZipArchive -Path $actionVersionsArchivePath -DestinationPath $env:ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE

Invoke-PesterTests -TestFile "ActionArchiveCache"
