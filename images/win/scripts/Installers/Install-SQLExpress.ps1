#Download web-installer
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
$args = ("/Q", "/IACCEPTSQLSERVERLICENSETERMS", "/Action=Install", "/INSTANCEID=SQL2020", "/INSTANCENAME=SQL2020", "/SECURITYMODE=SQL", "/SAPWD=P@ssword!!", "/TCPENABLED=1")
Write-Host "Downloading SQL Express setup package"
Start-Process -FilePath $installerPath -ArgumentList $downloadArgs -Wait -PassThru
#Unpack and run setup-package
Set-Location -Path $downloadPath
Write-Host "Unpack SQL Express setup package"
Start-Process -FilePath "$setupPath.exe" -ArgumentList $installArgs -Wait -PassThru
Write-Host "Run SQL Express setup package"
Start-Process -FilePath "$setupPath/SETUP.exe" -ArgumentList $args -Wait -PassThru