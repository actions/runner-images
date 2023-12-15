################################################################################
##  File:  Install-NET48-devpack.ps1
##  Desc:  Install .NET 4.8 devpack
##  Supply chain security: checksum validation
################################################################################

# .NET 4.8 Dev pack
Install-Binary `
    -Url 'https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0307177e14752e359fde5423ab583e43/ndp48-devpack-enu.exe' `
    -InstallArgs @("Setup", "/passive", "/norestart") `
    -ExpectedSHA256Sum '0A7AC4A9B44CED6BB7A0EBF3AD9BA29F60BD4D3BEB2047E19F4D8749DE61F5AC'

Invoke-PesterTests -TestFile "Tools" -TestName "NET48"
