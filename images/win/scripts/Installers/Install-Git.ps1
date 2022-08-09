################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
################################################################################
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# Install git
Choco-Install -PackageName git -ArgumentList '--installargs="/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /o:PathOption=CmdTools /o:BashTerminalOption=ConHost /o:EnableSymlinks=Enabled /COMPONENTS=gitlfs"'

Update-SessionEnvironment

git config --system --add safe.directory "*"

# Install hub
Choco-Install -PackageName hub

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

# Add to PATH
Add-MachinePathItem "C:\Program Files\Git\bin"

# Add well-known SSH host keys to ssh_known_hosts
ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t rsa ssh.dev.azure.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

Invoke-PesterTests -TestFile "Git"
Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Hub CLI"
