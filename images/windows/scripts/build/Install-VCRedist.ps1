################################################################################
##  File:  Install-VCRedist.ps1
##  Desc:  Install Visual C++ Redistributable
##  Supply chain security: checksum validation
################################################################################

$baseUrl = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC"
$argumentList = ("/install", "/quiet", "/norestart")

Install-Binary `
    -Url "${baseUrl}/vcredist_x86.exe" `
    -InstallArgs $argumentList `
    -ExpectedSHA256Sum '99DCE3C841CC6028560830F7866C9CE2928C98CF3256892EF8E6CF755147B0D8'

Install-Binary `
    -Url "${baseUrl}/vcredist_x64.exe" `
    -InstallArgs $argumentList `
    -ExpectedSHA256Sum 'F3B7A76D84D23F91957AA18456A14B4E90609E4CE8194C5653384ED38DADA6F3'

Invoke-PesterTests -TestFile "Tools" -TestName "VCRedist"
