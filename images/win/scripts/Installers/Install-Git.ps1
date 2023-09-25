################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
##  Supply chain security: Git - checksum validation, Hub CLI - managed by package manager
################################################################################
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# Install the latest version of Git for Windows
$repoURL = "https://api.github.com/repos/git-for-windows/git/releases/latest"
$gitReleases = Invoke-RestMethod $repoURL
[string]$downloadUrl = $gitReleases.assets.browser_download_url -match "Git-.+-64-bit.exe"
$installerFile = Split-Path $downloadUrl -Leaf
$packagePath = Start-DownloadWithRetry -Url $downloadUrl -Name $installerFile

#region Supply chain security - Git
$fileHash = (Get-FileHash -Path $packagePath -Algorithm SHA256).Hash
$externalHash = Get-HashFromGitHubReleaseBody -Url $RepoURL -FileName $installerFile
Use-ChecksumComparison $fileHash $externalHash
#endregion

Install-Binary  -FilePath $packagePath `
                -ArgumentList (
                    "/VERYSILENT", `
                    "/NORESTART", `
                    "/NOCANCEL", `
                    "/SP-", `
                    "/CLOSEAPPLICATIONS", `
                    "/RESTARTAPPLICATIONS", `
                    "/o:PathOption=CmdTools", `
                    "/o:BashTerminalOption=ConHost", `
                    "/o:EnableSymlinks=Enabled", `
                    "/COMPONENTS=gitlfs")

Update-SessionEnvironment

git config --system --add safe.directory "*"

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

# Add to PATH
Add-MachinePathItem "C:\Program Files\Git\bin"

# Add well-known SSH host keys to ssh_known_hosts
ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t rsa ssh.dev.azure.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

Invoke-PesterTests -TestFile "Git"
