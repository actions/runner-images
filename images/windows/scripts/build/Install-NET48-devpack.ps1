################################################################################
##  File:  Install-NET48-devpack.ps1
##  Desc:  Install .NET 4.8 devpack
################################################################################

# .NET 4.8 Dev pack
$InstallerName = "ndp48-devpack-enu.exe"
$InstallerUrl = "https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0307177e14752e359fde5423ab583e43/${InstallerName}"
$InstallerSignatureThumbprint = "C82273A065EC470FB1EBDE846A91E6FFB29E9C12"
$ArgumentList = ("Setup", "/passive", "/norestart")

Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList -ExpectedSignature $InstallerSignatureThumbprint

Invoke-PesterTests -TestFile "Tools" -TestName "NET48"
