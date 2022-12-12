################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
################################################################################
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# Install the latest version of Git for Windows
$gitReleases = Invoke-RestMethod "https://api.github.com/repos/git-for-windows/git/releases/latest"
[string]$downloadUrl = $gitReleases.assets.browser_download_url -match "Git-.+-64-bit.exe"

$installerFile = Split-Path $downloadUrl -Leaf
Install-Binary  -Url $downloadUrl `
                -Name $installerFile `
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

# Install hub with --ignore-dependencies option to prevent the installation of the git package. 
# See details in https://github.com/actions/runner-images/issues/2375
Choco-Install -PackageName hub -ArgumentList "--ignore-dependencies"

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

# Add to PATH
Add-MachinePathItem "C:\Program Files\Git\bin"

# Add well-known SSH host keys to ssh_known_hosts
ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t rsa ssh.dev.azure.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

Invoke-PesterTests -TestFile "Git"
Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Hub CLI"
