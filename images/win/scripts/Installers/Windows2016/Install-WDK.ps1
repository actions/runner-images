################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Version: 10.0.17763.0
# Update Validate-WDK.ps1 if the version changes!
# There doesn't seem to be any way to check the version programmatically

# Requires Windows SDK with the same version number as the WDK
$winSdkUrl = "https://go.microsoft.com/fwlink/p/?LinkID=2023014"
$wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2026156"

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
Write-Host "Installing WDK.vsix"
$process = Start-Process `
    -FilePath "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\VSIXInstaller.exe" `
    -ArgumentList ("/quiet", '"C:\Program Files (x86)\Windows Kits\10\Vsix\WDK.vsix"') `
    -Wait `
    -PassThru

$exitCode = $process.ExitCode

if ($exitCode -eq 0 -or $exitCode -eq 1001) # 1001 means the extension is already installed
{
    Write-Host "WDK.vsix installed successfully"
}
else
{
    Write-Host "Unsuccessful exit code returned by the installation process: $exitCode."
}

exit $exitCode
