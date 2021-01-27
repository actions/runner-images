################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
################################################################################

# Install git
Choco-Install -PackageName git -ArgumentList '--installargs="/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /o:PathOption=CmdTools /o:BashTerminalOption=ConHost /o:EnableSymlinks=Enabled /COMPONENTS=gitlfs"'

# Install hub
Choco-Install -PackageName hub

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

Add-MachinePathItem "C:\Program Files\Git\bin"

if (Test-IsWin16) {
    $env:Path += ";$env:ProgramFiles\Git\usr\bin\"
}

# Add well-known SSH host keys to ssh_known_hosts
ssh-keyscan -t rsa github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t rsa ssh.dev.azure.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"

Invoke-PesterTests -TestFile "Git" -TestName "Git"
Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Hub CLI"
