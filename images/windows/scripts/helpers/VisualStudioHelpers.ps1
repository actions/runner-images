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
        [Parameter(Mandatory)] [String[]] $SignatureThumbprint
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
            Expand-Archive -Path "$env:TEMP_DIR\vslogs.zip" -DestinationPath "$env:TEMP_DIR\vslogs"

            # Print logs
            $vsLogsPath = "$env:TEMP_DIR\vslogs"
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
    <#
    .SYNOPSIS
        Retrieves the Visual Studio instance.

    .DESCRIPTION
        This function retrieves the Visual Studio instance
        using the Get-VSSetupInstance cmdlet.
        It searches for both regular and preview versions
        of Visual Studio and returns the first instance found.
    #>

    # Use -Prerelease and -All flags to make sure that Preview versions of VS are found correctly
    $vsInstance = Get-VSSetupInstance -Prerelease -All | Where-Object { $_.DisplayName -match "Visual Studio" } | Select-Object -First 1
    $vsInstance | Select-VSSetupInstance -Product *
}

function Get-VisualStudioComponents {
    <#
    .SYNOPSIS
        Retrieves the Visual Studio components.

    .DESCRIPTION
        This function retrieves the Visual Studio components
        by filtering the packages returned by Get-VisualStudioInstance cmdlet.
        It filters the packages based on their type, sorts them by Id and Version,
        and excludes packages with GUID-like Ids.
    #>

    (Get-VisualStudioInstance).Packages `
    | Where-Object type -in 'Component', 'Workload' `
    | Sort-Object Id, Version `
    | Select-Object @{n = 'Package'; e = { $_.Id } }, Version `
    | Where-Object { $_.Package -notmatch "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" }
}

function Get-VsixInfoFromMarketplace {
    <#
    .SYNOPSIS
        Retrieves information about a Visual Studio extension from the Visual Studio Marketplace.

    .DESCRIPTION
        The Get-VsixInfoFromMarketplace function retrieves information
        about a Visual Studio extension from the Visual Studio Marketplace.
        It takes the name of the extension as input and returns
        the extension's name, VsixId, filename, and download URI.

    .PARAMETER Name
        The name of the Visual Studio extension.

    .PARAMETER MarketplaceUri
        The URI of the Visual Studio Marketplace.
        Default value is "https://marketplace.visualstudio.com/items?itemName=".

    .EXAMPLE
        Get-VsixInfoFromMarketplace -Name "ProBITools.MicrosoftReportProjectsforVisualStudio2022"
        Retrieves information about the "ProBITools.MicrosoftReportProjectsforVisualStudio2022" extension
        from the Visual Studio Marketplace.
    #>

    Param
    (
        [Parameter(Mandatory)]
        [Alias("ExtensionMarketPlaceName")]
        [string] $Name,
        [string] $MarketplaceUri = "https://marketplace.visualstudio.com/items?itemName="
    )

    # Invoke-WebRequest doesn't support retry in PowerShell 5.1
    $webResponse = Invoke-ScriptBlockWithRetry -RetryCount 20 -RetryIntervalSeconds 30 -Command {
        Invoke-WebRequest -Uri "${MarketplaceUri}${Name}" -UseBasicParsing
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
    <#
    .SYNOPSIS
        Installs a Visual Studio Extension (VSIX) from a file.

    .DESCRIPTION
        This function installs a Visual Studio Extension (VSIX)
        from the specified file path. It uses the VSIXInstaller.exe
        tool provided by Microsoft Visual Studio.

    .PARAMETER FilePath
        The path to the VSIX file that needs to be installed.

    .PARAMETER Retries
        The number of retries to attempt if the installation fails. Default is 20.

    .EXAMPLE
        Install-VSIXFromFile -FilePath "C:\Extensions\MyExtension.vsix" -Retries 10
        Installs the VSIX file located at "C:\Extensions\MyExtension.vsix" with 10 retries in case of failure.
    #>
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
    <#
    .SYNOPSIS
        Installs a Visual Studio extension (VSIX) from a given URL.

    .DESCRIPTION
        This function downloads a Visual Studio extension (VSIX)
        from the specified URL and installs it.

    .PARAMETER Url
        The URL of the VSIX file to download and install.

    .PARAMETER Retries
        The number of retries to attempt if the download fails. Default is 20.

    .EXAMPLE
        Install-VSIXFromUrl -Url "https://example.com/extension.vsix" -Retries 10
        Downloads and installs the VSIX file from the specified URL with 10 retries.
    #>

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
    <#
    .SYNOPSIS
        Retrieves the version of a Visual Studio extension package.

    .DESCRIPTION
        This function retrieves the version of a specified Visual Studio extension package.
        It searches for the package in the installed instances of Visual Studio and
        returns the version number.

    .PARAMETER packageName
        The name of the extension package.

    .EXAMPLE
        Get-VSExtensionVersion -packageName "MyExtensionPackage"
        Retrieves the version of the extension package named "MyExtensionPackage" for Visual Studio.
    #>
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
