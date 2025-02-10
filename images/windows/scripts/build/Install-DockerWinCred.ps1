################################################################################
##  File:  Install-Docker-WinCred.ps1
##  Desc:  Install Docker credential helper.
##  Supply chain security: checksum validation
################################################################################

Write-Host "Install docker-wincred"
$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "docker/docker-credential-helpers" `
    -Version "latest" `
    -UrlMatchPattern "docker-credential-wincred-*amd64.exe"
$binaryPath = Invoke-DownloadWithRetry -Url $downloadUrl -Path "C:\Windows\System32\docker-credential-wincred.exe"

#region Supply chain security
$binaryName = Split-Path $downloadUrl -Leaf
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url ($downloadUrl -replace $binaryName, "checksums.txt") `
    -FileName $binaryName
Test-FileChecksum -Path $binaryPath -ExpectedSHA256Sum $externalHash
#endregion

Invoke-PesterTests -TestFile "Docker" -TestName "DockerWinCred"
