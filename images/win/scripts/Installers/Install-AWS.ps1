################################################################################
##  File:  Install-awscli.ps1
##  Desc:  Install awscli
################################################################################

Choco-Install -PackageName awscli

$env:Path = $env:Path + ";$env:ProgramFiles\Amazon\AWSCLIV2"
if (Get-Command -Name 'aws')
{
    Write-Host 'awscli on path'
}
else
{
    Write-Host 'awscli is not on path'
    exit 1
}

$sessionManagerName = "SessionManagerPluginSetup.exe"
$sessionManagerUrl = "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/$sessionManagerName"
Install-Binary -Url $sessionManagerUrl -Name $sessionManagerName -ArgumentList ("/silent", "/install")
Add-MachinePathItem -PathItem "C:\Program Files\Amazon\SessionManagerPlugin\bin"

$sessionMessage = session-manager-plugin

if ($sessionMessage -Match "*plugin was installed successfully*") {
    Write-Host "$sessionMessage"
    exit 0
} else {
    Write-Host "$sessionMessage"
    exit 1
}