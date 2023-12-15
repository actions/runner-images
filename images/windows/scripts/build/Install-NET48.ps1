################################################################################
##  File:  Install-NET48.ps1
##  Desc:  Install .NET 4.8
##  Supply chain security: checksum validation
################################################################################

# .NET 4.8 Dev pack
Install-Binary `
    -Url 'https://download.visualstudio.microsoft.com/download/pr/2d6bb6b2-226a-4baa-bdec-798822606ff1/8494001c276a4b96804cde7829c04d7f/ndp48-x86-x64-allos-enu.exe' `
    -InstallArgs @("Setup", "/passive", "/norestart") `
    -ExpectedSHA256Sum '68C9986A8DCC0214D909AA1F31BEE9FB5461BB839EDCA996A75B08DDFFC1483F'
