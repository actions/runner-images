###################################################################################
##  File:  Install-AnalysisExtenstion.ps1
##  Desc:  Install the Microsoft Analysis Services Projects Visual Studio extension
###################################################################################


$extensionUrl = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ProBITools/vsextensions/MicrosoftAnalysisServicesModelingProjects/2.9.5/vspackage"
$extensionDownloadPath = Join-Path $Env:TEMP "Microsoft.DataTools.AnalysisServices.vsix"
Write-Host "Downloading Microsoft.DataTools.AnalysisServices.vsix extension"
(New-Object System.Net.WebClient).DownloadFile($extensionUrl, $extensionDownloadPath)

Write-Host "Installing Microsoft.DataTools.AnalysisServices.vsix extension"
try
{
     $process = Start-Process `
    -FilePath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\VSIXInstaller.exe" `
    -ArgumentList ("/quiet", "$extensionDownloadPath") `
    -Wait `
    -PassThru
}
catch
{
    Write-Host "There is an error during Microsoft.DataTools.AnalysisServices.vsix installation"
    $_
    exit 1
}


$exitCode = $process.ExitCode

if ($exitCode -eq 0 -or $exitCode -eq 1001) # 1001 means the extension is already installed
{
    Write-Host "Microsoft.DataTools.AnalysisServices.vsix installed successfully"
}
else
{
    Write-Host "Unsuccessful exit code returned by the installation process: $exitCode."
    exit 1
}

#Cleanup installation files
Remove-Item -Force -Confirm:$false $extensionDownloadPath

exit $exitCode
