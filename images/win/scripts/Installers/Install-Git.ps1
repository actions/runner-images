################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
################################################################################

# Install git
Choco-Install -PackageName git -ArgumentList '--installargs="/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /o:PathOption=CmdTools /o:BashTerminalOption=ConHost /o:EnableSymlinks=Enabled /COMPONENTS=gitlfs"'

# Install hub
Choco-Install -PackageName hub

# Install GVFS
$url = "https://api.github.com/repos/microsoft/VFSForGit/releases/latest"
[System.String] $gvfsLatest = (Invoke-RestMethod -Uri $url).assets.browser_download_url -match "SetupGVFS.+\.exe$"
$gvfsInstallerPath = Start-DownloadWithRetry -Url $gvfsLatest -Name "SetupGVFS.exe"

# Start-Process waits on the entire process tree but Wait-Process only waits on the initiating process(GVFS.Service.UI.exe)
$env:GVFS_UNATTENDED = "1"
$argList = "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP-", "/CLOSEAPPLICATIONS", "/RESTARTAPPLICATIONS", "/SUPPRESSMSGBOXES"
Start-Process $gvfsInstallerPath -ArgumentList $argList -PassThru | Wait-Process

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
