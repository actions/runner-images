################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Requires Windows SDK with the same version number as the WDK

Import-Module -Name ImageHelpers -Force

if(Test-IsWin19)
{
    $winSdkUrl = "https://go.microsoft.com/fwlink/p/?linkid=2083338"
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2085767"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\VS2019\WDK.vsix"
    $VSver = "2019"
}
else
{
    $winSdkUrl = "https://go.microsoft.com/fwlink/p/?LinkID=2023014"
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2026156"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\WDK.vsix"
    $VSver = "2017"
}


# `winsdksetup.exe /features + /quiet` installs all features without showing the GUI
$sdkExitCode = Install-EXE -Url $winSdkUrl -Name "winsdksetup.exe" -ArgumentList ("/features", "+", "/quiet")

if ($sdkExitCode -ne 0)
{
    Write-Host "Failed to install the Windows SDK."
    exit $sdkExitCode
}

# `wdksetup.exe /features + /quiet` installs all features without showing the GUI
$wdkExitCode = Install-EXE -Url $wdkUrl -Name "wdksetup.exe" -ArgumentList ("/features", "+", "/quiet")

if ($wdkExitCode -ne 0)
{
    Write-Host "Failed to install the Windows Driver Kit."
    exit $wdkExitCode
}

# Need to install the VSIX to get the build targets when running VSBuild
Install-VsixExtension -FilePath $FilePath -Name "WDK.vsix" -VSversion $VSver -InstallOnly
