################################################################################
##  File:  Install-GVFS.ps1
##  Desc:  Install GVFS
################################################################################

$url = "https://api.github.com/repos/microsoft/VFSForGit/releases/latest"
# Explicitly set type to string since match returns array by default
[System.String] $gvfsLatest = (Invoke-RestMethod -Uri $url).assets.browser_download_url -match "SetupGVFS.+\.exe$"
$gvfsInstallerPath = Start-DownloadWithRetry -Url $gvfsLatest -Name "SetupGVFS.exe"

# Install GVFS
# Start-Process waits on the entire process tree but Wait-Process only waits on the initiating process
# GVFS.Service.UI.exe
$env:GVFS_UNATTENDED = "1"
$argList = "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP-", "/CLOSEAPPLICATIONS", "/RESTARTAPPLICATIONS", "/SUPPRESSMSGBOXES"
Start-Process $gvfsInstallerPath -ArgumentList $argList -PassThru | Wait-Process

Invoke-PesterTests -TestFile "Git" -TestName "GVFS"
