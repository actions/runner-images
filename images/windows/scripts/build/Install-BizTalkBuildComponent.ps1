################################################################################
##  File:  Install-BizTalkBuildComponent.ps1
##  Desc:  Install BizTalk Project Build Component
################################################################################

$downloadUrl = "https://aka.ms/BuildComponentSetup.EN"

Write-Host "Downloading BizTalk Project Build Component archive..."
$zipFile = Invoke-DownloadWithRetry $downloadUrl

$setupPath = Join-Path $env:TEMP_DIR "BizTalkBuildComponent"
if (-not (Test-Path -Path $setupPath)) {
    New-Item -Path $setupPath -ItemType Directory -Force | Out-Null
}
Expand-7ZipArchive -Path $zipFile -DestinationPath $setupPath

Write-Host "Installing BizTalk Project Build Component..."
Install-Binary `
    -LocalPath "$setupPath\Bootstrap.msi" `
    -ExtraInstallArgs ("/l*v", "$setupPath\bootstrap.log") `
    -ExpectedSubject $(Get-MicrosoftPublisher)
Install-Binary `
    -LocalPath "$setupPath\BuildComponentSetup.msi" `
    -ExtraInstallArgs ("/l*v", "$setupPath\buildComponentSetup.log") `
    -ExpectedSubject $(Get-MicrosoftPublisher)

Invoke-PesterTests -TestFile "BizTalk" -TestName "BizTalk Build Component Setup"
