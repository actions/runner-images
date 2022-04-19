################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
################################################################################

# Install git
# Temporary hardcode version 2.35.1 due to the issue with the actions\checkout https://github.com/actions/checkout/issues/760
Choco-Install -PackageName git -ArgumentList '--version', "2.35.1.2", '--installargs="/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /o:PathOption=CmdTools /o:BashTerminalOption=ConHost /o:EnableSymlinks=Enabled /COMPONENTS=gitlfs"'

# Install hub
Choco-Install -PackageName hub

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

# Add to PATH
Add-MachinePathItem "C:\Program Files\Git\bin"

if (Test-IsWin16) {
    $env:Path += ";$env:ProgramFiles\Git\usr\bin\"
}

# Add well-known SSH host keys to ssh_known_hosts
ssh-keyscan -t rsa github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t rsa ssh.dev.azure.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

Invoke-PesterTests -TestFile "Git"
Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Hub CLI"
