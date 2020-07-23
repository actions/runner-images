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

function Install-VsixExtension
{
    Param
    (
        [string] $Url,
        [Parameter(Mandatory = $true)]
        [string] $Name,
        [string] $FilePath,
        [Parameter(Mandatory = $true)]
        [string] $VSversion,
        [int] $retries = 20,
        [switch] $InstallOnly
    )

    if (-not $InstallOnly)
        {
            $FilePath = Start-DownloadWithRetry -Url $Url -Name $Name
        }

    $argumentList = ('/quiet', "`"$FilePath`"")

    Write-Host "Starting Install $Name..."
    try
    {
        #There are 2 types of packages at the moment - exe and vsix
        if ($Name -match "vsix")
        {
            $process = Start-Process -FilePath "C:\Program Files (x86)\Microsoft Visual Studio\$VSversion\Enterprise\Common7\IDE\VSIXInstaller.exe" -ArgumentList $argumentList -Wait -PassThru
        }
        else
        {
            $process = Start-Process -FilePath ${env:Temp}\$Name /Q -Wait -PassThru
        }
    }
    catch
    {
        Write-Host "There is an error during $Name installation"
        $_
        exit 1
    }

    $exitCode = $process.ExitCode

    if ($exitCode -eq 0 -or $exitCode -eq 1001) # 1001 means the extension is already installed
    {
        Write-Host "$Name installed successfully"
    }
    else
    {
        Write-Host "Unsuccessful exit code returned by the installation process: $exitCode."
        exit 1
    }

    #Cleanup downloaded installation files
    if (-not $InstallOnly)
        {
            Remove-Item -Force -Confirm:$false $FilePath
        }
}

function Get-VSExtensionVersion
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [string] $packageName
    )

    $instanceFolders = Get-ChildItem -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
    if ($instanceFolders -is [array])
    {
        Write-Host "More than one instance installed"
        exit 1
    }

    $stateContent = Get-Content -Path (Join-Path $instanceFolders.FullName '\state.packages.json')
    $state = $stateContent | ConvertFrom-Json
    $packageVersion = ($state.packages | Where-Object { $_.id -eq $packageName }).version

    if (-not $packageVersion)
    {
        Write-Host "installed package $packageName for Visual Studio 2019 was not found"
        exit 1
    }

    return $packageVersion
}

function Get-VsCatalogJsonPath {
    $instanceFolder = Get-Item "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances\*" | Select-Object -First 1
    return Join-Path $instanceFolder.FullName "catalog.json"
}

function Get-VisualStudioPath {
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Version,
        [Parameter(Mandatory=$true)]
        [string]$Edition
    )

    return "${env:ProgramFiles(x86)}\Microsoft Visual Studio\${Version}\${Edition}"
}

function Get-VisualStudioComponents {
    Install-Module VSSetup -Scope CurrentUser -Force
    $vsPackages = (Get-VSSetupInstance | Select-VSSetupInstance -Product *).Packages.Id
    $vsPackages  | Select-Object @{n = 'Package'; e = {$_}} |
    Where-Object { $_.Package -notmatch "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" }
}
