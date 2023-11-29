function Install-Binary {
    <#
    .SYNOPSIS
        A function to install binaries from either a URL or a local path.

    .DESCRIPTION
        This function downloads and installs .exe or .msi binaries from a specified URL or a local path. It also supports checking the binary's signature and SHA256/SHA512 sum before installation.

    .PARAMETER Url
        The URL from which the binary will be downloaded. This parameter is required if LocalPath is not specified.

    .PARAMETER LocalPath
        The local path of the binary to be installed. This parameter is required if Url is not specified.

    .PARAMETER Type
        The type of the binary to be installed. Valid values are "MSI" and "EXE". If not specified, the type is inferred from the file extension.

    .PARAMETER InstallArgs
        The list of arguments that will be passed to the installer. Cannot be used together with ExtraInstallArgs.

    .PARAMETER ExtraInstallArgs
        Additional arguments that will be passed to the installer. Cannot be used together with InstallArgs.

    .PARAMETER ExpectedSignature
        The expected signature of the binary. If specified, the binary's signature is checked before installation.

    .PARAMETER ExpectedSHA256Sum
        The expected SHA256 sum of the binary. If specified, the binary's SHA256 sum is checked before installation.

    .PARAMETER ExpectedSHA512Sum
        The expected SHA512 sum of the binary. If specified, the binary's SHA512 sum is checked before installation.

    .EXAMPLE
        Install-Binary -Url "https://go.microsoft.com/fwlink/p/?linkid=2083338" -Type EXE -InstallArgs ("/features", "+", "/quiet") -ExpectedSignature "A5C7D5B7C838D5F89DDBEDB85B2C566B4CDA881F"
    #>

    Param
    (
        [Parameter(Mandatory, ParameterSetName = "Url")]
        [String] $Url,
        [Parameter(Mandatory, ParameterSetName = "LocalPath")]
        [String] $LocalPath,
        [ValidateSet("MSI", "EXE")]
        [String] $Type,
        [String[]] $InstallArgs,
        [String[]] $ExtraInstallArgs,
        [String[]] $ExpectedSignature,
        [String] $ExpectedSHA256Sum,
        [String] $ExpectedSHA512Sum
    )

    if ($PSCmdlet.ParameterSetName -eq "LocalPath") {
        if (-not (Test-Path -Path $LocalPath)) {
            throw "LocalPath parameter is specified, but the file does not exist."
        }
        if (-not $Type) {
            $Type = ([System.IO.Path]::GetExtension($LocalPath)).Replace(".", "").ToUpper()
            if ($Type -ne "MSI" -and $Type -ne "EXE") {
                throw "LocalPath parameter is specified, but the file extension is not .msi or .exe. Please specify the Type parameter."
            }
        }
        $filePath = $LocalPath
    } else {
        if (-not $Type) {
            $Type = ([System.IO.Path]::GetExtension($Url)).Replace(".", "").ToUpper()
            if ($Type -ne "MSI" -and $Type -ne "EXE") {
                throw "Cannot determine the file type from the URL. Please specify the Type parameter."
            }
        }
        $fileName = [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetRandomFileName()) + ".$Type".ToLower()
        $filePath = Start-DownloadWithRetry -Url $Url -Name $fileName
    }

    if ($PSBoundParameters.ContainsKey('ExpectedSignature')) {
        if ($ExpectedSignature) {
            Test-FileSignature -FilePath $filePath -ExpectedThumbprint $ExpectedSignature
        } else {
            throw "ExpectedSignature parameter is specified, but no signature is provided."
        }
    }

    if ($ExpectedSHA256Sum) {
        $fileHash = (Get-FileHash -Path $filePath -Algorithm SHA256).Hash
        Use-ChecksumComparison $fileHash $ExpectedSHA256Sum
    }

    if ($ExpectedSHA512Sum) {
        $fileHash = (Get-FileHash -Path $filePath -Algorithm SHA512).Hash
        Use-ChecksumComparison $fileHash $ExpectedSHA512Sum
    }

    if ($ExtraInstallArgs -and $InstallArgs) {
        throw "InstallArgs and ExtraInstallArgs parameters cannot be used together."
    }
 
    if ($Type -eq "MSI") {
        # MSI binaries should be installed via msiexec.exe
        if ($ExtraInstallArgs) {
            $InstallArgs = @('/i', $filePath, '/qn', '/norestart') + $ExtraInstallArgs
        } elseif (-not $InstallArgs) {
            Write-Host "No arguments provided for MSI binary. Using default arguments: /i, /qn, /norestart"
            $InstallArgs = @('/i', $filePath, '/qn', '/norestart')
        }
        $filePath = "msiexec.exe"
    } else {
        # EXE binaries should be started directly
        if ($ExtraInstallArgs) {
            $InstallArgs = $ExtraInstallArgs
        }
    }

    $installStartTime = Get-Date
    Write-Host "Starting Install $Name..."
    try {
        $process = Start-Process -FilePath $filePath -ArgumentList $InstallArgs -Wait -PassThru
        $exitCode = $process.ExitCode
        $installCompleteTime = [math]::Round(($(Get-Date) - $installStartTime).TotalSeconds, 2)
        if ($exitCode -eq 0) {
            Write-Host "Installation successful in $installCompleteTime seconds"
        } elseif ($exitCode -eq 3010) {
            Write-Host "Installation successful in $installCompleteTime seconds. Reboot is required."
        } else {
            Write-Host "Installation process returned unexpected exit code: $exitCode"
            Write-Host "Time elapsed: $installCompleteTime seconds"
            exit $exitCode
        }
    } catch {
        $installCompleteTime = [math]::Round(($(Get-Date) - $installStartTime).TotalSeconds, 2)
        Write-Host "Installation failed in $installCompleteTime seconds"
    }
}

function Start-DownloadWithRetry {
    Param
    (
        [Parameter(Mandatory)]
        [string] $Url,
        [string] $Name,
        [string] $DownloadPath = "${env:Temp}",
        [int] $Retries = 20
    )

    if ([String]::IsNullOrEmpty($Name)) {
        $Name = [IO.Path]::GetFileName($Url)
    }

    $filePath = Join-Path -Path $DownloadPath -ChildPath $Name
    $downloadStartTime = Get-Date

    # Default retry logic for the package.
    Write-Host "Downloading package from: $Url to path $filePath."
    while ($Retries -gt 0) {
        try {
            $downloadAttemptStartTime = Get-Date
            (New-Object System.Net.WebClient).DownloadFile($Url, $filePath)
            break
        } catch {
            $failTime = [math]::Round(($(Get-Date) - $downloadStartTime).TotalSeconds, 2)
            $attemptTime = [math]::Round(($(Get-Date) - $downloadAttemptStartTime).TotalSeconds, 2)
            Write-Host "There is an error encounterd after $attemptTime seconds during package downloading:`n$($_.Exception.ToString())"
            $Retries--

            if ($Retries -eq 0) {
                Write-Host "Package download failed after $failTime seconds"
                exit 1
            }

            Write-Host "Waiting 30 seconds before retrying. Retries left: $Retries"
            Start-Sleep -Seconds 30
        }
    }

    $downloadCompleteTime = [math]::Round(($(Get-Date) - $downloadStartTime).TotalSeconds, 2)
    Write-Host "Package downloaded successfully in $downloadCompleteTime seconds"
    return $filePath
}

function Get-VsixExtenstionFromMarketplace {
    Param
    (
        [string] $ExtensionMarketPlaceName,
        [string] $MarketplaceUri = "https://marketplace.visualstudio.com/items?itemName="
    )

    # Invoke-WebRequest doesn't support retry in PowerShell 5.1
    $request = Invoke-ScriptBlockWithRetry -RetryCount 20 -RetryIntervalSeconds 30 -Command {
        Invoke-WebRequest -Uri "${MarketplaceUri}${ExtensionMarketPlaceName}" -UseBasicParsing
    }
    $request -match 'UniqueIdentifierValue":"(?<extensionname>[^"]*)' | Out-Null
    $extensionName = $Matches.extensionname
    $request -match 'VsixId":"(?<vsixid>[^"]*)' | Out-Null
    $vsixId = $Matches.vsixid
    $request -match 'AssetUri":"(?<uri>[^"]*)' | Out-Null
    $assetUri = $Matches.uri
    $request -match 'Microsoft\.VisualStudio\.Services\.Payload\.FileName":"(?<filename>[^"]*)' | Out-Null
    $fileName = $Matches.filename
    $downloadUri = $assetUri + "/" + $fileName
    # ProBITools.MicrosoftReportProjectsforVisualStudio2022 has different URL https://github.com/actions/runner-images/issues/5340
    switch ($ExtensionMarketPlaceName) {
        "ProBITools.MicrosoftReportProjectsforVisualStudio2022" {
            $fileName = "Microsoft.DataTools.ReportingServices.vsix"
            $downloadUri = "https://download.microsoft.com/download/b/b/5/bb57be7e-ae72-4fc0-b528-d0ec224997bd/Microsoft.DataTools.ReportingServices.vsix"
        }
        "ProBITools.MicrosoftAnalysisServicesModelingProjects2022" {
            $fileName = "Microsoft.DataTools.AnalysisServices.vsix"
            $downloadUri = "https://download.microsoft.com/download/c/8/9/c896a7f2-d0fd-45ac-90e6-ff61f67523cb/Microsoft.DataTools.AnalysisServices.vsix"
        }
        # Starting from version 4.1 SqlServerIntegrationServicesProjects extension is distributed as exe file
        "SSIS.SqlServerIntegrationServicesProjects" {
            $fileName = "Microsoft.DataTools.IntegrationServices.exe"
            $downloadUri = $assetUri + "/" + $fileName
        }
    }

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

    $name = [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetRandomFileName()) + ".vsix"
    $filePath = Start-DownloadWithRetry -Url $Url -Name $Name
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

function Get-ToolsetContent {
    $toolsetPath = Join-Path "C:\\image" "toolset.json"
    $toolsetJson = Get-Content -Path $toolsetPath -Raw
    ConvertFrom-Json -InputObject $toolsetJson
}

function Get-TCToolPath {
    <#
    .SYNOPSIS
        This function returns the full path of a tool in the tool cache.

    .DESCRIPTION
        The Get-TCToolPath function takes a tool name as a parameter and returns the full path of the tool in the tool cache. 
        It uses the AGENT_TOOLSDIRECTORY environment variable to determine the root path of the tool cache.

    .PARAMETER ToolName
        The name of the tool for which the path is to be returned.

    .EXAMPLE
        Get-TCToolPath -ToolName "Tool1"

        This command returns the full path of "Tool1" in the tool cache.

    #>
    Param
    (
        [string] $ToolName
    )

    $toolcacheRootPath = Resolve-Path $env:AGENT_TOOLSDIRECTORY
    return Join-Path $toolcacheRootPath $ToolName
}

function Get-TCToolVersionPath {
    <#
    .SYNOPSIS
        This function returns the full path of a specific version of a tool in the tool cache.

    .DESCRIPTION
        The Get-TCToolVersionPath function takes a tool name, version, and architecture as parameters and returns the full path of the specified version of the tool in the tool cache. 
        It uses the Get-TCToolPath function to get the root path of the tool.

    .PARAMETER Name
        The name of the tool for which the path is to be returned.

    .PARAMETER Version
        The version of the tool for which the path is to be returned. If the version number is less than 3 parts, a wildcard is added.

    .PARAMETER Arch
        The architecture of the tool for which the path is to be returned. Defaults to "x64".

    .EXAMPLE
        Get-TCToolVersionPath -Name "Tool1" -Version "1.0" -Arch "x86"

        This command returns the full path of version "1.0" of "Tool1" for "x86" architecture in the tool cache.

    #>
    Param
    (
        [Parameter(Mandatory = $true)]
        [string] $Name,
        [Parameter(Mandatory = $true)]
        [string] $Version,
        [string] $Arch = "x64"
    )

    $toolPath = Get-TCToolPath -ToolName $Name

    # Add wildcard if missing
    if ($Version.Split(".").Length -lt 3) {
        $Version += ".*"
    }

    $versionPath = Join-Path $toolPath $Version

    # Take latest installed version in case if toolset version contains wildcards
    $foundVersion = Get-Item $versionPath `
    | Sort-Object -Property { [version]$_.name } -Descending `
    | Select-Object -First 1

    if (-not $foundVersion) {
        return $null
    }

    return Join-Path $foundVersion $Arch
}

function Get-WinVersion {
    (Get-CimInstance -ClassName Win32_OperatingSystem).Caption
}

function Test-IsWin22 {
    (Get-WinVersion) -match "2022"
}

function Test-IsWin19 {
    (Get-WinVersion) -match "2019"
}

function Expand-7ZipArchive {
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [string]$DestinationPath,
        [ValidateSet("x", "e")]
        [char]$ExtractMethod = "x"
    )

    Write-Host "Expand archive '$PATH' to '$DestinationPath' directory"
    7z.exe $ExtractMethod "$Path" -o"$DestinationPath" -y | Out-Null

    if ($LASTEXITCODE -ne 0) {
        Write-Host "There is an error during expanding '$Path' to '$DestinationPath' directory"
        exit 1
    }
}

function Get-AndroidPackages {
    <#
    .SYNOPSIS
        This function returns a list of available Android packages.

    .DESCRIPTION
        The Get-AndroidPackages function checks if a list of packages is already available in a file.
        If not, it uses the sdkmanager.bat script to generate a list of available packages and saves it to a file. 
        It then returns the content of this file.

    .PARAMETER SDKRootPath
        The root path of the Android SDK installation.
        If not specified, the function uses the ANDROID_HOME environment variable.

    .EXAMPLE
        Get-AndroidPackages -SDKRootPath "C:\Android\SDK"

        This command returns a list of available Android packages for the specified SDK root path.

    .NOTES
        This function requires the Android SDK to be installed and the sdkmanager.bat script to be accessible.

    #>
    Param
    (
        [string]$SDKRootPath
    )
    
    if (-not $SDKRootPath) {
        $SDKRootPath = $env:ANDROID_HOME
    }

    $packagesListFile = "$SDKRootPath\packages-list.txt"
    $sdkManager = "$SDKRootPath\cmdline-tools\latest\bin\sdkmanager.bat"

    if (-Not (Test-Path -Path $packagesListFile -PathType Leaf)) {
        (cmd /c "$sdkManager --list --verbose 2>&1") |
            Where-Object { $_ -Match "^[^\s]" } |
            Where-Object { $_ -NotMatch "^(Loading |Info: Parsing |---|\[=+|Installed |Available )" } |
            Where-Object { $_ -NotMatch "^[^;]*$" } |
            Out-File -FilePath $packagesListFile
    }

    return Get-Content $packagesListFile
}

function Get-AndroidPlatformPackages {
    <#
    .SYNOPSIS
        This function returns a list of available Android platform packages.

    .DESCRIPTION
        The Get-AndroidPlatformPackages function uses the Get-AndroidPackages function to get a list of available packages
        and filters it to return only platform packages.

    .PARAMETER SDKRootPath
        The root path of the Android SDK installation.
        If not specified, the function uses the ANDROID_HOME environment variable.

    .PARAMETER minimumVersion
        The minimum version of the platform packages to include in the result. Default is 0.

    .EXAMPLE
        Get-AndroidPlatformPackages -SDKRootPath "C:\Android\SDK" -minimumVersion 29

        This command returns a list of available Android platform packages for the specified SDK root path with a minimum version of 29.

    .NOTES
        This function requires the Android SDK to be installed and the sdkmanager.bat script to be accessible.

    #>
    Param
    (
        [string]$SDKRootPath,
        [Alias("minVersion")]
        [int]$minimumVersion = 0
    )
    
    if (-not $SDKRootPath) {
        $SDKRootPath = $env:ANDROID_HOME
    }

    return (Get-AndroidPackages -SDKRootPath $SDKRootPath) `
    | Where-Object { "$_".StartsWith("platforms;") } `
    | Where-Object { ($_.Split("-")[1] -as [int]) -ge $minimumVersion } `
    | Sort-Object -Unique
}

function Get-AndroidBuildToolPackages {
    <#
    .SYNOPSIS
        This function returns a list of available Android build tool packages.

    .DESCRIPTION
        The Get-AndroidBuildToolPackages function uses the Get-AndroidPackages function to get a list of available packages
        and filters it to return only build tool packages.

    .PARAMETER SDKRootPath
        The root path of the Android SDK installation.
        If not specified, the function uses the ANDROID_HOME environment variable.

    .PARAMETER minimumVersion
        The minimum version of the build tool packages to include in the result. Default is 0.0.0.

    .EXAMPLE
        Get-AndroidBuildToolPackages -SDKRootPath "C:\Android\SDK" -minimumVersion "30.0.2"

        This command returns a list of available Android build tool packages for the specified SDK root path with a minimum version of 30.0.2.

    .NOTES
        This function requires the Android SDK to be installed and the sdkmanager.bat script to be accessible.

    #>
    Param
    (
        [string]$SDKRootPath,
        [Alias("minVersion")]
        [version]$minimumVersion = "0.0.0"
    )
    
    if (-not $SDKRootPath) {
        $SDKRootPath = $env:ANDROID_HOME
    }

    return (Get-AndroidPackages -SDKRootPath $SDKRootPath) `
    | Where-Object { "$_".StartsWith("build-tools;") } `
    | Where-Object { ($_.Split(";")[1] -as [version]) -ge $minimumVersion } `
    | Sort-Object -Unique
}

function Get-AndroidInstalledPackages {
    <#
    .SYNOPSIS
        Retrieves a list of installed Android packages.

    .DESCRIPTION
        This function retrieves a list of installed Android packages using the specified SDK root path.

    .PARAMETER SDKRootPath
        The root path of the Android SDK.
        If not specified, the function uses the ANDROID_HOME environment variable.

    .EXAMPLE
        Get-AndroidInstalledPackages -SDKRootPath "C:\Android\SDK"
        Retrieves a list of installed Android packages using the specified SDK root path.

    .NOTES
        This function requires the Android SDK to be installed and the SDK root path to be provided.
    #>

    Param
    (
        [string]$SDKRootPath
    )
    
    if (-not $SDKRootPath) {
        $SDKRootPath = $env:ANDROID_HOME
    }
    
    $sdkManager = "$SDKRootPath\cmdline-tools\latest\bin\sdkmanager.bat"

    return (cmd /c "$sdkManager --list_installed 2>&1") -notmatch "Warning"
}

function Get-WindowsUpdateStates {
    <#
    .SYNOPSIS
        Retrieves the status of Windows updates.

    .DESCRIPTION
        The Get-WindowsUpdateStates function checks the Windows Event Log for specific event IDs related to Windows updates and returns a custom PowerShell object with the state and title of each update.

    .PARAMETER None
        This function does not take any parameters.

    .OUTPUTS
        PSCustomObject. This function returns a collection of custom PowerShell objects. Each object has two properties:
        - State: A string that represents the state of the update. Possible values are "Installed", "Failed", and "Running".
        - Title: A string that represents the title of the update.

    .NOTES
        Event IDs used:
        - 19: Installation Successful: Windows successfully installed the following update
        - 20: Installation Failure: Windows failed to install the following update with error
        - 43: Installation Started: Windows has started installing the following update
    #>

    $completedUpdates = @{}
    $filter = @{
        LogName      = "System"
        Id           = 19, 20, 43
        ProviderName = "Microsoft-Windows-WindowsUpdateClient"
    }
    $events = Get-WinEvent -FilterHashtable $filter -ErrorAction SilentlyContinue | Sort-Object Id

    foreach ( $event in $events ) {
        switch ( $event.Id ) {
            19 {
                $state = "Installed"
                $title = $event.Properties[0].Value
                $completedUpdates[$title] = ""
                break
            }
            20 {
                $state = "Failed"
                $title = $event.Properties[1].Value
                $completedUpdates[$title] = ""
                break
            }
            43 {
                $state = "Running"
                $title = $event.Properties[0].Value
                break
            }
        }

        # Skip update started event if it was already completed
        if ( $state -eq "Running" -and $completedUpdates.ContainsKey($title) ) {
            continue
        }

        [PSCustomObject]@{
            State = $state
            Title = $title
        }
    }
}

function Invoke-ScriptBlockWithRetry {
    <#
    .SYNOPSIS
        Executes a script block with retry logic.

    .DESCRIPTION
        The Invoke-ScriptBlockWithRetry function executes a specified script block with retry logic. It allows you to specify the number of retries and the interval between retries.

    .PARAMETER Command
        The script block to be executed.

    .PARAMETER RetryCount
        The number of times to retry executing the script block. The default value is 10.

    .PARAMETER RetryIntervalSeconds
        The interval in seconds between each retry. The default value is 5.

    .EXAMPLE
        Invoke-ScriptBlockWithRetry -Command { Get-Process } -RetryCount 3 -RetryIntervalSeconds 10
        This example executes the script block { Get-Process } with 3 retries and a 10-second interval between each retry.

    #>

    param (
        [scriptblock] $Command,
        [int] $RetryCount = 10,
        [int] $RetryIntervalSeconds = 5
    )

    while ($RetryCount -gt 0) {
        try {
            & $Command
            return
        } catch {
            Write-Host "There is an error encountered:`n $_"
            $RetryCount--

            if ($RetryCount -eq 0) {
                exit 1
            }

            Write-Host "Waiting $RetryIntervalSeconds seconds before retrying. Retries left: $RetryCount"
            Start-Sleep -Seconds $RetryIntervalSeconds
        }
    }
}

function Resolve-GithubReleaseAssetUrl {
    param (
        [Parameter(Mandatory = $true)]
        [Alias("Repo")]
        [string] $Repository,
        [Parameter(Mandatory = $true)]
        [Alias("Pattern", "File", "Asset")]
        [string] $UrlMatchPattern,
        [switch] $AllowPrerelease,
        [string] $Version = "*"
    )

    # Add wildcard to the beginning of the pattern if it's not there
    if ($UrlMatchPattern.Substring(0, 2) -ne "*/") {
        $UrlMatchPattern = "*/$UrlMatchPattern"
    }

    $releases = @()
    $page = 1
    $pageSize = 100
    do {
        $releasesPage = Invoke-RestMethod -Uri "https://api.github.com/repos/${Repository}/releases?per_page=${pageSize}&page=${page}"
        $releases += $releasesPage
        $page++
    } while ($releasesPage.Count -eq $pageSize)
    Write-Debug "Found $($releases.Count) releases for ${Repository}"

    if (-not $releases) {
        throw "Failed to get releases from ${Repository}"
    }

    $releases = $releases.Where{ $_.assets }
    if (-not $AllowPrerelease) {
        $releases = $releases.Where{ $_.prerelease -eq $false }
    }
    Write-Debug "Found $($releases.Count) releases with assets for ${Repository}"

    # Parse version from tag name and put it to parameter Version
    foreach ($release in $releases) {
        $release | Add-Member -MemberType NoteProperty -Name version -Value (
            $release.tag_name | Select-String -Pattern "\d+.\d+.\d+" | ForEach-Object { $_.Matches.Value }
        )
    }

    # Sort releases by version
    $releases = $releases | Sort-Object -Descending { [version]$_.version }

    # Select releases matching version
    if ($Version -eq "latest") {
        $matchingReleases = $releases | Select-Object -First 1
    } elseif ($Version.Contains("*")) {
        $matchingReleases = $releases | Where-Object { $_.version -like "$Version" }
    } else {
        $matchingReleases = $releases | Where-Object { $_.version -eq "$Version" }
    }

    if (-not $matchingReleases) {
        throw "Failed to get releases from ${Repository} matching version `"${Version}`".`nAvailable versions: $($availableVersions -join ", ")"
    }
    Write-Debug "Found $($matchingReleases.Count) releases matching version ${Version} for ${Repository}"

    # Loop over releases until we find a download url matching the pattern
    foreach ($release in $matchingReleases) {
        $matchedVersion = $release.version
        $matchedUrl = $release.assets.browser_download_url -like $UrlMatchPattern
        if ($matchedUrl) {
            break
        }
    }

    if (-not $matchedUrl) {
        Write-Debug "Found no download urls matching pattern ${UrlMatchPattern}"
        Write-Debug "Available download urls:`n$($matchingReleases.assets.browser_download_url -join "`n")"
        throw "No assets found in ${Repository} matching version `"${Version}`" and pattern `"${UrlMatchPattern}`""
    } elseif ($matchedUrl.Count -gt 1) {
        Write-Debug "Found multiple download urls matching pattern ${UrlMatchPattern}:`n$($matchedUrl -join "`n")"
        throw "Multiple download urls found in ${Repository} version `"${matchedVersion}`" matching pattern `"${UrlMatchPattern}`":`n$($matchedUrl -join "`n")"
    }

    Write-Host "Found download url for ${Repository} version ${matchedVersion}: ${matchedUrl}"

    return ($matchedUrl -as [string])
}

function Use-ChecksumComparison {
    param (
        [Parameter(Mandatory = $true)]
        [string]$LocalFileHash,
        [Parameter(Mandatory = $true)]
        [string]$DistributorFileHash
    )

    Write-Verbose "Performing checksum verification"

    if ($LocalFileHash -ne $DistributorFileHash) {
        throw "Checksum verification failed. Expected hash: $DistributorFileHash; Actual hash: $LocalFileHash."
    } else {
        Write-Verbose "Checksum verification passed"
    }
}

function Get-HashFromGitHubReleaseBody {
    param (
        [string]$RepoOwner,
        [string]$RepoName,
        [Parameter(Mandatory = $true)]
        [string]$FileName,
        [string]$Url,
        [string]$Version = "latest",
        [boolean]$IsPrerelease = $false,
        [int]$SearchInCount = 100,
        [string]$Delimiter = '|',
        [int]$WordNumber = 1
    )

    if ($Url) {
        $releaseUrl = $Url
    } else {
        if ($Version -eq "latest") {
            $releaseUrl = "https://api.github.com/repos/${RepoOwner}/${RepoName}/releases/latest"
        } else {
            $json = Invoke-RestMethod -Uri "https://api.github.com/repos/${RepoOwner}/${RepoName}/releases?per_page=${SearchInCount}"
            $tags = $json.Where{ $_.prerelease -eq $IsPrerelease }.tag_name
            $tag = $tags -match $Version
            if (-not $tag) {
                throw "Failed to get a tag name for version $Version."
            }
            $releaseUrl = "https://api.github.com/repos/${RepoOwner}/${RepoName}/releases/tag/$tag"
        }
    }
    $body = (Invoke-RestMethod -Uri $releaseUrl).body -replace ('`', "") -join "`n"
    $matchingLine = $body.Split("`n") | Where-Object { $_ -like "*$FileName*" }    
    if ([string]::IsNullOrEmpty($matchingLine)) {
        throw "File name '$FileName' not found in release body."
    }
    $result = $matchingLine.Split($Delimiter)[$WordNumber] -replace "[^a-zA-Z0-9]", ""
    if ([string]::IsNullOrEmpty($result)) {
        throw "Empty result. Check Split method parameters (delimiter and/or word number) for the matching line."
    }
    return $result
}
function Test-FileSignature {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [Parameter(Mandatory = $true)]
        [string[]]$ExpectedThumbprint
    )

    $signature = Get-AuthenticodeSignature $FilePath

    if ($signature.Status -ne "Valid") {
        throw "Signature status is not valid. Status: $($signature.Status)"
    }
    
    foreach ($thumbprint in $ExpectedThumbprint) {
        if ($signature.SignerCertificate.Thumbprint.Contains($thumbprint)) {
            Write-Output "Signature for $FilePath is valid"
            $signatureMatched = $true
            return
        }
    }

    if ($signatureMatched) {
        Write-Output "Signature for $FilePath is valid"
    } else {
        throw "Signature thumbprint do not match expected."
    }
}
