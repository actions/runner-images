################################################################################
##  File:  Install-NET48.ps1
##  Desc:  Install .NET 4.8
##  Supply chain security: checksum validation
################################################################################

# .NET 4.8 Dev pack
Install-Binary `
    -Url 'https://download.visualstudio.microsoft.com/download/pr/2d6bb6b2-226a-4baa-bdec-798822606ff1/8494001c276a4b96804cde7829c04d7f/ndp48-x86-x64-allos-enu.exe' `
    -InstallArgs @("Setup", "/passive", "/norestart") `
    -ExpectedSHA256Sum 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855'
