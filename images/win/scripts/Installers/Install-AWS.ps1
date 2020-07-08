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
$env:Path = $env:Path + ";$env:ProgramFiles\Amazon\SessionManagerPlugin\bin"

$sessionMessage = session-manager-plugin
Write-Host "$sessionMessage"
if ($sessionMessage -notmatch "*plugin was installed successfully*") {
    exit 1
}