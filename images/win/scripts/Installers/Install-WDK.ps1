################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Requires Windows SDK with the same version number as the WDK
if (Test-IsWin22) {
    # SDK available through Visual Studio
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2196230"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\VS2022\*\WDK.vsix"
    $wdkSignatureThumbprint = "DE2396BCEB7E3CD13BF3D370424A560F97CABDE7"
} elseif (Test-IsWin19) {
    $winSdkUrl = "https://go.microsoft.com/fwlink/?linkid=2173743"
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2166289"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\VS2019\WDK.vsix"
    $wdkSignatureThumbprint = "914A09C2E02C696AF394048BCB8D95449BCD5B9E"
    $winSdkSignatureThumbprint = "44796EB5BD439B4BFB078E1DC2F8345AE313CBB1"
} else {
    throw "Invalid version of Visual Studio is found. Either 2019 or 2022 are required"
}

$argumentList = ("/features", "+", "/quiet")

if (Test-IsWin19) {
    # `winsdksetup.exe /features + /quiet` installs all features without showing the GUI
    Install-Binary -Url $winSdkUrl -Name "winsdksetup.exe" -ArgumentList $argumentList -ExpectedSignature $winSdkSignatureThumbprint
}

# `wdksetup.exe /features + /quiet` installs all features without showing the GUI
Install-Binary -Url $wdkUrl -Name "wdksetup.exe" -ArgumentList $argumentList -ExpectedSignature $wdkSignatureThumbprint

# Need to install the VSIX to get the build targets when running VSBuild
$FilePath = Resolve-Path -Path $FilePath
Install-VsixExtension -FilePath $FilePath -Name "WDK.vsix" -InstallOnly

Invoke-PesterTests -TestFile "WDK"
