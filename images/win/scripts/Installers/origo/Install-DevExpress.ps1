################################################################################
##  File:  Install-DevExpress.ps1
##  Desc:  Installs DevExpress
################################################################################
$installerVersion = $env:DEVEXPRESS_VERSION
$installerAccountName = $env:INSTALLER_ACCOUNT_NAME
$installerContainerName = $env:INSTALLER_CONTAINER_NAME
$installerSASToken = $env:INSTALLER_SAS_TOKEN
$devexpressUser = $env:DEVEXPRESS_USER
$devexpressPass = $env:DEVEXPRESS_PASS

function Install-DevExpressVersion
{
    Param
    (
        [String]$installerVersion,
        [string]$installerAccountName,
        [string]$installerContainerName,
        [string]$installerSASToken,
        [string]$devexpressUser,
        [string]$devexpressPass
    )

    function Install-EXE
    {
        Param
        (
            [String]$Url,
            [String]$Name,
            [String[]]$ArgumentList
        )
    
        $exitCode = -1
    
        try
        {
            Write-Host "Downloading $Name..."
            $FilePath = "${env:Temp}\$Name"
    
            Invoke-WebRequest -Uri $Url -OutFile $FilePath
    
            Write-Host "Starting Install $Name..."
            $process = Start-Process -FilePath $FilePath -ArgumentList $ArgumentList -PassThru
            for($i = 0; $i -le 100; $i = ($i + 1) % 100)
            {
                Write-Progress -Activity "DevExpressInstallation" -PercentComplete $i -Status "Installing"
                Start-Sleep -Milliseconds 100
                if ($process.HasExited) {
                    Write-Progress -Activity "Installer" -Completed
                    $exitCode = $process.ExitCode
                    break
                }
            }
            if ($exitCode -eq 0)
            {
                Write-Host -Object 'Installation successful'
                return $exitCode
            }
            elseif ($exitCode -eq 1)
            {
                Write-Host -Object'Common installation error. Check the log file located in the installation folder (the default installation path is C:\Program Files (x86)\DevExpress 21.2\Components).'
                return $exitCode
            }
            elseif ($exitCode -eq 3)
            {
                Write-Host -Object'No license for the selected product.'
                return $exitCode
            }
            elseif ($exitCode -eq 4)
            {
                Write-Host -Object'No access to the web service that validates the email and password. Check your internet connection or run the installer later.'
                return $exitCode
            }
            elseif ($exitCode -eq 5)
            {
                Write-Host -Object'EULA was not accepted. Specify the /EULA:accept parameter.'
                return $exitCode
            }
            elseif ($exitCode -eq 6)
            {
                Write-Host -Object'The installation file is broken. Please download it again.'
                return $exitCode
            }
            elseif ($exitCode -eq 7)
            {
                Write-Host -Object'The current OS and .NET framework versions are not supported.'
                return $exitCode
            }
            elseif ($exitCode -eq 8)
            {
                Write-Host -Object'Invalid DevExpress.com email or password is specified.'
                return $exitCode
            }
            elseif ($exitCode -eq 9)
            {
                Write-Host -Object'The specified DevExpress.com account is disabled.'
                return $exitCode
            }
            elseif ($exitCode -eq 10)
            {
                Write-Host -Object'Common errors with the account.'
                return $exitCode
            }
            elseif ($exitCode -eq 11)
            {
                Write-Host -Object'All licenses that the specified DevExpress.com account holds have been assigned to other accounts.'
                return $exitCode
            }
            elseif ($exitCode -eq 12)
            {
                Write-Host -Object'A license has been revoked from the specified DevExpress.com account.'
                return $exitCode
            }
            else
            {
                Write-Host -Object"Non zero exit code returned by the installation process : $exitCode."
                return $exitCode
            }
        }
        catch
        {
            Write-Host -Object "Failed to install the Executable $Name"
            Write-Host -Object $_.Exception.Message
            return -1
        }
    }

    $fileName = "DevExpressComponentsBundle-${installerVersion}"
    Write-Output "FileName is $fileName"
    # https://docs.devexpress.com/GeneralInformation/15656/installation/install-devexpress-net-products/silent-install-mode
    #$sasToken = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($installerSASToken))
    $ArgumentList = "/Q", "/EMAIL:${devexpressUser}", "/PASSWORD:${devexpressPass}", "/EULA:accept", "`"Windows Forms:True`"","`"WPF Components:True`"","`"XtraReports:True`"","`"ASP.NET:True`""
    Install-EXE `
      -Url "https://${installerAccountName}.blob.core.windows.net/${installerContainerName}/${fileName}.exe?${installerSASToken}" `
      -Name "${fileName}.exe" `
      -ArgumentList $ArgumentList
}

"Installer storage account"
"  Account name: ${installerAccountName}"
"  Container name: ${installerContainerName}"
"  SAS token: ${installerSASToken}"
"DevExpress"
"Installer version: ${installerVersion}"
"  DevExpress user: ${devexpressUser}"

Install-DevExpressVersion `
    -installerVersion $installerVersion `
    -installerAccountName $installerAccountName `
    -installerContainerName $installerContainerName `
    -installerSASToken $installerSASToken  `
    -devexpressUser $devexpressUser  `
    -devexpressPass $devexpressPass 