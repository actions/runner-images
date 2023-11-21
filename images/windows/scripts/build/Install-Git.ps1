################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
##  Supply chain security: Git - checksum validation, Hub CLI - managed by package manager
################################################################################
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# Install the latest version of Git for Windows
$repoURL = "https://api.github.com/repos/git-for-windows/git/releases/latest"
$gitReleases = Invoke-RestMethod $repoURL
$downloadUrl = $gitReleases.assets.browser_download_url -match "Git-.+-64-bit.exe" | Select-Object -First 1

$installerFile = Split-Path $downloadUrl -Leaf
$externalHash = Get-HashFromGitHubReleaseBody -Url $RepoURL -FileName $installerFile

Install-Binary `
    -Url $downloadUrl `
    -InstallArgs @(`
        "/VERYSILENT", `
        "/NORESTART", `
        "/NOCANCEL", `
        "/SP-", `
        "/CLOSEAPPLICATIONS", `
        "/RESTARTAPPLICATIONS", `
        "/o:PathOption=CmdTools", `
        "/o:BashTerminalOption=ConHost", `
        "/o:EnableSymlinks=Enabled", `
        "/COMPONENTS=gitlfs") `
    -ExpectedSHA256Sum $externalHash

Update-SessionEnvironment

git config --system --add safe.directory "*"

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

# Add to PATH
Add-MachinePathItem "C:\Program Files\Git\bin"

# Add well-known SSH host keys to ssh_known_hosts
ssh-keyscan -t rsa, ecdsa, ed25519 github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t rsa ssh.dev.azure.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

Invoke-PesterTests -TestFile "Git"
