#Download web-installer
Set-Item .\MaxMemoryPerShellMB 4096
$installerUrl = "https://go.microsoft.com/fwlink/?linkid=866658"
$installerName = "SQL2019-SSEI-Expr.exe"
$installerPath = "${env:Temp}\$installerName"
Write-Host "Download web-installer"
(New-Object System.Net.WebClient).DownloadFile($installerUrl, $installerPath)
#use web-installer to download setup package
$downloadPath = "C:\SQLEXPRESS2019"
$setupPath = Join-Path $downloadPath "SQLEXPR_x64_ENU"
$downloadArgs = ("/MEDIAPATH=$downloadPath", "/MEDIATYPE=Core","/Action=Download", "/QUIET")
$installArgs = ("/Q", "/IACCEPTSQLSERVERLICENSETERMS")
$args = ("/c", "$setupPath/SETUP.exe", "/Q", "/IACCEPTSQLSERVERLICENSETERMS", "/Action=Install", "/INSTANCEID=SQL2019", "/INSTANCENAME=SQL2019", "/SECURITYMODE=SQL", "/SAPWD=P@ssword!!", "/TCPENABLED=1")
Write-Host "Downloading SQL Express setup package"
$process = Start-Process -FilePath $installerPath -ArgumentList $downloadArgs -Wait -PassThru
$exitCode = $process.ExitCode
if ($exitCode -eq 0)
{
    Write-Host -Object 'Downloaded successfully'
    Write-Host $exitCode
}
  else
{
    Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
    exit $exitCode
}
#Unpack and run setup-package
Set-Location -Path $downloadPath
Write-Host "Unpack SQL Express setup package"
$process = Start-Process -FilePath "$setupPath.exe" -ArgumentList $installArgs -Wait -PassThru
$exitCode = $process.ExitCode
if ($exitCode -eq 0)
{
    Write-Host -Object 'Unpacked successfully'
    Write-Host $exitCode
}
  else
{
    Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
    Write-Host $exitCode
}
Write-Host "Run SQL Express setup package"
$process = Start-Process -FilePath cmd.exe -ArgumentList $args -Wait -PassThru
$exitCode = $process.ExitCode
if ($exitCode -eq 0)
{
    Write-Host -Object 'Installed successfully'
    Write-Host $exitCode
}
  else
{
    Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
    exit $exitCode
}