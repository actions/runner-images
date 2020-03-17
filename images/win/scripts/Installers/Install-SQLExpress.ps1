################################################################################
##  File:  Install-SQLExpress.ps1
##  Desc:  Install SQL Express for Windows
################################################################################
function Start-Task {
    param(
        [String]$InstallPath,
        [String]$Arguments,
        [String]$SuccessMessage
    )
    $process = Start-Process -FilePath $InstallPath -ArgumentList $Arguments -Wait -PassThru
    $exitCode = $process.ExitCode
# Exit code -2067529716 is added since SQL Unpack procedure returns it on success.
    if ($exitCode -eq 0 -or $exitCode -eq -2067529716)
    {
      Write-Host -Object "$SuccessMessage : ExitCode: $exitCode"
    }
    else
    {
      Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
      exit $exitCode
    }
}

function Start-DownloadSQLExpress {
    param(
        [String]$InstallerUrl,
        [String]$InstallerPath,
        [int] $retries = 10
    )
    Write-Host "Downloading SQL Express web-installer from: $InstallerUrl"
    # In case of any errors -try to download package several times
    while($retries -gt 0)
        {
            try
            {
                Write-Host "Downloading SQL Express installer..."
                (New-Object System.Net.WebClient).DownloadFile($InstallerUrl, $InstallerPath)
                break
            }
            catch
            {
                Write-Host "There is an error during SQL Express downloading"
                $_

                $retries--

                if ($retries -eq 0)
                {
                    Write-Host "File can't be downloaded"
                    $_
                    exit 1
                }

                Write-Host "Waiting 30 seconds before retrying. Retries left: $retries"
                Start-Sleep -Seconds 30
            }
        }
    Write-Host "SQL Express has been successfully downladed from the link: $InstallerUrl"
}

$installerUrl = "https://go.microsoft.com/fwlink/?linkid=866658"
$installerPath = "${env:Temp}\SQL2019-SSEI-Expr.exe"
$downloadPath = "C:\SQLEXPRESS2019"
$setupPath = Join-Path $downloadPath "SQLEXPR_x64_ENU"
$downloadArgs = ("/MEDIAPATH=$downloadPath", "/MEDIATYPE=Core","/Action=Download", "/QUIET")
$unpackArgs = ("/Q", "/IACCEPTSQLSERVERLICENSETERMS")
$installArgs = ("/Q", "/IACCEPTSQLSERVERLICENSETERMS", "/Action=Install", "/INSTANCEID=SQL2019", "/INSTANCENAME=SQL2019", "/SECURITYMODE=SQL", "/SAPWD=P@ssword!!", "/TCPENABLED=1")
#Download installer for SQL Express
Start-DownloadSQLExpress -InstallerUrl $installerUrl -InstallerPath $installerPath
#Download full SQL Express package
Start-Task -InstallPath $installerPath  -Arguments $downloadArgs -SuccessMessage "Downloaded full package. To path: $installerPath "
#Unpack SQL Express Installer
Start-Task -InstallPath "$setupPath.exe"  -Arguments $unpackArgs -SuccessMessage "Unpacked package to directory: $setupPath"
#Start SQL Express installer silently
Start-Task -InstallPath "$setupPath/SETUP.exe"  -Arguments $installArgs -SuccessMessage "SQL has been installed to directory: ${env:ProgramFiles}/Microsoft SQL Server"