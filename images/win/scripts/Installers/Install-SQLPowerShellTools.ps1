################################################################################
##  File:  Install-SQLPowerShellTools.ps1
##  Desc:  Install SQL PowerShell tool
################################################################################

Import-Module -Name ImageHelpers -Force

Function InstallMSI
{
    Param
    (
        [String]$MsiUrl,
        [String]$MsiName
    )

    $exitCode = -1

    try
    {
        Write-Host "Downloading $MsiName..."
        $FilePath = "${env:Temp}\$MsiName"

        Invoke-WebRequest -Uri $MsiUrl -OutFile $FilePath

        $Arguments = ('/i', $FilePath, '/QN', '/norestart' )

        Write-Host "Starting Install $MsiName..."
        $process = Start-Process -FilePath msiexec.exe -ArgumentList $Arguments -Wait -PassThru
        $exitCode = $process.ExitCode

        if ($exitCode -eq 0 -or $exitCode -eq 3010)
        {
            Write-Host -Object 'Installation successful'
            return $exitCode
        }
        else
        {
            Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
            exit $exitCode
        }
    }
    catch
    {
        Write-Host -Object "Failed to install the MSI $MsiName"
        Write-Host -Object $_.Exception.Message
        exit -1
    }
}

# install required MSIs
$SQLSysClrTypesExitCode = InstallMSI -MsiUrl "https://download.microsoft.com/download/8/7/2/872BCECA-C849-4B40-8EBE-21D48CDF1456/ENU/x64/SQLSysClrTypes.msi" -MsiName "SQLSysClrTypes.msi"

$SharedManagementObjectsExitCode = InstallMSI -MsiUrl "https://download.microsoft.com/download/8/7/2/872BCECA-C849-4B40-8EBE-21D48CDF1456/ENU/x64/SharedManagementObjects.msi" -MsiName "SharedManagementObjects.msi"

$PowerShellToolsExitCode = InstallMSI -MsiUrl "https://download.microsoft.com/download/8/7/2/872BCECA-C849-4B40-8EBE-21D48CDF1456/ENU/x64/PowerShellTools.msi" -MsiName "PowerShellTools.msi"

# install sqlserver PS module
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name SqlServer -AllowClobber

exit $PowerShellToolsExitCode
