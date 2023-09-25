# Install vcredist2010
$Vc2010x86Name = "vcredist_x86.exe"
$Vc2010x86URI = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/${Vc2010x86Name}"
$Vc2010x64Name = "vcredist_x64.exe"
$Vc2010x64URI = "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/${Vc2010x64Name}"
$VcSignatureThumbprint = "ABDCA79AF9DD48A0EA702AD45260B3C03093FB4B"
$ArgumentList = ("/install", "/quiet", "/norestart")
Install-Binary -Url $Vc2010x86URI -Name $Vc2010x86Name -ArgumentList $ArgumentList -ExpectedSignature $VcSignatureThumbprint
Install-Binary -Url $Vc2010x64URI -Name $Vc2010x64Name -ArgumentList $ArgumentList -ExpectedSignature $VcSignatureThumbprint

Invoke-PesterTests -TestFile "Tools" -TestName "VCRedist"
