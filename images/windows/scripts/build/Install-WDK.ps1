################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

if (Test-IsWin22) {
    # SDK is available through Visual Studio
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2294834"
    $wdkSignatureThumbprint = "7920AC8FB05E0FFFE21E8FF4B4F03093BA6AC16E"
} else {
    throw "Invalid version of Visual Studio is found. 2022 is required"
}

# Install all features without showing the GUI using wdksetup.exe
Install-Binary -Type EXE `
    -Url $wdkUrl `
    -InstallArgs @("/features", "+", "/quiet") `
    -ExpectedSignature $wdkSignatureThumbprint

Invoke-PesterTests -TestFile "WDK"
