################################################################################
##  File:  Install-BizTalkBuildComponent.ps1
##  Desc:  Install BizTalk Project Build Component
################################################################################

$BuildComponentUri = "https://aka.ms/BuildComponentSetup.EN"
$BuildComponentSignatureThumbprint = "8740DF4ACB749640AD318E4BE842F72EC651AD80"

Write-Host "Downloading BizTalk Project Build Component archive..."
$setupZipFile = Start-DownloadWithRetry -Url $BuildComponentUri -Name "BuildComponentSetup.EN.zip"

$setupPath = Join-Path $env:TEMP "BizTalkBuildComponent"
if (-not (Test-Path -Path $setupPath)) {
    $null = New-Item -Path $setupPath -ItemType Directory -Force
}
Extract-7Zip -Path $setupZipFile -DestinationPath $setupPath

Write-Host "Installing BizTalk Project Build Component..."
Install-Binary `
    -LocalPath "$setupPath\Bootstrap.msi" `
    -ExtraInstallArgs ("/l*v", "$setupPath\bootstrap.log") `
    -ExpectedSignature $BuildComponentSignatureThumbprint
Install-Binary `
    -LocalPath "$setupPath\BuildComponentSetup.msi" `
    -ExtraInstallArgs ("/l*v", "$setupPath\buildComponentSetup.log") `
    -ExpectedSignature $BuildComponentSignatureThumbprint

Remove-Item $setupZipFile
Remove-Item $setupPath -Recurse -Force

Invoke-PesterTests -TestFile "BizTalk" -TestName "BizTalk Build Component Setup"
