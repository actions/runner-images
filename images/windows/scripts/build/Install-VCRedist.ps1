################################################################################
##  File:  Install-VCRedist.ps1
##  Desc:  Install Visual C++ Redistributable
################################################################################

$baseUrl = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC"
$argumentList = ("/install", "/quiet", "/norestart")
$signatureThumbrint = "ABDCA79AF9DD48A0EA702AD45260B3C03093FB4B"

Install-Binary `
  -Url "${baseUrl}/vcredist_x86.exe" `
  -InstallArgs $argumentList `
  -ExpectedSignature $signatureThumbrint

Install-Binary `
  -Url "${baseUrl}/vcredist_x64.exe" `
  -InstallArgs $argumentList `
  -ExpectedSignature $signatureThumbrint

Invoke-PesterTests -TestFile "Tools" -TestName "VCRedist"
