################################################################################
##  File:  Install-SQLPowerShellTools.ps1
##  Desc:  Install SQL PowerShell tool
################################################################################

$BaseUrl = "https://download.microsoft.com/download/B/1/7/B1783FE9-717B-4F78-A39A-A2E27E3D679D/ENU/x64"
$SignatureThumbrint = "9ACA9419E53D3C9E56396DD2335FF683A8B0B8F3"

# install required MSIs
$SQLSysClrTypesName = "SQLSysClrTypes.msi"
$SQLSysClrTypesUrl = "${BaseUrl}/${SQLSysClrTypesName}"
Install-Binary -Url $SQLSysClrTypesUrl -Name $SQLSysClrTypesName -ExpectedSignature $SignatureThumbrint

$SharedManagementObjectsName = "SharedManagementObjects.msi"
$SharedManagementObjectsUrl = "${BaseUrl}/${SharedManagementObjectsName}"
Install-Binary -Url $SharedManagementObjectsUrl -Name $SharedManagementObjectsName -ExpectedSignature $SignatureThumbrint

$PowerShellToolsName = "PowerShellTools.msi"
$PowerShellToolsUrl = "${BaseUrl}/${PowerShellToolsName}"
Install-Binary -Url $PowerShellToolsUrl -Name $PowerShellToolsName -ExpectedSignature $SignatureThumbrint
