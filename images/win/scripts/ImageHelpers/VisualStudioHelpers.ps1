Function Install-VisualStudio {
    <#
    .SYNOPSIS
        A helper function to install Visual Studio.

    .DESCRIPTION
        Prepare system environment, and install Visual Studio bootstrapper with selected workloads.

    .PARAMETER Version
        The version of Visual Studio that will be installed. Required parameter.

    .PARAMETER Edition
        The edition of Visual Studio that will be installed. Required parameter.

    .PARAMETER Channel
        The channel of Visual Studio that will be installed. Required parameter.

    .PARAMETER RequiredComponents
        The list of required components. Required parameter.
    
    .PARAMETER ExtraArgs
        The extra arguments to pass to the bootstrapper. Optional parameter.
    #>

    Param
    (
        [Parameter(Mandatory)] [String] $Version,
        [Parameter(Mandatory)] [String] $Edition,
        [Parameter(Mandatory)] [String] $Channel,
        [Parameter(Mandatory)] [String[]] $RequiredComponents,
        [String] $ExtraArgs = "",
        [Parameter(Mandatory)] [String] $SignatureThumbprint
    )

    $bootstrapperUrl = "https://aka.ms/vs/${Version}/${Channel}/vs_${Edition}.exe"
    $channelUri = "https://aka.ms/vs/${Version}/${Channel}/channel"
    $channelId = "VisualStudio.${Version}.Release"
    $productId = "Microsoft.VisualStudio.Product.${Edition}"

    Write-Host "Downloading Bootstrapper ..."
    $BootstrapperName = [IO.Path]::GetFileName($BootstrapperUrl)
    $bootstrapperFilePath = Start-DownloadWithRetry -Url $BootstrapperUrl -Name $BootstrapperName

    # Verify that the bootstrapper is signed by Microsoft
    Test-FileSignature -FilePath $bootstrapperFilePath -ExpectedThumbprint $SignatureThumbprint

    try {
        Write-Host "Enable short name support on Windows needed for Xamarin Android AOT, defaults appear to have been changed in Azure VMs"
        $shortNameEnableProcess = Start-Process -FilePath fsutil.exe -ArgumentList ('8dot3name', 'set', '0') -Wait -PassThru

        $shortNameEnableExitCode = $shortNameEnableProcess.ExitCode
        if ($shortNameEnableExitCode -ne 0) {
            Write-Host "Enabling short name support on Windows failed. This needs to be enabled prior to VS 2017 install for Xamarin Andriod AOT to work."
            exit $shortNameEnableExitCode
        }

        $responseData = @{
            "channelUri" = $channelUri
            "channelId"  = $channelId
            "productId"  = $productId
            "arch"       = "x64"
            "add"        = $RequiredComponents | ForEach-Object { "$_;includeRecommended" }
        }

        # Create json file with response data
        $responseDataPath = "$env:TEMP\vs_install_response.json"
        $responseData | ConvertTo-Json | Out-File -FilePath $responseDataPath

        Write-Host "Starting Install ..."
        $bootstrapperArgumentList = ('/c', $bootstrapperFilePath, '--in', $responseDataPath, $ExtraArgs, '--quiet', '--norestart', '--wait', '--nocache' )
        Write-Host "Bootstrapper arguments: $bootstrapperArgumentList"
        $process = Start-Process -FilePath cmd.exe -ArgumentList $bootstrapperArgumentList -Wait -PassThru

        $exitCode = $process.ExitCode
        if ($exitCode -eq 0 -or $exitCode -eq 3010) {
            Write-Host "Installation successful"
            return $exitCode
        } else {
            Write-Host "Non zero exit code returned by the installation process : $exitCode"

            # Try to download tool to collect logs
            $collectExeUrl = "https://aka.ms/vscollect.exe"
            $collectExeName = [IO.Path]::GetFileName($collectExeUrl)
            $collectExePath = Start-DownloadWithRetry -Url $collectExeUrl -Name $collectExeName

            # Collect installation logs using the collect.exe tool and check if it is successful
            & "$collectExePath"
            if ($LastExitCode -ne 0) {
                Write-Host "Failed to collect logs using collect.exe tool. Exit code : $LastExitCode"
                exit $exitCode
            }

            # Expand the zip file
            Expand-Archive -Path "$env:TEMP\vslogs.zip" -DestinationPath "$env:TEMP\vslogs"

            # Print logs
            $vsLogsPath = "$env:TEMP\vslogs"
            $vsLogs = Get-ChildItem -Path $vsLogsPath -Recurse | Where-Object { -not $_.PSIsContainer } | Select-Object -ExpandProperty FullName
            foreach ($log in $vsLogs) {
                Write-Host "============================"
                Write-Host "== Log file : $log "
                Write-Host "============================"
                Get-Content -Path $log -ErrorAction Continue
            }
            
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
    $instanceFolder = Get-Item "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances\*" | Select-Object -First 1
    return Join-Path $instanceFolder.FullName "catalog.json"
}

function Get-VisualStudioInstance {
    # Use -Prerelease and -All flags to make sure that Preview versions of VS are found correctly
    $vsInstance = Get-VSSetupInstance -Prerelease -All | Where-Object { $_.DisplayName -match "Visual Studio" } | Select-Object -First 1
    $vsInstance | Select-VSSetupInstance -Product *
}

function Get-VisualStudioComponents {
    (Get-VisualStudioInstance).Packages | Where-Object type -in 'Component', 'Workload' |
    Sort-Object Id, Version | Select-Object @{n = 'Package'; e = {$_.Id}}, Version |
    Where-Object { $_.Package -notmatch "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" }
}
