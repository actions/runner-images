################################################################################
##  File:  Install-AWS-CLI-SM.ps1
##  Desc:  Install AWS CLI Session Manager
################################################################################

$sessionManagerName = "SessionManagerPluginSetup.exe"
$sessionManagerUrl = "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/$sessionManagerName"
Install-Binary -Url $sessionManagerUrl -Name $sessionManagerName -ArgumentList ("/silent", "/install")
Add-MachinePathItem -PathItem "C:\Program Files\Amazon\SessionManagerPlugin\bin"
