################################################################################
##  File:  Install-SQLPowerShellTools.ps1
##  Desc:  Install SQL PowerShell tool
################################################################################

$baseUrl = "https://download.microsoft.com/download/B/1/7/B1783FE9-717B-4F78-A39A-A2E27E3D679D/ENU/x64"

# install required MSIs
Install-Binary `
    -Url "${baseUrl}/SQLSysClrTypes.msi" `
    -ExpectedSubject $(Get-MicrosoftPublisher)

Install-Binary `
    -Url "${baseUrl}/SharedManagementObjects.msi" `
    -ExpectedSubject $(Get-MicrosoftPublisher)

Install-Binary `
    -Url "${baseUrl}/PowerShellTools.msi" `
    -ExpectedSubject $(Get-MicrosoftPublisher)
