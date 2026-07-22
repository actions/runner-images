################################################################################
##  File:  Install-VisualStudio.ps1
##  Desc:  Install Visual Studio
################################################################################

# TODO: delete after Visual Studio size investigation is complete.
function Get-VisualStudioPackageSizeBytes {
    param(
        [Parameter(Mandatory = $true)]
        [psobject] $Package
    )

    $sizeCandidates = @(
        $Package.installSizes.targetDrive,
        $Package.installSizes.install,
        $Package.installSize,
        $Package.installedSize,
        $Package.size
    )

    foreach ($candidate in $sizeCandidates) {
        if ($candidate -is [ValueType] -and [int64]$candidate -gt 0) {
            return [int64]$candidate
        }
    }

    if ($Package.payloads) {
        $payloadSize = 0L
        foreach ($payload in $Package.payloads) {
            foreach ($propertyName in @('size', 'fileSize', 'filesize')) {
                $property = $payload.PSObject.Properties[$propertyName]
                if ($property -and $property.Value -is [ValueType]) {
                    $payloadSize += [int64]$property.Value
                    break
                }
            }
        }

        if ($payloadSize -gt 0) {
            return $payloadSize
        }
    }

    return $null
}

# TODO: delete after Visual Studio size investigation is complete.
function ConvertTo-ReadableByteSize {
    param(
        [Parameter(Mandatory = $true)]
        [Int64] $Bytes
    )

    $units = @('B', 'KB', 'MB', 'GB', 'TB')
    $size = [double]$Bytes
    $unitIndex = 0

    while ($size -ge 1024 -and $unitIndex -lt ($units.Count - 1)) {
        $size /= 1024
        $unitIndex++
    }

    return "{0:N2} {1}" -f $size, $units[$unitIndex]
}

# TODO: delete after Visual Studio size investigation is complete.
function Get-VisualStudioComponentSizeReport {
    $vsProgramData = Get-Item -Path 'C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances'
    $instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

    if ($instanceFolders -is [array]) {
        throw 'More than one instance installed'
    }

    $statePackagesPath = Join-Path $instanceFolders.FullName 'state.packages.json'
    $state = Get-Content -Path $statePackagesPath | ConvertFrom-Json
    $statePackagesById = @{}
    foreach ($package in $state.packages) {
        if ($package.id) {
            $statePackagesById[$package.id] = $package
        }
    }

    (Get-VisualStudioInstance).Packages `
    | Where-Object type -in 'Component', 'Workload' `
    | Sort-Object type, Id, Version `
    | Where-Object { $_.Id -notmatch '[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}' } `
    | ForEach-Object {
        $statePackage = $statePackagesById[$_.Id]
        $sizeBytes = $null
        if ($statePackage) {
            $sizeBytes = Get-VisualStudioPackageSizeBytes -Package $statePackage
        }

        [PSCustomObject]@{
            Type = $_.Type
            Package = $_.Id
            Version = $_.Version
            SizeBytes = $sizeBytes
            Size = if ($null -ne $sizeBytes) { ConvertTo-ReadableByteSize -Bytes $sizeBytes } else { 'N/A' }
        }
    }
}

# TODO: delete after Visual Studio size investigation is complete.
function Write-VisualStudioComponentSizeReport {
    $report = Get-VisualStudioComponentSizeReport

    Write-Host 'Visual Studio component/workload size report (installer metadata):'
    $report |
        Sort-Object Type, @{ Expression = { if ($null -ne $_.SizeBytes) { -1 * $_.SizeBytes } else { [Int64]::MinValue } } }, Package |
        Format-Table -AutoSize Type, Package, Version, Size |
        Out-Host

    $knownSizeTotal = ($report | Where-Object { $null -ne $_.SizeBytes } | Measure-Object -Property SizeBytes -Sum).Sum
    if ($knownSizeTotal) {
        Write-Host ("Total known size across reported packages: {0}" -f (ConvertTo-ReadableByteSize -Bytes $knownSizeTotal))
    }

    if (($report | Where-Object { $null -eq $_.SizeBytes }).Count -gt 0) {
        Write-Host 'Some packages do not expose size metadata and are reported as N/A.'
    }
}

$vsToolset = (Get-ToolsetContent).visualStudio

if (Test-IsArm64) {
    $vsArch = "arm64"
} else {
    $vsArch = "x64"
}

# Install Visual Studio for Windows 22 and 25 with InstallChannel
Install-VisualStudio `
    -Version $vsToolset.subversion `
    -Edition $vsToolset.edition `
    -Channel $vsToolset.channel `
    -InstallChannelUri $vsToolset.installChannelUri `
    -RequiredComponents $vsToolset.workloads `
    -ExtraArgs "--allWorkloads --includeRecommended --remove Component.CPython3.x64" `
    -Architecture $vsArch

# Find the version of VS installed for this instance
# Only supports a single instance
$vsProgramData = Get-Item -Path "C:\ProgramData\Microsoft\VisualStudio\Packages\_Instances"
$instanceFolders = Get-ChildItem -Path $vsProgramData.FullName

if ($instanceFolders -is [array]) {
    throw "More than one instance installed"
}

# Updating content of MachineState.json file to disable autoupdate of VSIX extensions
$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$newContent = '{"Extensions":[{"Key":"1e906ff5-9da8-4091-a299-5c253c55fdc9","Value":{"ShouldAutoUpdate":false}},{"Key":"Microsoft.VisualStudio.Web.AzureFunctions","Value":{"ShouldAutoUpdate":false}}],"ShouldAutoUpdate":false,"ShouldCheckForUpdates":false}'
Set-Content -Path "$vsInstallRoot\Common7\IDE\Extensions\MachineState.json" -Value $newContent

if (Test-IsWin22-X64) {
    # Install Windows 10 SDK version 10.0.17763
    Install-Binary -Type EXE `
    -Url 'https://go.microsoft.com/fwlink/p/?LinkID=2033908' `
    -InstallArgs @("/q", "/norestart", "/ceip off", "/features OptionId.UWPManaged OptionId.UWPCPP OptionId.UWPLocalized OptionId.DesktopCPPx86 OptionId.DesktopCPPx64 OptionId.DesktopCPParm64") `
    -ExpectedSubject $(Get-MicrosoftPublisher)
}

# Install Windows 11 SDK version 10.0.26100
Install-Binary -Type EXE `
    -Url 'https://go.microsoft.com/fwlink/?linkid=2349110' `
    -InstallArgs @("/q", "/norestart", "/ceip off", "/features OptionId.UWPManaged OptionId.UWPCPP OptionId.UWPLocalized OptionId.DesktopCPPx86 OptionId.DesktopCPPx64 OptionId.DesktopCPParm64") `
    -ExpectedSubject $(Get-MicrosoftPublisher)

# Enable Windows Desktop Debuggers (cdb.exe) on Windows Server 2025
if (Test-IsWin25-X64) {
    $installerEntry = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
        | Where-Object { $_.DisplayName -match "Windows Software Development Kit" } `
        | Sort-Object DisplayVersion -Descending | Select-Object -First 1
    
    if ($installerEntry -and $installerEntry.BundleCachePath) {
        Install-Binary -Type EXE `
            -LocalPath $installerEntry.BundleCachePath `
            -InstallArgs @("/features", "OptionId.WindowsDesktopDebuggers", "/q", "/norestart") `
            -ExpectedSubject $(Get-MicrosoftPublisher)
    }
}

Write-VisualStudioComponentSizeReport

Invoke-PesterTests -TestFile "VisualStudio"
