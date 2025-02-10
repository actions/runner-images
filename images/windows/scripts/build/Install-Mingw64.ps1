################################################################################
##  File:  Install-Mingw64.ps1
##  Desc:  Install GNU tools for Windows
################################################################################

if (Test-IsWin19) {
    # If Windows 2019, install version 8.1.0 form sourceforge
    $baseUrl = "https://download.qt.io/development_releases/prebuilt"

    $("mingw32", "mingw64") | ForEach-Object {
        if ($_ -eq "mingw32") {
            $url = "$baseUrl/mingw_32/i686-8.1.0-release-posix-dwarf-rt_v6-rev0.7z"
            $sha256sum = 'adb84b70094c0225dd30187ff995e311d19424b1eb8f60934c60e4903297f946'
        } elseif ($_ -eq "mingw64") {
            $url = "$baseUrl/mingw_64/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z"
            $sha256sum = '853970527b5de4a55ec8ca4d3fd732c00ae1c69974cc930c82604396d43e79f8'
        } else {
            throw "Unknown architecture $_"
        }

        $packagePath = Invoke-DownloadWithRetry $url
        Test-FileChecksum -Path $packagePath -ExpectedSHA256Sum $sha256sum
        Expand-7ZipArchive -Path $packagePath -DestinationPath "C:\"

        # Make a copy of mingw-make.exe to make.exe, which is a more discoverable name
        # and so the same command line can be used on Windows as on macOS and Linux
        $path = "C:\$_\bin\mingw32-make.exe" | Get-Item
        Copy-Item -Path $path -Destination (Join-Path $path.Directory 'make.exe')
    }

    Add-MachinePathItem "C:\mingw64\bin"

}

if (-not (Test-IsWin19)) {
    # If Windows 2022 0r 2025 install version specified in the toolset
    $version = (Get-ToolsetContent).mingw.version
    $runtime = (Get-ToolsetContent).mingw.runtime

    $("mingw32", "mingw64") | ForEach-Object {
        if ($_ -eq "mingw32") {
            $arch = "i686"
            $threads = "posix"
            $exceptions = "dwarf"
        } elseif ($_ -eq "mingw64") {
            $arch = "x86_64"
            $threads = "posix"
            $exceptions = "seh"
        } else {
            throw "Unknown architecture $_"
        }

        $url = Resolve-GithubReleaseAssetUrl `
            -Repo "niXman/mingw-builds-binaries" `
            -Version "$version" `
            -Asset "$arch-*-release-$threads-$exceptions-$runtime-*.7z"

        $packagePath = Invoke-DownloadWithRetry $url
        Expand-7ZipArchive -Path $packagePath -DestinationPath "C:\"

        # Make a copy of mingw-make.exe to make.exe, which is a more discoverable name
        # and so the same command line can be used on Windows as on macOS and Linux
        $path = "C:\$_\bin\mingw32-make.exe" | Get-Item
        Copy-Item -Path $path -Destination (Join-Path $path.Directory 'make.exe')
    }

    Add-MachinePathItem "C:\mingw64\bin"
}

Invoke-PesterTests -TestFile "Tools" -TestName "Mingw64"
