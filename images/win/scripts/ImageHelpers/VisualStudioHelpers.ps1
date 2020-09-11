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

function Get-VisualStudioInstancePath {
    return "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances\" + (Get-VisualStudioProduct -ProductType "VisualStudio").InstanceId
}

function Get-VsCatalogJsonPath {
    return Join-Path (Get-VisualStudioInstancePath) "catalog.json"
}

function Get-VisualStudioProduct {
    Param
    (
        [Parameter(Mandatory)]
        [ValidateSet('VisualStudio','BuildTools')]
        [String] $ProductType
    )

    if ($ProductType -eq "VisualStudio")
    {
        $VSSelectionType = "*Enterprise*"
    }
    elseif ($ProductType -eq "BuildTools")
    {
        $VSSelectionType = "*Build*"
    }
    return Get-VSSetupInstance | Where-Object -Property DisplayName -like $VSSelectionType
}

function Get-VisualStudioComponents {
    Param
    (
        [Parameter(Mandatory)]
        [String] $ProductType
    )
    (Get-VisualStudioProduct -ProductType $ProductType).Packages | Where-Object type -in 'Component', 'Workload' |
    Sort-Object Id, Version | Select-Object @{n = 'Package'; e = {$_.Id}}, Version |
    Where-Object { $_.Package -notmatch "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" }
}

function Get-VSExtensionVersion
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [string] $PackageName
    )

    $state = Get-Content -Path (Join-Path (Get-VisualStudioInstancePath) '\state.packages.json') | ConvertFrom-Json
    $packageVersion = ($state.packages | Where-Object { $_.id -eq $PackageName }).version

    if (-not $packageVersion)
    {
        Write-Host "installed package $PackageName for Visual Studio 2019 was not found"
        exit 1
    }

    return $packageVersion
}
