################################################################################
##  File:  Install-UiPathCLI.ps1
##  Desc:  Install UiPath CLI for Windows
################################################################################

$DownloadFilePath = "C:\uipcli.zip"
$InstallationPath = "C:\Program Files\UiPathCLI"

New-Item -Path "C:\Program Files" -ItemType "directory" -Name "UiPathCLI";
Invoke-WebRequest "https://www.myget.org/F/uipath-dev/api/v2/package/UiPath.CLI/1.0.7985.19721" -OutFile $DownloadFilePath;
Expand-Archive -LiteralPath $DownloadFilePath -DestinationPath $InstallationPath;

Remove-Item $DownloadFilePath
$UipcliPath = $InstallationPath + "\lib\net461"

Write-Host "uipcli path: " $UipcliPath

# Add to PATH
Add-MachinePathItem $UipcliPath