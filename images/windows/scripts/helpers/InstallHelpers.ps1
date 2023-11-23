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

function Stop-SvcWithErrHandling {
    <#
    .DESCRIPTION
        Function for stopping the Windows Service with error handling

    .PARAMETER ServiceName
        The name of stopping service

    .PARAMETER StopOnError
        Switch for stopping the script and exit from PowerShell if one service is absent
    #>
    Param (
        [Parameter(Mandatory, ValueFromPipeLine = $true)]
        [string] $ServiceName,
        [switch] $StopOnError
    )

    Process {
        $service = Get-Service $ServiceName -ErrorAction SilentlyContinue
        if (-not $service) {
            Write-Warning "[!] Service [$ServiceName] is not found"
            if ($StopOnError) {
                exit 1
            }
        } else {
            Write-Host "Try to stop service [$ServiceName]"
            try {
                Stop-Service -Name $ServiceName -Force
                $service.WaitForStatus("Stopped", "00:01:00")
                Write-Host "Service [$ServiceName] has been stopped successfuly"
            } catch {
                Write-Error "[!] Failed to stop service [$ServiceName] with error:"
                $_ | Out-String | Write-Error
            }
        }
    }
}

function Set-SvcWithErrHandling {
    <#
    .DESCRIPTION
        Function for setting the Windows Service parameter with error handling

    .PARAMETER ServiceName
        The name of stopping service

    .PARAMETER Arguments
        Hashtable for service arguments

    .PARAMETER StopOnError
        Switch for stopping the script and exit from PowerShell if one service is absent
    #>

    Param (
        [Parameter(Mandatory, ValueFromPipeLine = $true)]
        [string] $ServiceName,
        [Parameter(Mandatory)]
        [hashtable] $Arguments,
        [switch] $StopOnError
    )

    Process {
        $service = Get-Service $ServiceName -ErrorAction SilentlyContinue
        if (-not $service) {
            Write-Warning "[!] Service [$ServiceName] is not found"
            if ($StopOnError) {
                exit 1
            }
        } else {
            try {
                Set-Service $serviceName @Arguments
            } catch {
                Write-Error "[!] Failed to set service [$ServiceName] arguments with error:"
                $_ | Out-String | Write-Error
            }
        }
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

    $extensionUri = $MarketplaceUri + $ExtensionMarketPlaceName
    $request = Invoke-SBWithRetry -Command { Invoke-WebRequest -Uri $extensionUri -UseBasicParsing } -RetryCount 20 -RetryIntervalSeconds 30
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
        "VsixId" = $vsixId
        "FileName" = $fileName
        "DownloadUri" = $downloadUri
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
        Write-Host ($instanceFolders | Out-String)
        Write-Host ($instanceFolders | Get-ChildItem | Out-String)
        Write-Host "More than one instance installed"
        exit 1
    }

    $stateContent = Get-Content -Path (Join-Path $instanceFolders.FullName '\state.packages.json')
    $state = $stateContent | ConvertFrom-Json
    $packageVersion = ($state.packages | Where-Object { $_.id -eq $packageName }).version

    if (-not $packageVersion)
    {
        Write-Host "Installed package $packageName for Visual Studio was not found"
        exit 1
    }

    return $packageVersion
}

function Get-ToolsetContent
{
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

function Get-WinVersion
{
    (Get-CimInstance -ClassName Win32_OperatingSystem).Caption
}

function Test-IsWin22
{
    (Get-WinVersion) -match "2022"
}

function Test-IsWin19
{
    (Get-WinVersion) -match "2019"
}

function Expand-7ZipArchive {
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [Parameter(Mandatory=$true)]
        [string]$DestinationPath,
        [ValidateSet("x", "e")]
        [char]$ExtractMethod = "x"
    )

    Write-Host "Expand archive '$PATH' to '$DestinationPath' directory"
    7z.exe $ExtractMethod "$Path" -o"$DestinationPath" -y | Out-Null

    if ($LASTEXITCODE -ne 0)
    {
        Write-Host "There is an error during expanding '$Path' to '$DestinationPath' directory"
        exit 1
    }
}

function Install-AndroidSDKPackages {
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$AndroidSDKManagerPath,
        [Parameter(Mandatory=$true)]
        [string]$AndroidSDKRootPath,
        [Parameter(Mandatory=$true)]
        [AllowEmptyCollection()]
        [string[]]$AndroidPackages,
        [string] $PrefixPackageName
    )

    foreach ($package in $AndroidPackages) {
        & $AndroidSDKManagerPath --sdk_root=$AndroidSDKRootPath "$PrefixPackageName$package"
    }
}

function Get-AndroidPackages {
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$AndroidSDKManagerPath
    )

    $packagesListFile = "C:\Android\android-sdk\packages-list.txt"

    if (-Not (Test-Path -Path $packagesListFile -PathType Leaf)) {
        (cmd /c "$AndroidSDKManagerPath --list --verbose 2>&1") |
        Where-Object { $_ -Match "^[^\s]" } |
        Where-Object { $_ -NotMatch "^(Loading |Info: Parsing |---|\[=+|Installed |Available )" } |
        Where-Object { $_ -NotMatch "^[^;]*$" } |
        Out-File -FilePath $packagesListFile
    }

    return Get-Content $packagesListFile
}

function Get-AndroidPackagesByName {
    Param (
        [Parameter(Mandatory=$true)]
        [string[]]$AndroidPackages,
        [Parameter(Mandatory=$true)]
        [string]$PrefixPackageName
    )

    return $AndroidPackages | Where-Object { "$_".StartsWith($PrefixPackageName) }
}

function Get-AndroidPackagesByVersion {
    Param (
        [Parameter(Mandatory=$true)]
        [string[]]$AndroidPackages,
        [Parameter(Mandatory=$true)]
        [string]$PrefixPackageName,
        [object]$MinimumVersion,
        [char]$Delimiter,
        [int]$Index = 0
    )

    $Type = $MinimumVersion.GetType()
    $packagesByName = Get-AndroidPackagesByName -AndroidPackages $AndroidPackages -PrefixPackageName $PrefixPackageName
    $packagesByVersion = $packagesByName | Where-Object { ($_.Split($Delimiter)[$Index] -as $Type) -ge $MinimumVersion }
    return $packagesByVersion | Sort-Object -Unique
}

function Get-WindowsUpdatesHistory {
    $allEvents = @{}
    # 19 - Installation Successful: Windows successfully installed the following update
    # 20 - Installation Failure: Windows failed to install the following update with error
    # 43 - Installation Started: Windows has started installing the following update
    $filter = @{
        LogName = "System"
        Id = 19, 20, 43
        ProviderName = "Microsoft-Windows-WindowsUpdateClient"
    }
    $events = Get-WinEvent -FilterHashtable $filter -ErrorAction SilentlyContinue | Sort-Object Id

    foreach ( $event in $events ) {
        switch ( $event.Id ) {
            19 {
                $status = "Successful"
                $title = $event.Properties[0].Value
                $allEvents[$title] = ""
                break
            }
            20 {
                $status = "Failure"
                $title = $event.Properties[1].Value
                $allEvents[$title] = ""
                break
            }
            43 {
                $status = "InProgress"
                $title = $event.Properties[0].Value
                break
            }
        }

        if ( $status -eq "InProgress" -and $allEvents.ContainsKey($title) ) {
            continue
        }

        [PSCustomObject]@{
            Status = $status
            Title = $title
        }
    }
}

function Invoke-SBWithRetry {
    param (
        [scriptblock] $Command,
        [int] $RetryCount = 10,
        [int] $RetryIntervalSeconds = 5
    )

    while ($RetryCount -gt 0) {
        try {
            & $Command
            return
        }
        catch {
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

function Get-GitHubPackageDownloadUrl {
    param (
        [string]$RepoOwner,
        [string]$RepoName,
        [string]$BinaryName,
        [string]$Version,
        [string]$UrlFilter,
        [boolean]$IsPrerelease = $false,
        [boolean]$LatestReleaseOnly = $true,
        [int]$SearchInCount = 100
    )

    if ($Version -eq "latest") {
        $Version = "*"
    }

    $json = Invoke-RestMethod -Uri "https://api.github.com/repos/${RepoOwner}/${RepoName}/releases?per_page=${SearchInCount}"
    $tags = $json.Where{ $_.prerelease -eq $IsPrerelease -and $_.assets }.tag_name
    $availableVersions = $tags |
        Select-String -Pattern "\d+.\d+.\d+" |
        ForEach-Object { $_.Matches.Value } |
        Where-Object { $_ -like "$Version.*" -or $_ -eq $Version } |
        Sort-Object -Descending { [version]$_ }

    if (-not $availableVersions) {
        throw "Failed to get available versions from ${RepoOwner}/${RepoName} releases"
    }

    if ($LatestReleaseOnly) {
        $latestVersion = $availableVersions | Select-Object -First 1
        $urlFilterReplaced = $UrlFilter -replace "{BinaryName}", $BinaryName -replace "{Version}", $latestVersion
        $downloadUrl = $json.assets.browser_download_url -like $urlFilterReplaced
    } else {
        foreach ($version in $availableVersions) {
            $urlFilterReplaced = $UrlFilter -replace "{BinaryName}", $BinaryName -replace "{Version}", $version
            $downloadUrl = $json.assets.browser_download_url -like $urlFilterReplaced

            if ($downloadUrl) {
                Write-Host "Found download url for ${RepoOwner}/${RepoName} ${BinaryName} ${version}"
                break
            }
        }
    }

    if (-not $downloadUrl) {
        throw "Failed to get download url for ${RepoOwner}/${RepoName} ${BinaryName}"
    }

    return $downloadUrl
}

function Use-ChecksumComparison {
    param (
        [Parameter(Mandatory=$true)]
        [string]$LocalFileHash,
        [Parameter(Mandatory=$true)]
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
        [Parameter(Mandatory=$true)]
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
    $body = (Invoke-RestMethod -Uri $releaseUrl).body -replace('`', "") -join "`n"
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
        [Parameter(Mandatory=$true)]
        [string]$FilePath,
        [Parameter(Mandatory=$true)]
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
    }
    else {
        throw "Signature thumbprint do not match expected."
    }
}
