Function Install-VisualStudio
{
    <#
    .SYNOPSIS
        A helper function to install Visual Studio.

    .DESCRIPTION
        Prepare system environment, and install Visual Studio bootstrapper with selected workloads.

    .PARAMETER BootstrapperUrl
        The URL from which the bootstrapper will be downloaded. Required parameter.

    .PARAMETER WorkLoads
        The string that contain workloads that will be passed to the installer.
    #>

    Param
    (
        [Parameter(Mandatory)]
        [String] $BootstrapperUrl,
        [String] $WorkLoads
    )

    Write-Host "Downloading Bootstrapper ..."
    $BootstrapperName = [IO.Path]::GetFileName($BootstrapperUrl)
    $bootstrapperFilePath = Start-DownloadWithRetry -Url $BootstrapperUrl -Name $BootstrapperName

    try
    {
        Write-Host "Enable short name support on Windows needed for Xamarin Android AOT, defaults appear to have been changed in Azure VMs"
        $shortNameEnableProcess = Start-Process -FilePath fsutil.exe -ArgumentList ('8dot3name', 'set', '0') -Wait -PassThru

        $shortNameEnableExitCode = $shortNameEnableProcess.ExitCode
        if ($shortNameEnableExitCode -ne 0)
        {
            Write-Host "Enabling short name support on Windows failed. This needs to be enabled prior to VS 2017 install for Xamarin Andriod AOT to work."
            exit $shortNameEnableExitCode
        }

        Write-Host "Starting Install ..."
        $bootstrapperArgumentList = ('/c', $bootstrapperFilePath, $WorkLoads, '--quiet', '--norestart', '--wait', '--nocache' )
        $process = Start-Process -FilePath cmd.exe -ArgumentList $bootstrapperArgumentList -Wait -PassThru

        $exitCode = $process.ExitCode
        if ($exitCode -eq 0 -or $exitCode -eq 3010)
        {
            Write-Host "Installation successful"
            return $exitCode
        }
        else
        {
            Write-Host "Non zero exit code returned by the installation process : $exitCode"
            exit $exitCode
        }
    }
    catch
    {
        Write-Host "Failed to install Visual Studio; $($_.Exception.Message)"
        exit -1
    }
}

function Get-VsCatalogJsonPath {
    $instanceFolder = "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances\" + (Get-VisualStudioInstallation -VSInstallType "VS").InstanceId
    return Join-Path $instanceFolder "catalog.json"
}

function Get-VisualStudioInstallation {
    Param
    (
        [Parameter(Mandatory)]
        [String] $VSInstallType
    )

    if ($VSInstallType -eq "VS")
    {
        $VSSelectionType = "*Enterprise*"
    }
    elseif ($VSInstallType -eq "BuildTools")
    {
        $VSSelectionType = "*Build*"
    }
    else
    {
        Write-Output "Visual Studio Installation type have to be 'VS' or 'BuildTools'"
        exit 1
    }
    return Get-VSSetupInstance | Select-VSSetupInstance -Product * | Where-Object -Property DisplayName -like $VSSelectionType
}

function Get-VisualStudioComponents {
    Param
    (
        [Parameter(Mandatory)]
        [String] $VSInstallType
    )
    (Get-VisualStudioInstallation -VSInstallType $VSInstallType).Packages | Where-Object type -in 'Component', 'Workload' |
    Sort-Object Id, Version | Select-Object @{n = 'Package'; e = {$_.Id}}, Version |
    Where-Object { $_.Package -notmatch "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" }
}
