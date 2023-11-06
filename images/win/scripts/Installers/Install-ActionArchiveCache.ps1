################################################################################
##  File:       Install-ActionArchiveCache.ps1
##  Desc:       Download latest release from https://github.com/actions/action-versions
##              and un-zip to C:\actionarchivecache
##  Maintainer: #actions-runtime and @TingluoHuang
################################################################################

if (-not (Test-Path $env:ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE))
{
    Write-Host "Creating action archive cache folder"
    New-Item -ItemType Directory -Path $env:ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE | Out-Null
}

$downloadUrl = Get-GitHubPackageDownloadUrl -RepoOwner "actions" -RepoName "action-versions" -Version "latest" -UrlFilter "*/v{Version}/action-versions.zip"
Write-Host "Download Latest action-versions archive from $downloadUrl"
$actionVersionsArchivePath = Start-DownloadWithRetry -Url $downloadUrl -Name "action-versions.zip"

Write-Host "Expand action-versions archive"
Extract-7Zip -Path $actionVersionsArchivePath -DestinationPath $env:ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE

Invoke-PesterTests -TestFile "ActionArchiveCache"
