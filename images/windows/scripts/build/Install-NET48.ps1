################################################################################
##  File:  Install-NET48.ps1
##  Desc:  Install .NET 4.8
################################################################################

# .NET 4.8 Dev pack
Install-Binary `
    -Url 'https://download.visualstudio.microsoft.com/download/pr/2d6bb6b2-226a-4baa-bdec-798822606ff1/8494001c276a4b96804cde7829c04d7f/ndp48-x86-x64-allos-enu.exe' `
    -InstallArgs @("Setup", "/passive", "/norestart") `
    -ExpectedSignature 'ABDCA79AF9DD48A0EA702AD45260B3C03093FB4B'
