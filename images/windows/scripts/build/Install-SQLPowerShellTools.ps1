################################################################################
##  File:  Install-SQLPowerShellTools.ps1
##  Desc:  Install SQL PowerShell tool
################################################################################

$baseUrl = "https://download.microsoft.com/download/B/1/7/B1783FE9-717B-4F78-A39A-A2E27E3D679D/ENU/x64"
$signatureThumbrint = "9ACA9419E53D3C9E56396DD2335FF683A8B0B8F3"

# install required MSIs
Install-Binary `
    -Url "${baseUrl}/SQLSysClrTypes.msi" `
    -ExpectedSignature $signatureThumbrint

Install-Binary `
    -Url "${baseUrl}/SharedManagementObjects.msi" `
    -ExpectedSignature $signatureThumbrint

Install-Binary `
    -Url "${baseUrl}/PowerShellTools.msi" `
    -ExpectedSignature $signatureThumbrint
