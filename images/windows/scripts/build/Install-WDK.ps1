################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Requires Windows SDK with the same version number as the WDK
if (Test-IsWin22-X64) {
    # SDK is available through Visual Studio
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2324617"
} elseif (Test-IsWin11-Arm64) {
    # SDK is available through Visual Studio
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2335869"
} else {
    throw "Invalid version of Visual Studio is found. Windows Server 2022 is required"
}

# Install all features without showing the GUI using wdksetup.exe
Install-Binary -Type EXE `
    -Url $wdkUrl `
    -InstallArgs @("/features", "+", "/quiet") `
    -ExpectedSubject $(Get-MicrosoftPublisher)

Invoke-PesterTests -TestFile "WDK"
