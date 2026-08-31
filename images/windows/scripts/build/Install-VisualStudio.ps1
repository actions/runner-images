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

# On ARM64 the Windows SDK installer never provides the x64 Debugging Tools, so
# Debuggers\x64\dbghelp.dll is missing. Chromium's vs_toolchain.py copies that file for
# its win_clang_x64 host toolchain even in a native arm64 build, so builds fail without it.
# The x64 dbghelp.dll already ships under the SDK bin folder; stage it where it is expected.
if (Test-IsWin11-Arm64) {
    $kitsRoot = "${env:ProgramFiles(x86)}\Windows Kits\10"
    $x64DbgHelp = Get-ChildItem "$kitsRoot\bin\*\x64\dbghelp.dll" -ErrorAction SilentlyContinue `
        | Sort-Object { $_.VersionInfo.FileVersionRaw } -Descending | Select-Object -First 1
    if (-not $x64DbgHelp) {
        throw "x64 dbghelp.dll not found under $kitsRoot\bin - cannot stage x64 Debugging Tools"
    }
    $x64DebuggersDir = Join-Path $kitsRoot "Debuggers\x64"
    New-Item -ItemType Directory -Force -Path $x64DebuggersDir | Out-Null
    # Do not clobber an existing copy - if a future SDK ever ships its own x64 debuggers, keep it.
    $destDbgHelp = Join-Path $x64DebuggersDir "dbghelp.dll"
    if (-not (Test-Path $destDbgHelp)) {
        Copy-Item -Path $x64DbgHelp.FullName -Destination $destDbgHelp -Force
    }
}

Invoke-PesterTests -TestFile "VisualStudio"
