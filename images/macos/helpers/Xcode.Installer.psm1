Import-Module "$PSScriptRoot/Xcode.Helpers.psm1"

function Install-XcodeVersion {
    param(
        [Parameter(Mandatory)]
        [string]$Version,
        [Parameter(Mandatory)]
        [string]$LinkTo
    )

    $xcodeDownloadDirectory = "$env:HOME/Library/Caches/XcodeInstall"
    $xcodeTargetPath = Get-XcodeRootPath -Version $LinkTo
    $xcodeXipDirectory = Invoke-DownloadXcodeArchive -DownloadDirectory $xcodeDownloadDirectory -Version $Version
    Expand-XcodeXipArchive -DownloadDirectory $xcodeXipDirectory -TargetPath $xcodeTargetPath

    Remove-Item -Path $xcodeXipDirectory -Force -Recurse
}

function Invoke-DownloadXcodeArchive {
    param(
        [Parameter(Mandatory)]
        [string]$DownloadDirectory,
        [Parameter(Mandatory)]
        [string]$Version
    )

    $resolvedVersion = Resolve-ExactXcodeVersion -Version $Version
    if (-not $resolvedVersion) {
        throw "Version '$Version' can't be matched to any available version"
    }
    Write-Host "Downloading Xcode $resolvedVersion"
    Invoke-XCVersion -Arguments "install '$resolvedVersion' --no-install" | Out-Host    

    $xcodeXipName = "$resolvedVersion" -replace " ", "_"
    $xcodeXipFile = Get-ChildItem -Path $DownloadDirectory -Filter "Xcode_$xcodeXipName.xip" | Select-Object -First 1
    $tempXipDirectory = New-Item -Path $DownloadDirectory -Name "Xcode$xcodeXipName" -ItemType "Directory"
    Move-Item -Path "$xcodeXipFile" -Destination $tempXipDirectory

    return $tempXipDirectory

}

function Resolve-ExactXcodeVersion {
    param(
        [Parameter(Mandatory)]
        [string]$Version
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
    param(
        [Parameter(Mandatory)]
        [string]$DownloadDirectory,
        [Parameter(Mandatory)]
        [string]$TargetPath
    )

    $xcodeXipPath = Get-ChildItem -Path $DownloadDirectory -Filter "Xcode_*.xip" | Select-Object -First 1

    Write-Host "Extracting Xcode from '$xcodeXipPath'"
    Push-Location $DownloadDirectory
    Invoke-ValidateCommand "xip -x $xcodeXipPath"
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
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    $XcodeRootPath = Get-XcodeRootPath -Version $Version
    if (Test-XcodeStableRelease -XcodeRootPath $XcodeRootPath) {
        Write-Host "Validating Xcode integrity for '$XcodeRootPath'..."
        Invoke-ValidateCommand "spctl --assess --raw $XcodeRootPath"
    }
}

function Approve-XcodeLicense {
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    $XcodeRootPath = Get-XcodeRootPath -Version $Version
    Write-Host "Approving Xcode license for '$XcodeRootPath'..."
    $xcodeBuildPath = Get-XcodeToolPath -XcodeRootPath $XcodeRootPath -ToolName "xcodebuild"
    Invoke-ValidateCommand "sudo $xcodeBuildPath -license accept"
}

function Install-XcodeAdditionalPackages {
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    Write-Host "Installing additional packages for Xcode $Version..."
    $xcodeRootPath = Get-XcodeRootPath -Version $Version
    $packages = Get-ChildItem -Path "$xcodeRootPath/Contents/Resources/Packages" -Filter "*.pkg" -File
    $packages | ForEach-Object {
        Invoke-ValidateCommand "sudo installer -pkg $($_.FullName) -target / -allowUntrusted"
    }
}

function Invoke-XcodeRunFirstLaunch {
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    if ($Version.StartsWith("8") -or $Version.StartsWith("9")) {
        return
    }

    Write-Host "Running 'runFirstLaunch' for Xcode $Version..."
    $xcodeRootPath = Get-XcodeToolPath -Version $Version -ToolName "xcodebuild"
    Invoke-ValidateCommand "sudo $xcodeRootPath -runFirstLaunch"
}

function Build-XcodeSymlinks {
    param(
        [Parameter(Mandatory)]
        [string]$Version,
        [string[]]$Symlinks
    )

    $sourcePath = Get-XcodeRootPath -Version $Version
    $Symlinks | Where-Object { $_ } | ForEach-Object {
        $targetPath = Get-XcodeRootPath -Version $_
        Write-Host "Creating symlink: '$targetPath' -> '$sourcePath'"
        New-Item -Path $targetPath -ItemType SymbolicLink -Value $sourcePath | Out-Null
    }
}

function Build-ProvisionatorSymlink {
    param(
        [Parameter(Mandatory)]
        [string]$Version
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
    param(
        [Parameter(Mandatory)]
        [string[]]$XcodeList
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