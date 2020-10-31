Import-Module "$PSScriptRoot/Xcode.Helpers.psm1"

function Install-XcodeVersion {
    param(
        [Parameter(Mandatory)]
        [string]$Version,
        [Parameter(Mandatory)]
        [string]$LocalLink
    )

    $xcodeDownloadDirectory = "$env:HOME/Library/Caches/XcodeInstall"
    $xcodeTargetPath = Get-XcodeRootPath -Version $LocalLink
    Push-Location $xcodeDownloadDirectory

    Invoke-DownloadXcodeArchive -Version $Version
    Expand-XcodeXipArchive -DownloadDirectory $xcodeDownloadDirectory -TargetPath $xcodeTargetPath
    Confirm-XcodeIntegrity -XcodeRootPath $xcodeTargetPath
    Approve-XcodeLicense -XcodeRootPath $xcodeTargetPath

    Get-ChildItem $xcodeDownloadDirectory | Remove-Item -Force
}

function Invoke-DownloadXcodeArchive {
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    $resolvedVersion = Resolve-ExactXcodeVersion -Version $Version
    if (-not $resolvedVersion) {
        throw "Version '$Version' can't be matched to any available version"
    }

    # TO-DO: Consider replacing of xcversion with own implementation
    Write-Host "Downloading Xcode $resolvedVersion"
    xcversion install "$resolvedVersion" --no-install
}

function Resolve-ExactXcodeVersion {
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    # TO-DO
    return $Version
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
    xip -x $xcodeXipPath
    Pop-Location

    if (Test-Path "$DownloadDirectory/Xcode-beta.app") {
        Write-Host "Renaming Xcode-beta.app to Xcode.app"
        Rename-File -Path "$DownloadDirectory/Xcode-beta.app" -NewName "Xcode.app"
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
        [string]$XcodeRootPath
    )

    if (Test-XcodeStableRelease -XcodeRootPath $XcodeRootPath) {
        spctl --assess --raw $XcodeRootPath
    }
}

function Approve-XcodeLicense {
    param(
        [Parameter(Mandatory)]
        $XcodeRootPath
    )

    $xcodeBuildPath = Get-XcodeToolPath -XcodeRootPath $XcodeRootPath -ToolName "xcodebuild"
    sudo $xcodeBuildPath -license accept
}

function Install-XcodeAdditionalPackages {
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    Write-Host "Installing additional packages for Xcode $Version..."
    $xcodeRootPath = Get-XcodeRootPath -Version $Version
    $packages = Get-ChildItem -Path "$xcodeRootPath/Contents/Resources/Packages" -Filter "*.pkg" -Name -File
    $packages | ForEach-Object { & sudo installer -pkg $_ -target / -allowUntrusted }
}

function Invoke-XcodeRunFirstLaunch {
    param(
        [Parameter(Mandatory)]
        [string]$Version
    )

    if ($Version.StartsWith("8.") -or $Version.StartsWith("9.")) {
        return
    }

    Write-Host "Running 'runFirstLaunch' for Xcode $Version..."
    $xcodeRootPath = Get-XcodeToolPath -Version $Version -ToolName "xcodebuild"
    & sudo $xcodeRootPath -runFirstLaunch
}

function Build-XcodeSymlinks {
    param(
        [Parameter(Mandatory)]
        [string]$Version,
        [Parameter(Mandatory)]
        [string[]]$Symlinks
    )

    $sourcePath = Get-XcodeRootPath -Version $Version
    $Symlinks | ForEach-Object {
        $targetPath = Get-XcodeRootPath -Version $_
        Write-Host "Creating symlink: '$targetPath' -> '$sourcePath'"
        New-Item -Path $targetPath -ItemType SymbolicLink -Value $sourcePath
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
        Write-Host "Creating provisionator symlink: '$targetPath' -> '$sourcePath'"
        New-Item -Path $targetPath -ItemType SymbolicLink -Value $sourcePath
    }
}

function Set-XcodeDeveloperDirEnvironmentVariables {
    # TO-DO
}