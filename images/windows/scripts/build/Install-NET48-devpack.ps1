################################################################################
##  File:  Install-NET48-devpack.ps1
##  Desc:  Install .NET 4.8 devpack
################################################################################

# .NET 4.8 Dev pack
Install-Binary `
    -Url 'https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0307177e14752e359fde5423ab583e43/ndp48-devpack-enu.exe' `
    -InstallArgs @("Setup", "/passive", "/norestart") `
    -ExpectedSignature 'C82273A065EC470FB1EBDE846A91E6FFB29E9C12'

Invoke-PesterTests -TestFile "Tools" -TestName "NET48"
