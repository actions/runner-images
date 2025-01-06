################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Requires Windows SDK with the same version number as the WDK
if (Test-IsWin19) {
    # Install all features without showing the GUI using winsdksetup.exe
    Install-Binary -Type EXE `
        -Url 'https://go.microsoft.com/fwlink/?linkid=2173743' `
        -InstallArgs @("/features", "+", "/quiet") `
        -ExpectedSignature '44796EB5BD439B4BFB078E1DC2F8345AE313CBB1'

    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2166289"
    $wdkSignatureThumbprint = "914A09C2E02C696AF394048BCB8D95449BCD5B9E"
    $wdkExtensionPath = "C:\Program Files (x86)\Windows Kits\10\Vsix\VS2019\WDK.vsix"
} elseif (Test-IsWin22) {
    # SDK is available through Visual Studio
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2294834"
    $wdkSignatureThumbprint = "7920AC8FB05E0FFFE21E8FF4B4F03093BA6AC16E"
} else {
    throw "Invalid version of Visual Studio is found. Either 2019 or 2022 are required"
}

# Install all features without showing the GUI using wdksetup.exe
Install-Binary -Type EXE `
    -Url $wdkUrl `
    -InstallArgs @("/features", "+", "/quiet") `
    -ExpectedSignature $wdkSignatureThumbprint

if (Test-IsWin19){
    # Need to install the VSIX to get the build targets when running VSBuild
    Install-VSIXFromFile (Resolve-Path -Path $wdkExtensionPath)
}
Invoke-PesterTests -TestFile "WDK"
