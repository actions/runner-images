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
ssh-keyscan -t rsa, ecdsa, ed25519 github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t rsa ssh.dev.azure.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

Invoke-PesterTests -TestFile "Git"
