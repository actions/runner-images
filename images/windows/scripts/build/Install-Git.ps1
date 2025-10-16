################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
##  Supply chain security: Git - checksum validation, Hub CLI - managed by package manager
################################################################################

# Install the latest version of Git for Windows

$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "git-for-windows/git" `
    -Version "latest" `
    -UrlMatchPattern "Git-*-64-bit.exe"

$externalHash = Get-ChecksumFromGithubRelease `
    -Repo "git-for-windows/git" `
    -Version "latest" `
    -FileName (Split-Path $downloadUrl -Leaf) `
    -HashType "SHA256"

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

Update-Environment

git config --system --add safe.directory "*"
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to configure safe.directory for Git with exit code $LASTEXITCODE"
}

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", "Machine")

# Add to PATH
Add-MachinePathItem "C:\Program Files\Git\bin"

# Add well-known SSH host keys to ssh_known_hosts
# Write content to the file used by OpenSSH and the version includes with Git
# for Windows
$windowsSSHKnownHosts = "C:\ProgramData\ssh\ssh_known_hosts"
$gitSSHKnownHosts = "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

$sshKeyScan = "C:\Program Files\Git\usr\bin\ssh-keyscan"
$githubHostKeys = &$sshKeyScan -t rsa,ecdsa,ed25519 github.com
$azureHostKeys = &$sshKeyscan -t rsa ssh.dev.azure.com

Set-Content -Encoding ASCII -Path $windowsSSHKnownHosts, $gitSSHKnownHosts -Value $githubHostKeys
Add-Content -Encoding ASCII -Path $windowsSSHKnownHosts, $gitSSHKnownHosts -Value $azureHostKeys

Invoke-PesterTests -TestFile "Git"
