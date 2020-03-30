################################################################################
##  File:  Install-SQLExpress.ps1
##  Desc:  Install SQL Express for Windows
################################################################################
Import-Module -Name ImageHelpers -Force;

function Download-FullSQLPackage {
    param(
        [String]$InstallerPath,
        [String]$DownloadPath,
        [String]$Arguments = ("/MEDIAPATH=$DownloadPath", "/MEDIATYPE=Core","/Action=Download", "/QUIET")
    )
    Write-Host "Downloading full package to $DownloadPath..."
    $process = Start-Process -FilePath $InstallerPath -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode
    if ($exitCode -eq 0)
    {
      Write-Host -Object "Full SQL Express package has been successfully downloaded to $DownloadPath : ExitCode: $exitCode"
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
    Write-Host "Start unpacking procedure to $InstallPath..."
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
        [String]$InstallerPath,
        [String]$Arguments = ("/Q", "/IACCEPTSQLSERVERLICENSETERMS", "/Action=Install", "/INSTANCEID=SQL2019", "/INSTANCENAME=SQL2019", "/SECURITYMODE=SQL", "/SAPWD=P@ssword!!", "/TCPENABLED=1")
    )
    Write-Host "Installating SQL Express..."
    $process = Start-Process -FilePath $InstallerPath -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode
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
#Main function
$installerUrl = "https://go.microsoft.com/fwlink/?linkid=866658"
$downloadPath = "C:\SQLInstall"
$setupPath = Join-Path $downloadPath "SQLEXPR_x64_ENU"
#Create directory for temporary files
New-Item -Path $downloadPath -ItemType Directory
Set-Location -Path $downloadPath
$installerPath = Start-DownloadWithRetry -Url $installerUrl -DownloadPath $downloadPath -Name "SQL2019-SSEI-Expr.exe"
Download-FullSQLPackage -InstallerPath $installerPath -DownloadPath $downloadPath
Unpack-SQLInstaller -InstallPath "$setupPath.exe"
$resultPath = Join-Path $setupPath "SETUP.exe"
Start-Installer -InstallerPath $resultPath
#Cleanup folder with installation packages.
Remove-Item $downloadPath -Recurse -Force
