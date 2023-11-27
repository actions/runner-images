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
        $filePath = Invoke-DownloadWithRetry -Url $Url -Path "${env:Temp}\$fileName"
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
        $Path = Join-Path -Path "${env:Temp}" -ChildPath $fileName
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
    | Sort-Object -Property { [version] $_.name } -Descending `
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
    $releases = $releases | Sort-Object -Descending { [version] $_.version }

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

function Get-HashFromGitHubReleaseBody {
    param (
        [string] $RepoOwner,
        [string] $RepoName,
        [Parameter(Mandatory = $true)]
        [string] $FileName,
        [string] $Url,
        [string] $Version = "latest",
        [boolean] $IsPrerelease = $false,
        [int] $SearchInCount = 100,
        [string] $Delimiter = '|',
        [int] $WordNumber = 1
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
    $Env:PATH = $pathItems -join ';'

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
