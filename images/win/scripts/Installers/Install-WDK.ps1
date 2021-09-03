################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Requires Windows SDK with the same version number as the WDK
if (Test-IsWin19)
{
    $winSdkUrl = "https://go.microsoft.com/fwlink/?linkid=2166460"
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2166289"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\VS2019\WDK.vsix"
    $VSver = "2019"
}
elseif (Test-IsWin16)
{
    $winSdkUrl = "https://go.microsoft.com/fwlink/p/?LinkID=2023014"
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2026156"
    $FilePath = "C:\Program Files (x86)\Windows Kits\10\Vsix\WDK.vsix"
    $VSver = "2017"
}
else
{
    throw "Invalid version of Visual Studio is found. Either 2017 or 2019 are required"
}

$argumentList = ("/features", "+", "/quiet")

if (Test-IsWin19)
{
    # Download WDK ISO file
    $isoPath = Start-DownloadWithRetry -Url $winSdkUrl -Name winsdk.iso
    $diskImage = Mount-DiskImage -ImagePath $isoPath
    $driveLetter = ($diskImage | Get-Volume).DriveLetter
    $filePath = Join-Path "${driveLetter}:\" "winsdksetup.exe"
    
    # `winsdksetup.exe /features + /quiet` installs all features without showing the GUI
    Install-Binary -FilePath $filePath -ArgumentList $argumentList
    
    # Dismount ISO
    Dismount-DiskImage -DevicePath $diskImage.DevicePath | Out-Null
}

if (Test-IsWind16)
{
    # `winsdksetup.exe /features + /quiet` installs all features without showing the GUI
    Install-Binary -Url $winSdkUrl -Name "winsdksetup.exe" -ArgumentList $argumentList
}

# `wdksetup.exe /features + /quiet` installs all features without showing the GUI
Install-Binary -Url $wdkUrl -Name "wdksetup.exe" -ArgumentList $argumentList

# Need to install the VSIX to get the build targets when running VSBuild
Install-VsixExtension -FilePath $FilePath -Name "WDK.vsix" -VSversion $VSver -InstallOnly

Invoke-PesterTests -TestFile "WDK"
