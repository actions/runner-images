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
            $fileName = [System.IO.Path]::GetFileName($Url)
        } else {
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension([System.IO.Path]::GetRandomFileName()) + ".$Type".ToLower()
        }
        $filePath = Invoke-DownloadWithRetry -Url $Url -Path "${env:TEMP_DIR}\$fileName"
    }

    if ($PSBoundParameters.ContainsKey('ExpectedSignature')) {
        if ($ExpectedSignature) {
            Test-FileSignature -Path $filePath -ExpectedThumbprint $ExpectedSignature
        } else {
            throw "ExpectedSignature parameter is specified, but no signature is provided."
        }
    }

    if ($ExpectedSHA256Sum) {
        Test-FileChecksum $filePath -ExpectedSHA256Sum $ExpectedSHA256Sum
    }

    if ($ExpectedSHA512Sum) {
        Test-FileChecksum $filePath -ExpectedSHA512Sum $ExpectedSHA512Sum
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

function Invoke-DownloadWithRetry {
    <#
    .SYNOPSIS
        Downloads a file from a given URL with retry functionality.

    .DESCRIPTION
        The Invoke-DownloadWithRetry function downloads a file from the specified URL
        to the specified path. It includes retry functionality in case the download fails.

    .PARAMETER Url
        The URL of the file to download.

    .PARAMETER Path
        The path where the downloaded file will be saved. If not provided, a temporary path
        will be used.

    .EXAMPLE
        Invoke-DownloadWithRetry -Url "https://example.com/file.zip" -Path "C:\Downloads\file.zip"
        Downloads the file from the specified URL and saves it to the specified path.

    .EXAMPLE
        Invoke-DownloadWithRetry -Url "https://example.com/file.zip"
        Downloads the file from the specified URL and saves it to a temporary path.

    .OUTPUTS
        The path where the downloaded file is saved.
    #>

    Param
    (
        [Parameter(Mandatory)]
        [string] $Url,
        [Alias("Destination")]
        [string] $Path
    )

    if (-not $Path) {
        $invalidChars = [IO.Path]::GetInvalidFileNameChars() -join ''
        $re = "[{0}]" -f [RegEx]::Escape($invalidChars)
        $fileName = [IO.Path]::GetFileName($Url) -replace $re

        if ([String]::IsNullOrEmpty($fileName)) {
            $fileName = [System.IO.Path]::GetRandomFileName()
        }
        $Path = Join-Path -Path "${env:TEMP_DIR}" -ChildPath $fileName
    }

    Write-Host "Downloading package from $Url to $Path..."

    $interval = 30
    $downloadStartTime = Get-Date
    for ($retries = 20; $retries -gt 0; $retries--) {
        try {
            $attemptStartTime = Get-Date
            (New-Object System.Net.WebClient).DownloadFile($Url, $Path)
            $attemptSeconds = [math]::Round(($(Get-Date) - $attemptStartTime).TotalSeconds, 2)
            Write-Host "Package downloaded in $attemptSeconds seconds"
            break
        } catch {
            $attemptSeconds = [math]::Round(($(Get-Date) - $attemptStartTime).TotalSeconds, 2)
            Write-Warning "Package download failed in $attemptSeconds seconds"
            Write-Warning $_.Exception.Message

            if ($_.Exception.InnerException.Response.StatusCode -eq [System.Net.HttpStatusCode]::NotFound) {
                Write-Warning "Request returned 404 Not Found. Aborting download."
                $retries = 0
            }
        }

        if ($retries -eq 0) {
            $totalSeconds = [math]::Round(($(Get-Date) - $downloadStartTime).TotalSeconds, 2)
            throw "Package download failed after $totalSeconds seconds"
        }

        Write-Warning "Waiting $interval seconds before retrying (retries left: $retries)..."
        Start-Sleep -Seconds $interval
    }

    return $Path
}

function Get-ToolsetContent {
    <#
    .SYNOPSIS
        Retrieves the content of the toolset.json file.

    .DESCRIPTION
        This function reads the toolset.json file in path provided by IMAGE_FOLDER
        environment variable and returns the content as a PowerShell object.
    #>

    $toolsetPath = Join-Path $env:IMAGE_FOLDER "toolset.json"
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
    | Sort-Object -Property { [version] $_.name } -Descending `
    | Select-Object -First 1

    if (-not $foundVersion) {
        return $null
    }

    return Join-Path $foundVersion $Arch
}

function Test-IsWin25 {
    <#
    .SYNOPSIS
        Checks if the current Windows operating system is Windows Server 2025.
    .DESCRIPTION
        This function uses the Get-CimInstance cmdlet to retrieve information
        about the current Windows operating system. It then checks if the Caption
        property of the Win32_OperatingSystem class contains the string "2025",
        indicating that the operating system is Windows Server 2025.
    .OUTPUTS
        Returns $true if the current Windows operating system is Windows Server 2025.
        Otherwise, returns $false.
    #>
    (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -match "2025"
}

function Test-IsWin22 {
    <#
    .SYNOPSIS
        Checks if the current Windows operating system is Windows Server 2022.

    .DESCRIPTION
        This function uses the Get-CimInstance cmdlet to retrieve information
        about the current Windows operating system. It then checks if the Caption
        property of the Win32_OperatingSystem class contains the string "2022",
        indicating that the operating system is Windows Server 2022.

    .OUTPUTS
        Returns $true if the current Windows operating system is Windows Server 2022.
        Otherwise, returns $false.
    #>
    (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -match "2022"
}

function Test-IsWin19 {
    <#
    .SYNOPSIS
        Checks if the current Windows operating system is Windows Server 2019.

    .DESCRIPTION
        This function uses the Get-CimInstance cmdlet to retrieve information
        about the current Windows operating system. It then checks if the Caption
        property of the Win32_OperatingSystem class contains the string "2019",
        indicating that the operating system is Windows Server 2019.

    .OUTPUTS
        Returns $true if the current Windows operating system is Windows Server 2019.
        Otherwise, returns $false.
    #>
    (Get-CimInstance -ClassName Win32_OperatingSystem).Caption -match "2019"
}

function Expand-7ZipArchive {
    <#
    .SYNOPSIS
        Extracts files from a 7-Zip archive.

    .DESCRIPTION
        This function uses the 7z.exe command-line tool to extract files from an archive.
        The archive path, destination path, and extract method are specified as parameters.

    .PARAMETER Path
        The path to the archive.

    .PARAMETER DestinationPath
        The path to the directory where the files will be extracted.

    .PARAMETER ExtractMethod
        The method used to extract the files.
        Valid values are "x" (extract with full paths) and "e" (extract without paths).

    .EXAMPLE
        Expand-7ZipArchive -Path "C:\archive.7z" -DestinationPath "C:\extracted" -ExtractMethod "x"

        Extracts files from the "C:\archive.7z" archive to the "C:\extracted" directory keeping the full paths.
    #>
    Param
    (
        [Parameter(Mandatory = $true)]
        [string] $Path,
        [Parameter(Mandatory = $true)]
        [string] $DestinationPath,
        [ValidateSet("x", "e")]
        [char] $ExtractMethod = "x"
    )

    Write-Host "Expand archive '$PATH' to '$DestinationPath' directory"
    7z.exe $ExtractMethod "$Path" -o"$DestinationPath" -y | Out-Null

    if ($LASTEXITCODE -ne 0) {
        Write-Host "There is an error during expanding '$Path' to '$DestinationPath' directory"
        exit 1
    }
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

function Get-GithubReleasesByVersion {
    <#
    .SYNOPSIS
        Retrieves GitHub releases for a specified repository based on version.

    .DESCRIPTION
        The function retrieves GitHub releases for a specified repository based on the
        version provided. It supports filtering by version, allowing for the retrieval
        of specific releases or the latest release. The function utilizes the GitHub REST API
        to fetch the releases and caches the results to improve performance and reduce
        the number of API calls.

    .PARAMETER Repository
        The name of the GitHub repository in the format "owner/repo".

    .PARAMETER Version
        The version of the release to retrieve. It can be a specific version number,
        "latest" to retrieve the latest release, or a wildcard pattern to match multiple versions.

    .PARAMETER AllowPrerelease
        Specifies whether to include prerelease versions in the results. By default,
        prerelease versions are excluded.

    .PARAMETER WithAssetsOnly
        Specifies whether to exclude releases without assets. By default, releases without
        assets are included.

    .EXAMPLE
        Get-GithubReleasesByVersion -Repository "Microsoft/PowerShell" -Version "7.2.0"

        Retrieves the GitHub releases for the "Microsoft/PowerShell" repository with the version "7.2.0".

    .EXAMPLE
        Get-GithubReleasesByVersion -Repository "Microsoft/PowerShell" -Version "latest"

        Retrieves the latest GitHub release for the "Microsoft/PowerShell" repository.

    .EXAMPLE
        Get-GithubReleasesByVersion -Repository "Microsoft/PowerShell" -Version "7.*"

        Retrieves all GitHub releases for the "Microsoft/PowerShell" repository with versions starting with "7.".
    #>

    param (
        [Parameter(Mandatory = $true)]
        [Alias("Repo")]
        [string] $Repository,
        [string] $Version = "*",
        [switch] $AllowPrerelease,
        [switch] $WithAssetsOnly
    )

    $localCacheFile = Join-Path ${env:TEMP_DIR} "github-releases_$($Repository -replace "/", "_").json"

    if (Test-Path $localCacheFile) {
        $releases = Get-Content $localCacheFile | ConvertFrom-Json
        Write-Debug "Found cached releases for ${Repository} in local file"
        Write-Debug "Release count: $($releases.Count)"
    } else {
        $releases = @()
        $page = 1
        $pageSize = 100
        do {
            $releasesPage = Invoke-RestMethod -Uri "https://api.github.com/repos/${Repository}/releases?per_page=${pageSize}&page=${page}"
            $releases += $releasesPage
            $page++
        } while ($releasesPage.Count -eq $pageSize)

        Write-Debug "Found $($releases.Count) releases for ${Repository}"
        Write-Debug "Caching releases for ${Repository} in local file"
        $releases | ConvertTo-Json -Depth 10 | Set-Content $localCacheFile
    }

    if (-not $releases) {
        throw "Failed to get releases from ${Repository}"
    }

    if ($WithAssetsOnly) {
        $releases = $releases.Where{ $_.assets }
    }
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

    # Sort releases by version, then by tag name parts if version is the same
    $releases = $releases | Sort-Object -Descending {
        [version] $_.version
    }, {
        $cleanTagName = $_.tag_name -replace '^v', ''
        $parts = $cleanTagName -split '[.\-]'
        $parsedParts = $parts | ForEach-Object {
            if ($_ -match '^\d+$') { [int]$_ } else { $_ }
        }
        $parsedParts
    }

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

    return $matchingReleases
}

function Resolve-GithubReleaseAssetUrl {
    <#
    .SYNOPSIS
        Resolves the download URL for a specific asset in a GitHub release.

    .DESCRIPTION
        This function retrieves the download URL for a specific asset in a GitHub release.
        It takes the repository name, version, and a URL match pattern as input parameters.
        It searches for releases that match the specified version and then looks
        for a download URL that matches the provided pattern. If a matching URL is found,
        it returns the URL. If no matching URL is found, an exception is thrown.

    .PARAMETER Repository
        The name of the GitHub repository in the format "owner/repo".

    .PARAMETER Version
        The version of the release to retrieve. It can be a specific version number,
        "latest" to retrieve the latest release, or a wildcard pattern to match multiple versions.

    .PARAMETER AllowPrerelease
        Specifies whether to include prerelease versions in the results. By default,
        prerelease versions are excluded.

    .PARAMETER UrlMatchPattern
        The pattern to match against the download URLs of the release assets.
        Wildcards (*) can be used to match any characters.

    .PARAMETER AllowMultipleMatches
        Specifies whether to choose one of multiple assets matching the pattern or consider this behavior to be erroneous.
        By default, multiple matches are not considered normal behavior and result in an error.

    .EXAMPLE
        Resolve-GithubReleaseAssetUrl -Repository "myrepo" -Version "1.0" -UrlMatchPattern "*.zip"
        Retrieves the download URL for the asset in the "myrepo" repository with version "1.0" and a file extension of ".zip".

    #>

    param (
        [Parameter(Mandatory = $true)]
        [Alias("Repo")]
        [string] $Repository,
        [string] $Version = "*",
        [switch] $AllowPrerelease,
        [Parameter(Mandatory = $true)]
        [Alias("Pattern", "File", "Asset")]
        [string] $UrlMatchPattern,
        [switch] $AllowMultipleMatches = $false
    )

    $matchingReleases = Get-GithubReleasesByVersion `
        -Repository $Repository `
        -AllowPrerelease:$AllowPrerelease `
        -Version $Version `
        -WithAssetsOnly

    # Add wildcard to the beginning of the pattern if it's not there
    if ($UrlMatchPattern.Substring(0, 2) -ne "*/") {
        $UrlMatchPattern = "*/$UrlMatchPattern"
    }

    # Loop over releases until we find a download url matching the pattern
    foreach ($release in $matchingReleases) {
        $matchedVersion = $release.version
        $matchedUrl = ([string[]] $release.assets.browser_download_url) -like $UrlMatchPattern
        if ($matchedUrl) {
            break
        }
    }

    if (-not $matchedUrl) {
        Write-Debug "Found no download urls matching pattern ${UrlMatchPattern}"
        Write-Debug "Available download urls:`n$($matchingReleases.assets.browser_download_url -join "`n")"
        throw "No assets found in ${Repository} matching version `"${Version}`" and pattern `"${UrlMatchPattern}`""
    }
    # If multiple urls match the pattern, sort them and take the last one
    # Will only work with simple number series of no more than nine in a row.
    if ($matchedUrl.Count -gt 1) {
        if ($AllowMultipleMatches) {
            Write-Debug "Found multiple download urls matching pattern ${UrlMatchPattern}:`n$($matchedUrl -join "`n")"
            Write-Host "Performing sorting of urls to find the most recent version matching the pattern"
            $matchedUrl = $matchedUrl | Sort-Object -Descending
            $matchedUrl = $matchedUrl[0]
        } else {
            throw "Found multiple assets in ${Repository} matching version `"${Version}`" and pattern `"${UrlMatchPattern}`".`nAvailable assets:`n$($matchedUrl -join "`n")"
        }
    }

    Write-Host "Found download url for ${Repository} version ${matchedVersion}: ${matchedUrl}"

    return ($matchedUrl -as [string])
}

function Get-ChecksumFromGithubRelease {
    <#
    .SYNOPSIS
        Retrieves the hash value of a specific file from a GitHub release body.

    .DESCRIPTION
        The Get-ChecksumFromGithubRelease function retrieves the hash value (SHA256 or SHA512)
        of a specific file from a GitHub release. It searches for the file in the release body
        and returns the hash value if found.

    .PARAMETER Repository
        The name of the GitHub repository in the format "owner/repo".

    .PARAMETER Version
        The version of the release to inspect. It can be a specific version number,
        "latest" to retrieve the latest release, or a wildcard pattern to match multiple versions.

    .PARAMETER AllowPrerelease
        Specifies whether to include prerelease versions in the results. By default,
        prerelease versions are excluded.

    .PARAMETER FileName
        The name of the file to retrieve the hash value for.

    .PARAMETER HashType
        The type of hash value to retrieve. Valid values are "SHA256" and "SHA512".

    .EXAMPLE
        Get-ChecksumFromGithubRelease -Repository "MyRepo" -FileName "myfile.txt" -HashType "SHA256"

        Retrieves the SHA256 hash value of "myfile.txt" from the latest release of the "MyRepo" repository.

    .EXAMPLE
        Get-ChecksumFromGithubRelease -Repository "MyRepo" -Version "1.0" -FileName "myfile.txt" -HashType "SHA512"

        Retrieves the SHA512 hash value of "myfile.txt" from the release version "1.0" of the "MyRepo" repository.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [Alias("Repo")]
        [string] $Repository,
        [string] $Version = "*",
        [switch] $AllowPrerelease,
        [Parameter(Mandatory = $true)]
        [Alias("File", "Asset")]
        [string] $FileName,
        [Parameter(Mandatory = $true)]
        [ValidateSet("SHA256", "SHA512")]
        [string] $HashType
    )

    $matchingReleases = Get-GithubReleasesByVersion `
        -Repository $Repository `
        -AllowPrerelease:$AllowPrerelease `
        -Version $Version `
        -WithAssetsOnly

    foreach ($release in $matchingReleases) {
        $matchedVersion = $release.version
        $matchedBody = $release.body
        $matchedLine = $matchedBody.Split("`n") | Where-Object { $_ -like "*$FileName*" }
        if ($matchedLine.Count -gt 1) {
            throw "Found multiple lines matching file name '${FileName}' in body of release ${matchedVersion}."
        } elseif ($matchedLine.Count -ne 0) {
            break
        }
    }
    if (-not $matchedLine) {
        throw "File name '${FileName}' not found in release body."
    }
    Write-Debug "Found line matching file name '${FileName}' in body of release ${matchedVersion}:`n${matchedLine}"

    if ($HashType -eq "SHA256") {
        $pattern = "[A-Fa-f0-9]{64}"
    } elseif ($HashType -eq "SHA512") {
        $pattern = "[A-Fa-f0-9]{128}"
    } else {
        throw "Unknown hash type: ${HashType}"
    }

    $hash = $matchedLine | Select-String -Pattern $pattern | ForEach-Object { $_.Matches.Value }

    if ([string]::IsNullOrEmpty($hash)) {
        throw "Found '${FileName}' in body of release ${matchedVersion}, but failed to get hash from it.`nLine: ${matchedLine}"
    }
    Write-Host "Found hash for ${FileName} in release ${matchedVersion}: $hash"

    return $hash
}

function Get-ChecksumFromUrl {
    <#
    .SYNOPSIS
        Retrieves the checksum hash for a file from a given URL.

    .DESCRIPTION
        The Get-ChecksumFromUrl function retrieves the checksum hash for a specified file
        from a given URL. It supports SHA256 and SHA512 hash types.

    .PARAMETER Url
        The URL of the checksum file.

    .PARAMETER FileName
        The name of the file to retrieve the checksum hash for.

    .PARAMETER HashType
        The type of hash to retrieve. Valid values are "SHA256" and "SHA512".

    .EXAMPLE
        Get-ChecksumFromUrl -Url "https://example.com/checksums.txt" -FileName "file.txt" -HashType "SHA256"
        Retrieves the SHA256 checksum hash for the file "file.txt" from the URL "https://example.com/checksums.txt".
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $Url,
        [Parameter(Mandatory = $true)]
        [Alias("File", "Asset")]
        [string] $FileName,
        [Parameter(Mandatory = $true)]
        [ValidateSet("SHA256", "SHA512")]
        [Alias("Type")]
        [string] $HashType
    )

    $tempFile = Join-Path -Path $env:TEMP_DIR -ChildPath ([System.IO.Path]::GetRandomFileName())
    $checksums = (Invoke-DownloadWithRetry -Url $Url -Path $tempFile | Get-Item | Get-Content) -as [string[]]
    Remove-Item -Path $tempFile

    $matchedLine = $checksums | Where-Object { $_ -like "*$FileName*" }
    if ($matchedLine.Count -gt 1) {
        throw "Found multiple lines matching file name '${FileName}' in checksum file."
    } elseif ($matchedLine.Count -eq 0) {
        throw "File name '${FileName}' not found in checksum file."
    }

    if ($HashType -eq "SHA256") {
        $pattern = "[A-Fa-f0-9]{64}"
    } elseif ($HashType -eq "SHA512") {
        $pattern = "[A-Fa-f0-9]{128}"
    } else {
        throw "Unknown hash type: ${HashType}"
    }
    Write-Debug "Found line matching file name '${FileName}' in checksum file:`n${matchedLine}"

    $hash = $matchedLine | Select-String -Pattern $pattern | ForEach-Object { $_.Matches.Value }
    if ([string]::IsNullOrEmpty($hash)) {
        throw "Found '${FileName}' in checksum file, but failed to get hash from it.`nLine: ${matchedLine}"
    }
    Write-Host "Found hash for ${FileName} in checksum file: $hash"

    return $hash
}

function Test-FileChecksum {
    <#
    .SYNOPSIS
        Verifies the checksum of a file.

    .DESCRIPTION
        The Test-FileChecksum function verifies the SHA256 or SHA512 checksum of a file against an expected value. 
        If the checksum does not match the expected value, the function throws an error.

    .PARAMETER Path
        The path to the file for which to verify the checksum.

    .PARAMETER ExpectedSHA256Sum
        The expected SHA256 checksum. If this parameter is provided, the function will calculate the SHA256 checksum of the file and compare it to this value.

    .PARAMETER ExpectedSHA512Sum
        The expected SHA512 checksum. If this parameter is provided, the function will calculate the SHA512 checksum of the file and compare it to this value.

    .EXAMPLE
        Test-FileChecksum -Path "C:\temp\file.txt" -ExpectedSHA256Sum "ABC123"

        Verifies that the SHA256 checksum of the file at C:\temp\file.txt is ABC123.

    .EXAMPLE
        Test-FileChecksum -Path "C:\temp\file.txt" -ExpectedSHA512Sum "DEF456"

        Verifies that the SHA512 checksum of the file at C:\temp\file.txt is DEF456.

    #>

    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Path,
        [Parameter(Mandatory = $false)]
        [String] $ExpectedSHA256Sum,
        [Parameter(Mandatory = $false)]
        [String] $ExpectedSHA512Sum
    )

    Write-Verbose "Performing checksum verification"

    if ($ExpectedSHA256Sum -and $ExpectedSHA512Sum) {
        throw "Only one of the ExpectedSHA256Sum and ExpectedSHA512Sum parameters can be provided"
    }

    if (-not (Test-Path $Path)) {
        throw "File not found: $Path"
    }

    if ($ExpectedSHA256Sum) {
        $fileHash = (Get-FileHash -Path $Path -Algorithm SHA256).Hash
        $expectedHash = $ExpectedSHA256Sum
    }

    if ($ExpectedSHA512Sum) {
        $fileHash = (Get-FileHash -Path $Path -Algorithm SHA512).Hash
        $expectedHash = $ExpectedSHA512Sum
    }

    if ($fileHash -ne $expectedHash) {
        throw "Checksum verification failed: expected $expectedHash, got $fileHash"
    } else {
        Write-Verbose "Checksum verification passed"
    }
}

function Test-FileSignature {
    <#
    .SYNOPSIS
        Tests the file signature of a given file.

    .DESCRIPTION
        The Test-FileSignature function checks the signature of a file against the expected thumbprints. 
        It uses the Get-AuthenticodeSignature cmdlet to retrieve the signature information of the file.
        If the signature status is not valid or the thumbprint does not match the expected thumbprints, an exception is thrown.

    .PARAMETER Path
        Specifies the path of the file to test.

    .PARAMETER ExpectedThumbprint
        Specifies the expected thumbprints to match against the file's signature.

    .EXAMPLE
        Test-FileSignature -Path "C:\Path\To\File.exe" -ExpectedThumbprint "A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R8S9T0"

        This example tests the signature of the file "C:\Path\To\File.exe" against the expected thumbprint "A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R8S9T0".

    #>

    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Path,
        [Parameter(Mandatory = $true)]
        [string[]] $ExpectedThumbprint
    )

    $signature = Get-AuthenticodeSignature $Path

    if ($signature.Status -ne "Valid") {
        throw "Signature status is not valid. Status: $($signature.Status)"
    }

    foreach ($thumbprint in $ExpectedThumbprint) {
        if ($signature.SignerCertificate.Thumbprint.Contains($thumbprint)) {
            Write-Output "Signature for $Path is valid"
            $signatureMatched = $true
            return
        }
    }

    if ($signatureMatched) {
        Write-Output "Signature for $Path is valid"
    } else {
        throw "Signature thumbprint do not match expected."
    }
}

function Update-Environment {
    <#
    .SYNOPSIS
        Updates the environment variables by reading values from the registry.

    .DESCRIPTION
        This function updates current environment by reading values from the registry.
        It is useful when you need to update the environment variables without restarting the current session.

    .NOTES
        The function requires administrative privileges to modify the system registry.
    #>

    $locations = @(
        'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
        'HKCU:\Environment'
    )

    # Update PATH variable
    $pathItems = $locations | ForEach-Object {
        (Get-Item $_).GetValue('PATH').Split(';')
    } | Select-Object -Unique
    $env:PATH = $pathItems -join ';'

    # Update other variables
    $locations | ForEach-Object {
        $key = Get-Item $_
        foreach ($name in $key.GetValueNames()) {
            $value = $key.GetValue($name)
            if (-not ($name -ieq 'PATH')) {
                Set-Item -Path Env:$name -Value $value
            }
        }
    }
}
