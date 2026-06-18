################################################################################
##  File:  Install-VisualStudio.ps1
##  Desc:  Install Visual Studio
################################################################################
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

if (-not (Test-IsWin22-X64)) {
# Install Windows 11 SDK version 10.0.28000
    Install-Binary -Type EXE `
    -Url 'https://go.microsoft.com/fwlink/?linkid=2366211' `
    -InstallArgs @("/q", "/norestart", "/ceip off", "/features OptionId.UWPManaged OptionId.UWPCPP OptionId.UWPLocalized OptionId.DesktopCPPx86 OptionId.DesktopCPPx64 OptionId.DesktopCPParm64") `
    -ExpectedSubject $(Get-MicrosoftPublisher)
}

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

# Log temporary directories size and free disk space
Write-Host "================================"
Write-Host "Temporary Directories Size Report"
Write-Host "================================"

$tempDirectories = @(
    "$env:SystemRoot\Temp",
    "$env:TEMP",
    "$env:SystemDrive\Users\$env:INSTALL_USER\AppData\Local\Temp"
)

function Get-DirectorySize {
    param(
        [string]$Path
    )
    
    if (-not (Test-Path $Path)) {
        return @{
            Path = $Path
            SizeGB = 0
            SizeMB = 0
            Exists = $false
        }
    }
    
    $size = (Get-ChildItem -Path $Path -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    $sizeGB = [math]::Round($size / 1GB, 2)
    $sizeMB = [math]::Round($size / 1MB, 2)
    
    return @{
        Path = $Path
        SizeGB = $sizeGB
        SizeMB = $sizeMB
        Exists = $true
    }
}

foreach ($dir in $tempDirectories) {
    $dirInfo = Get-DirectorySize -Path $dir
    if ($dirInfo.Exists) {
        Write-Host "Directory: $($dirInfo.Path)"
        Write-Host "  Size: $($dirInfo.SizeGB) GB ($($dirInfo.SizeMB) MB)"
    } else {
        Write-Host "Directory: $($dirInfo.Path) - NOT FOUND"
    }
}

# Log free disk space
Write-Host ""
Write-Host "Free Disk Space on System Drive"
Write-Host "================================"
$systemDrive = $env:SystemDrive
$diskInfo = Get-Volume | Where-Object { $_.DriveLetter -eq $systemDrive.TrimEnd(':') }
if ($diskInfo) {
    $freeGB = [math]::Round($diskInfo.SizeRemaining / 1GB, 2)
    $totalGB = [math]::Round($diskInfo.Size / 1GB, 2)
    $usedGB = [math]::Round(($diskInfo.Size - $diskInfo.SizeRemaining) / 1GB, 2)
    $usagePercent = [math]::Round(($usedGB / $totalGB) * 100, 2)
    
    Write-Host "Drive: $($diskInfo.DriveLetter):"
    Write-Host "  Total Size: $totalGB GB"
    Write-Host "  Used: $usedGB GB ($usagePercent%)"
    Write-Host "  Free: $freeGB GB"
}

Invoke-PesterTests -TestFile "VisualStudio"
