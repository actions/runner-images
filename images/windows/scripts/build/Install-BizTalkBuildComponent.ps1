################################################################################
##  File:  Install-BizTalkBuildComponent.ps1
##  Desc:  Install BizTalk Project Build Component
################################################################################

$downloadUrl = "https://aka.ms/BuildComponentSetup.EN"
$signatureThumbprint = "8740DF4ACB749640AD318E4BE842F72EC651AD80"

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
    -ExpectedSignature $signatureThumbprint
Install-Binary `
    -LocalPath "$setupPath\BuildComponentSetup.msi" `
    -ExtraInstallArgs ("/l*v", "$setupPath\buildComponentSetup.log") `
    -ExpectedSignature $signatureThumbprint

Invoke-PesterTests -TestFile "BizTalk" -TestName "BizTalk Build Component Setup"
