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
    $bootstrapperFilePath = Invoke-DownloadWithRetry $BootstrapperUrl

    # Verify that the bootstrapper is signed by Microsoft
    Test-FileSignature -Path $bootstrapperFilePath -ExpectedThumbprint $SignatureThumbprint

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

        $installStartTime = Get-Date
        Write-Host "Starting Install ..."
        $bootstrapperArgumentList = ('/c', $bootstrapperFilePath, '--in', $responseDataPath, $ExtraArgs, '--quiet', '--norestart', '--wait', '--nocache' )
        Write-Host "Bootstrapper arguments: $bootstrapperArgumentList"
        $process = Start-Process -FilePath cmd.exe -ArgumentList $bootstrapperArgumentList -Wait -PassThru

        $exitCode = $process.ExitCode
        $installCompleteTime = [math]::Round(($(Get-Date) - $installStartTime).TotalSeconds, 2)
        if ($exitCode -eq 0) {
            Write-Host "Installation successful in $installCompleteTime seconds"
            return $exitCode
        } elseif ($exitCode -eq 3010) {
            Write-Host "Installation successful in $installCompleteTime seconds. Reboot is required."
            return $exitCode
        } else {
            Write-Host "Non zero exit code returned by the installation process : $exitCode"

            # Try to download tool to collect logs
            $collectExeUrl = "https://aka.ms/vscollect.exe"
            $collectExePath = Invoke-DownloadWithRetry -Url $collectExeUrl

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

function Get-VisualStudioInstance {
    # Use -Prerelease and -All flags to make sure that Preview versions of VS are found correctly
    $vsInstance = Get-VSSetupInstance -Prerelease -All | Where-Object { $_.DisplayName -match "Visual Studio" } | Select-Object -First 1
    $vsInstance | Select-VSSetupInstance -Product *
}

function Get-VisualStudioComponents {
    (Get-VisualStudioInstance).Packages | Where-Object type -in 'Component', 'Workload' |
        Sort-Object Id, Version | Select-Object @{n = 'Package'; e = { $_.Id } }, Version |
        Where-Object { $_.Package -notmatch "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" }
}

function Get-VsixInfoFromMarketplace {
    Param
    (
        [Parameter(Mandatory)]
        [Alias("ExtensionMarketPlaceName")]
        [string] $Name,
        [string] $MarketplaceUri = "https://marketplace.visualstudio.com/items?itemName="
    )

    # Invoke-WebRequest doesn't support retry in PowerShell 5.1
    $webResponse = Invoke-ScriptBlockWithRetry -RetryCount 20 -RetryIntervalSeconds 30 -Command {
        Invoke-WebRequest -Uri "${MarketplaceUri}${ExtensionMarketPlaceName}" -UseBasicParsing
    }

    $webResponse -match 'UniqueIdentifierValue":"(?<extensionname>[^"]*)' | Out-Null
    $extensionName = $Matches.extensionname

    $webResponse -match 'VsixId":"(?<vsixid>[^"]*)' | Out-Null
    $vsixId = $Matches.vsixid

    $webResponse -match 'AssetUri":"(?<uri>[^"]*)' | Out-Null
    $assetUri = $Matches.uri

    $webResponse -match 'Microsoft\.VisualStudio\.Services\.Payload\.FileName":"(?<filename>[^"]*)' | Out-Null
    $fileName = $Matches.filename

    switch ($Name) {
        # ProBITools.MicrosoftReportProjectsforVisualStudio2022 has different URL
        # https://github.com/actions/runner-images/issues/5340
        "ProBITools.MicrosoftReportProjectsforVisualStudio2022" {
            $assetUri = "https://download.microsoft.com/download/b/b/5/bb57be7e-ae72-4fc0-b528-d0ec224997bd"
            $fileName = "Microsoft.DataTools.ReportingServices.vsix"
        }
        "ProBITools.MicrosoftAnalysisServicesModelingProjects2022" {
            $assetUri = "https://download.microsoft.com/download/c/8/9/c896a7f2-d0fd-45ac-90e6-ff61f67523cb"
            $fileName = "Microsoft.DataTools.AnalysisServices.vsix"
        }

        # Starting from version 4.1 SqlServerIntegrationServicesProjects extension is distributed as exe file
        "SSIS.SqlServerIntegrationServicesProjects" {
            $fileName = "Microsoft.DataTools.IntegrationServices.exe"
        }
    }

    $downloadUri = $assetUri + "/" + $fileName

    return [PSCustomObject] @{
        "ExtensionName" = $extensionName
        "VsixId"        = $vsixId
        "FileName"      = $fileName
        "DownloadUri"   = $downloadUri
    }
}

function Install-VSIXFromFile {
    Param
    (
        [Parameter(Mandatory = $true)]
        [string] $FilePath,
        [int] $Retries = 20
    )

    Write-Host "Installing VSIX from $FilePath..."
    while ($True) {
        $installerPath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\resources\app\ServiceHub\Services\Microsoft.VisualStudio.Setup.Service\VSIXInstaller.exe"
        try {
            $process = Start-Process `
                -FilePath $installerPath `
                -ArgumentList @('/quiet', "`"$FilePath`"") `
                -Wait -PassThru
        } catch {
            Write-Host "Failed to start VSIXInstaller.exe with error:"
            $_
            exit 1
        }

        $exitCode = $process.ExitCode

        if ($exitCode -eq 0) {
            Write-Host "VSIX installed successfully."
            break
        } elseif ($exitCode -eq 1001) {
            Write-Host "VSIX is already installed."
            break
        }

        Write-Host "VSIX installation failed with exit code $exitCode."

        $Retries--
        if ($Retries -eq 0) {
            Write-Host "VSIX installation failed after $Retries retries."
            exit 1
        }

        Write-Host "Waiting 10 seconds before retrying. Retries left: $Retries"
        Start-Sleep -Seconds 10
    }
}

function Install-VSIXFromUrl {
    Param
    (
        [Parameter(Mandatory = $true)]
        [string] $Url,
        [int] $Retries = 20
    )

    $filePath = Invoke-DownloadWithRetry $Url
    Install-VSIXFromFile -FilePath $filePath -Retries $Retries
    Remove-Item -Force -Confirm:$false $filePath
}

function Get-VSExtensionVersion {
    Param
    (
        [Parameter(Mandatory = $true)]
        [string] $packageName
    )

    $instanceFolders = Get-ChildItem -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
    if ($instanceFolders -is [array]) {
        Write-Host ($instanceFolders | Out-String)
        Write-Host ($instanceFolders | Get-ChildItem | Out-String)
        Write-Host "More than one instance installed"
        exit 1
    }

    $stateContent = Get-Content -Path (Join-Path $instanceFolders.FullName '\state.packages.json')
    $state = $stateContent | ConvertFrom-Json
    $packageVersion = ($state.packages | Where-Object { $_.id -eq $packageName }).version

    if (-not $packageVersion) {
        Write-Host "Installed package $packageName for Visual Studio was not found"
        exit 1
    }

    return $packageVersion
}
