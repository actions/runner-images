################################################################################
##  File:  Install-SQLExpress.ps1
##  Desc:  Install SQL Express for Windows
################################################################################
Import-Module -Name ImageHelpers -Force;

function Download-FullSQLPackage {
    param(
        [String]$InstallerPath,
        [String]$Arguments = ("/MEDIAPATH=$downloadPath", "/MEDIATYPE=Core","/Action=Download", "/QUIET")
    )
    $process = Start-Process -FilePath $InstallerPath -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode
# Exit code -2067529716 is added since SQL Unpack procedure returns it on success.
    if ($exitCode -eq 0)
    {
      Write-Host -Object "Full SQL Express package has been successfully downloaded to $InstallerPath : ExitCode: $exitCode"
    }
    else
    {
      Write-Host -Object "Full package downloading process was unsuccessful. Exit code: $exitCode."
      exit $exitCode
    }
}

function Unpack-SQLInstaller {
    param(
        [String]$InstallPath,
        [String]$Arguments = ("/Q", "/IACCEPTSQLSERVERLICENSETERMS")
    )
    $process = Start-Process -FilePath $InstallPath -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode
# Exit code -2067529716 is added since SQL Unpack procedure returns it on success.
    if ($exitCode -eq 0 -or $exitCode -eq -2067529716)
    {
      Write-Host -Object "SQL installer unpacking has been completed."
    }
    else
    {
      Write-Host -Object "SQL installer unpacking was interrupted : $exitCode."
      exit $exitCode
    }
}

function Start-Installer {
    param(
        [String]$InstallPath,
        [String]$Arguments = ("/Q", "/IACCEPTSQLSERVERLICENSETERMS", "/Action=Install", "/INSTANCEID=SQL2019", "/INSTANCENAME=SQL2019", "/SECURITYMODE=SQL", "/SAPWD=P@ssword!!", "/TCPENABLED=1")
    )
    $process = Start-Process -FilePath $InstallPath -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode
# Exit code -2067529716 is added since SQL Unpack procedure returns it on success.
    if ($exitCode -eq 0)
    {
      Write-Host -Object "SQL Express has been successfully installed: ExitCode: $exitCode"
    }
    else
    {
      Write-Host -Object "Installation procedure was not correctly completed. Exit code: $exitCode."
      exit $exitCode
    }
}

#default variables for functions.
$installerUrl = "https://go.microsoft.com/fwlink/?linkid=866658"
$downloadPath = "C:\SQLEXPRESS2019"
$setupPath = Join-Path $downloadPath "SQLEXPR_x64_ENU"
#Set default location for proper script execution
Set-Location -Path $downloadPath
#Download installer for SQL Express
$installerPath = Start-DownloadWithRetry -Url "https://go.microsoft.com/fwlink/?linkid=866658" -Name SQL2019-SSEI-Expr.exe
#Download full SQL Express package
Download-FullSQLPackage -InstallerPath $installerPath
#Unpack SQL Express Installer
Unpack-SQLInstaller -InstallPath "$setupPath.exe"
#Start SQL Express installer silently
Start-Installer -InstallPath "$setupPath/SETUP.exe"