################################################################################
##  File:  Install-Docker-WinCred.ps1
##  Desc:  Install Docker credential helper.
##  Supply chain security: checksum validation
################################################################################

#region functions
function Get-DockerWincredHash {
    Param (
        [Parameter(Mandatory = $True)]
        [string] $Release
    )

    $hashURL = "https://github.com/docker/docker-credential-helpers/releases/download/${Release}/checksums.txt"
    (Invoke-RestMethod -Uri $hashURL).ToString().Split("`n").Where({ $_ -ilike "*docker-credential-wincred-${Release}.windows-amd64.exe*" }).Split(' ')[0]
}
#endregion

Write-Host "Install docker-wincred"
$dockerCredLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/docker/docker-credential-helpers/releases/latest"
$dockerCredDownloadUrl = $dockerCredLatestRelease.assets.browser_download_url -match "docker-credential-wincred-.+\.exe" | Select-Object -First 1
Start-DownloadWithRetry -Url $dockerCredDownloadUrl -DownloadPath "C:\Windows\System32" -Name "docker-credential-wincred.exe"

#region Supply chain security
$distributor_file_hash = Get-DockerWincredHash -Release $dockerCredLatestRelease.name
$local_file_hash = (Get-FileHash -Path 'C:\Windows\System32\docker-credential-wincred.exe' -Algorithm SHA256).Hash

if ($local_file_hash -ne $distributor_file_hash) {
    Write-Host "hash must be equal to: ${distributor_file_hash}"
    Write-Host "actual hash is: ${local_file_hash}"
    throw 'Checksum verification failed, please rerun install'
}
#endregion

Invoke-PesterTests -TestFile "Docker" -TestName "DockerWinCred"
