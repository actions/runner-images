################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Requires Windows SDK with the same version number as the WDK
if (Test-IsWin22) {
    # SDK available through Visual Studio
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2196230"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\VS2022\*\WDK.vsix"
    $VSver = "2022"
} elseif (Test-IsWin19) {
    $winSdkUrl = "https://go.microsoft.com/fwlink/?linkid=2173743"
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2166289"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\VS2019\WDK.vsix"
    $VSver = "2019"
} else {
    throw "Invalid version of Visual Studio is found. Either 2017,2019 or 2022 are required"
}

$argumentList = ("/features", "+", "/quiet")

if (Test-IsWin19) {
    # `winsdksetup.exe /features + /quiet` installs all features without showing the GUI
    Install-Binary -Url $winSdkUrl -Name "winsdksetup.exe" -ArgumentList $argumentList
}

# `wdksetup.exe /features + /quiet` installs all features without showing the GUI
Install-Binary -Url $wdkUrl -Name "wdksetup.exe" -ArgumentList $argumentList

# Need to install the VSIX to get the build targets when running VSBuild
# Windows 2022 - Skip installation due to a regression
# https://docs.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk
if (Test-IsWin19) {
    $FilePath = Resolve-Path -Path $FilePath
    Install-VsixExtension -FilePath $FilePath -Name "WDK.vsix" -VSversion $VSver -InstallOnly
}

Invoke-PesterTests -TestFile "WDK"
