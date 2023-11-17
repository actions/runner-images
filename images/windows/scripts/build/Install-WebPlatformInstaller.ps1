################################################################################
##  File:  Install-WebPI.ps1
##  Desc:  Install WebPlatformInstaller
################################################################################

# Download and install WebPlatformInstaller
$webPlatformInstallerFile = "WebPlatformInstaller_x64_en-US.msi"
$webPlatformInstallerUrl = "http://go.microsoft.com/fwlink/?LinkId=287166"
$webPlatformInstallerSignatureThumbprint = "C3A3D43788E7ABCD287CB4F5B6583043774F99D2"
Install-Binary -Url $webPlatformInstallerUrl -Name $webPlatformInstallerFile -ExpectedSignature $webPlatformInstallerSignatureThumbprint

Invoke-PesterTests -TestFile "Tools" -TestName "WebPlatformInstaller"
