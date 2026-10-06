################################################################################
##  File:  Install-WDK.ps1
##  Desc:  Install the Windows Driver Kit
################################################################################

# Requires Windows SDK with the same version number as the WDK
if (Test-IsWin22-X64) {
    # SDK is available through Visual Studio
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2324617"
} elseif (Test-IsWin11-Arm64) {
    # SDK is available through Visual Studio
    $wdkUrl = "https://go.microsoft.com/fwlink/?linkid=2335869"
} else {
    throw "Invalid version of Visual Studio is found. Windows Server 2022 is required"
}

# Install all features without showing the GUI using wdksetup.exe
Install-Binary -Type EXE `
    -Url $wdkUrl `
    -InstallArgs @("/features", "+", "/quiet") `
    -ExpectedSubject $(Get-MicrosoftPublisher)

# Chromium's vs_toolchain.py needs Debuggers\x64\dbghelp.dll for its win_clang_x64 host
# toolchain even in a native arm64 build, and nothing creates that folder on ARM64.
# The x64 dbghelp.dll comes from the WDK payload above, so this must stay after the install.
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

Invoke-PesterTests -TestFile "WDK"
