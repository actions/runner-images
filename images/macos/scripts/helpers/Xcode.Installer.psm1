Import-Module "$PSScriptRoot/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/Xcode.Helpers.psm1"

function Install-XcodeVersion {
    param (
        [Parameter(Mandatory)]
        [string] $Version,
        [Parameter(Mandatory)]
        [string] $LinkTo,
        [Parameter(Mandatory)]
        [string] $Sha256Sum
    )

    $xcodeDownloadDirectory = "$env:HOME/Library/Caches/XcodeInstall"
    $xcodeTargetPath = Get-XcodeRootPath -Version $LinkTo
    $xcodeXipDirectory = Invoke-DownloadXcodeArchive -DownloadDirectory $xcodeDownloadDirectory -Version $Version
    Expand-XcodeXipArchive -DownloadDirectory $xcodeXipDirectory.FullName -TargetPath $xcodeTargetPath
    Remove-Item -Path $xcodeXipDirectory -Force -Recurse
}

function Invoke-DownloadXcodeArchive {
    param (
        [Parameter(Mandatory)]
        [string] $DownloadDirectory,
        [Parameter(Mandatory)]
        [string] $Version
    )

    Write-Host "Downloading Xcode $Version"
    $tempXipDirectory = New-Item -Path $DownloadDirectory -Name "Xcode$Version" -ItemType "Directory"
    $xcodeFileName = 'Xcode-{0}.xip' -f $Version
    $xcodeUri = '{0}{1}?{2}'-f ${env:XCODE_INSTALL_STORAGE_URL}, $xcodeFileName, ${env:XCODE_INSTALL_SAS}
    $xcodeFullPath = Join-Path $tempXipDirectory.FullName $xcodeFileName
    Invoke-DownloadWithRetry -Url $xcodeUri -Path $xcodeFullPath | Out-Null

    # Validating checksum
    $xcodeSha256 = Get-FileHash -Path $xcodeFullPath -Algorithm SHA256 | Select-Object -ExpandProperty Hash
    if ($xcodeSha256 -ne $Sha256Sum) {
        throw "Xcode $Version checksum mismatch. Expected: $Sha256Sum, Actual: $xcodeSha256"
    }

    return $tempXipDirectory
}

function Resolve-ExactXcodeVersion {
    param (
        [Parameter(Mandatory)]
        [string] $Version
    )

    # if toolset string contains spaces, consider it as a full name of Xcode
    if ($Version -match "\s") {
        return $Version
    }

    $semverVersion = [SemVer]::Parse($Version)
    $availableVersions = Get-AvailableXcodeVersions
    $satisfiedVersions = $availableVersions | Where-Object { $semverVersion -eq $_.stableSemver }

    return $satisfiedVersions | Select-Object -Last 1 -ExpandProperty rawVersion
}

function Get-AvailableXcodeVersions {
    $rawVersionsList = Invoke-XCVersion -Arguments "list" | ForEach-Object { $_.Trim() } | Where-Object { $_ -match "^\d" }
    $availableVersions = $rawVersionsList | ForEach-Object {
        $partStable,$partMajor = $_.Split(" ", 2)
        $semver = $stableSemver = [SemVer]::Parse($partStable)

        if ($partMajor) {
            # Convert 'beta 3' -> 'beta.3', 'Release Candidate' -> 'releasecandidate', 'GM Seed 2' -> 'gmseed.2'
            $normalizedLabel = $partMajor.toLower() -replace " (\d)", '.$1' -replace " ([a-z])", '$1'
            $semver = [SemVer]::new($stableSemver.Major, $stableSemver.Minor, $stableSemver.Patch, $normalizedLabel)
        }

        return [PSCustomObject]@{
            semver = $semver
            rawVersion = $_
            stableSemver = $stableSemver
        }
    }

    return $availableVersions | Sort-Object -Property semver
}

function Expand-XcodeXipArchive {
    param (
        [Parameter(Mandatory)]
        [string] $DownloadDirectory,
        [Parameter(Mandatory)]
        [string] $TargetPath
    )

    $xcodeXipPath = Get-ChildItem -Path $DownloadDirectory -Filter "Xcode-*.xip" | Select-Object -First 1

    Write-Host "Extracting Xcode from '$xcodeXipPath'"
    Push-Location $DownloadDirectory
    if ([boolean] (Get-Command 'unxip' -ErrorAction 'SilentlyContinue')) {
        Invoke-ValidateCommand "unxip $xcodeXipPath"
    } else {
        Invoke-ValidateCommand "xip -x $xcodeXipPath"
    }
    Pop-Location

    if (Test-Path "$DownloadDirectory/Xcode-beta.app") {
        Write-Host "Renaming Xcode-beta.app to Xcode.app"
        Rename-Item -Path "$DownloadDirectory/Xcode-beta.app" -NewName "Xcode.app"
    }

    if (-not (Test-Path "$DownloadDirectory/Xcode.app")) {
        throw "XIP archive '$xcodeXipPath' doesn't contain 'Xcode.app'"
    }

    Write-Host "Moving '$DownloadDirectory/Xcode.app' to '$TargetPath'"
    Move-Item -Path "$DownloadDirectory/Xcode.app" -Destination $TargetPath
}

function Confirm-XcodeIntegrity {
    param (
        [Parameter(Mandatory)]
        [string] $Version
    )

    $XcodeRootPath = Get-XcodeRootPath -Version $Version
    if (Test-XcodeStableRelease -XcodeRootPath $XcodeRootPath) {
        Write-Host "Validating Xcode integrity for '$XcodeRootPath'..."
        Invoke-ValidateCommand "spctl --assess --raw $XcodeRootPath"
    }
}

function Approve-XcodeLicense {
    param (
        [Parameter(Mandatory)]
        [string] $Version
    )

    $os = Get-OSVersion
    $XcodeRootPath = Get-XcodeRootPath -Version $Version
    Write-Host "Approving Xcode license for '$XcodeRootPath'..."
    $xcodeBuildPath = Get-XcodeToolPath -XcodeRootPath $XcodeRootPath -ToolName "xcodebuild"

    if ($os.IsVentura -or $os.IsSonoma) {
        Invoke-ValidateCommand -Command "sudo $xcodeBuildPath -license accept" -Timeout 15
    } else {
        Invoke-ValidateCommand -Command "sudo $xcodeBuildPath -license accept"
    }
}

function Install-XcodeAdditionalPackages {
    param (
        [Parameter(Mandatory)]
        [string] $Version
    )

    Write-Host "Installing additional packages for Xcode $Version..."
    $xcodeRootPath = Get-XcodeRootPath -Version $Version
    $packages = Get-ChildItem -Path "$xcodeRootPath/Contents/Resources/Packages" -Filter "*.pkg" -File
    $packages | ForEach-Object {
        Invoke-ValidateCommand "sudo installer -pkg $($_.FullName) -target / -allowUntrusted"
    }
}

function Invoke-XcodeRunFirstLaunch {
    param (
        [Parameter(Mandatory)]
        [string] $Version
    )

    Write-Host "Running 'runFirstLaunch' for Xcode $Version..."
    $xcodeRootPath = Get-XcodeToolPath -Version $Version -ToolName "xcodebuild"
    Invoke-ValidateCommand "sudo $xcodeRootPath -runFirstLaunch"
}

function Install-AdditionalSimulatorRuntimes {
    param (
        [Parameter(Mandatory)]
        [string] $Version,
        [Parameter(Mandatory)]
        [string] $Arch,
        [Parameter(Mandatory)]
        [object] $Runtimes
    )

    Write-Host "Installing Simulator Runtimes for Xcode $Version ..."
    $xcodebuildPath = Get-XcodeToolPath -Version $Version -ToolName 'xcodebuild'
    $validRuntimes = @("iOS", "watchOS", "tvOS")

    # visionOS is only available on arm64
    if ($Arch -eq "arm64") {
        $validRuntimes += "visionOS"
    }

    # Install all runtimes / skip runtimes
    if ($Runtimes -eq "default") {
        Write-Host "Installing all runtimes for Xcode $Version ..."
        Invoke-ValidateCommand "sudo $xcodebuildPath -downloadAllPlatforms" | Out-Null
        return
    } elseif ($Runtimes -eq "none") {
        Write-Host "Skipping runtimes installation for Xcode $Version ..."
        return
    }

    # Convert $Runtimes to hashtable
    if ($Runtimes -is [System.Object[]]) {
        $convertedRuntimes = @{}

        foreach ($entry in $Runtimes) {
            if ($entry -is [PSCustomObject]) {
                $entry = $entry | ConvertTo-Json -Compress | ConvertFrom-Json -AsHashtable
            }
            
            # Copy all keys and values from the entry to the converted runtimes
            foreach ($key in $entry.Keys) {
                if ($convertedRuntimes.ContainsKey($key)) {
                    $convertedRuntimes[$key] += $entry[$key]
                } else {
                    $convertedRuntimes[$key] = $entry[$key]
                }
            }
        }
        $Runtimes = $convertedRuntimes
    }

    # Validate runtimes format
    if ($Runtimes -isnot [System.Collections.Hashtable]) {
        throw "Invalid runtime format for Xcode $(Version): Expected hashtable, got [$($Runtimes.GetType())]"
    }

    # Install runtimes for specified platforms
    foreach ($platform in $validRuntimes) {        
        if (-not $Runtimes.ContainsKey($platform)) {
            Write-Host "No runtimes specified for $platform in the toolset for Xcode $Version, please check the toolset."
            return
        }
        foreach ($platformVersion in $Runtimes[$platform]) {
            switch ($platformVersion) {
                "skip" {
                    Write-Host "Skipping $platform runtimes installation for Xcode $Version ..."
                    continue
                }
                "default" {
                    Write-Host "Installing default $platform runtime for Xcode $Version ..."
                    Invoke-ValidateCommand "sudo $xcodebuildPath -downloadPlatform $platform" | Out-Null
                    continue
                }
                default {
                    # Version might be a semver or a build number
                    if (($platformVersion -match "^\d{1,2}\.\d(\.\d)?$") -or ($platformVersion -match "^[a-zA-Z0-9]{6,8}$")) {
                        Write-Host "Installing $platform $platformVersion runtime for Xcode $Version ..."
                        Invoke-ValidateCommand "sudo $xcodebuildPath -downloadPlatform $platform -buildVersion $platformVersion" | Out-Null
                        continue
                    }
                    throw "$platformVersion is not a valid value for $platform version. Valid values are 'latest' or 'skip' or a semver from 0.0 to 99.9.(9)."
                }
            }
        }
    }
}

function Build-XcodeSymlinks {
    param (
        [Parameter(Mandatory)]
        [string] $Version,
        [string[]] $Symlinks
    )

    $sourcePath = Get-XcodeRootPath -Version $Version
    $Symlinks | Where-Object { $_ } | ForEach-Object {
        $targetPath = Get-XcodeRootPath -Version $_
        Write-Host "Creating symlink: '$targetPath' -> '$sourcePath'"
        New-Item -Path $targetPath -ItemType SymbolicLink -Value $sourcePath | Out-Null
    }
}

function Initialize-XcodeLaunchServicesDb {
    param (
        [Parameter(Mandatory)]
        [string] $Version
    )

    $xcodePath = Get-XcodeRootPath -Version $Version
    $lsregister = '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'
    Get-ChildItem -Recurse -Filter "*.app" $xcodePath | Foreach-Object { & $lsregister -f $_.FullName}
}

function Build-ProvisionatorSymlink {
    param (
        [Parameter(Mandatory)]
        [string] $Version
    )

    $sourcePath = Get-XcodeRootPath -Version $Version
    $versionInfo = Get-XcodeVersionInfo -XcodeRootPath $sourcePath

    $targetVersion = [SemVer]::Parse($versionInfo.Version).ToString()
    $targetPath = Get-XcodeRootPath -Version $targetVersion
    if ($sourcePath -ne $targetPath) {
        Write-Host "Creating symlink: '$targetPath' -> '$sourcePath'"
        New-Item -Path $targetPath -ItemType SymbolicLink -Value $sourcePath | Out-Null
    }
}

function Set-XcodeDeveloperDirEnvironmentVariables {
    param (
        [Parameter(Mandatory)]
        [string[]] $XcodeList
    )

    $exactVersionsList = $XcodeList | Where-Object { Test-XcodeStableRelease -Version $_ } | ForEach-Object {
        $xcodeRootPath = Get-XcodeRootPath -Version $_
        $xcodeVersionInfo = Get-XcodeVersionInfo -XcodeRootPath $xcodeRootPath
        return @{
            RootPath = $xcodeRootPath
            Version = [SemVer]::Parse($xcodeVersionInfo.Version)
        }
    } | Sort-Object -Property Version -Descending

    $majorVersions = $exactVersionsList.Version.Major | Select-Object -Unique
    $majorVersions | ForEach-Object {
        $majorVersion = $_
        $latestXcodeVersion = $exactVersionsList | Where-Object { $_.Version.Major -eq $majorVersion } | Select-Object -First 1
        $variableName = "XCODE_${_}_DEVELOPER_DIR"
        $variableValue = "$($latestXcodeVersion.RootPath)/Contents/Developer"
        Write-Host "Set ${variableName}=${variableValue}"
        "export ${variableName}=${variableValue}" | Out-File "$env:HOME/.bashrc" -Append
    }
}

function Invoke-ValidateCommand {
    param (
        [Parameter(Mandatory)]
        [string] $Command,
        [Uint] $Timeout = 0
    )

    if ($Timeout -eq 0) {
        $output = Invoke-Expression -Command $Command
        if ($LASTEXITCODE -ne 0) {
            throw "Command '$Command' has finished with exit code $LASTEXITCODE"
        }
        return $output
    } else {
        $job = $command | Start-Job -ScriptBlock {
            $output = Invoke-Expression -Command $input
            if ($LASTEXITCODE -ne 0) {
                  throw 'Command failed'
            }
            return $output
        }
        $waitObject = $job | Wait-Job -Timeout $Timeout

        if (-not $waitObject) {
             throw "Command '$Command' has timed out"
        }

        if ($waitObject.State -eq 'Failed') {
             throw "Command '$Command' has failed"
        }
        Receive-Job -Job $job
    }
}
