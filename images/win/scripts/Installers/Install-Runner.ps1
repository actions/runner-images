$runnerDownloadUrl = Get-GitHubPackageDownloadUrl -RepoOwner "Actions" -RepoName "runner" -BinaryName "actions-runner-linux-x64" -Version "latest" -UrlFilter "*{BinaryName}-{Version}.zip"
$fileName = runnerDownloadUrl.Substring($zip.LastIndexOf("/") + 1)
New-Item -Path "C:\ProgramData\runner" -ItemType Directory
$runnerInstallerPath = Start-DownloadWithRetry -Url $runnerDownloadUrl -Name $fileName -DownloadPath "C:\ProgramData\runner"
