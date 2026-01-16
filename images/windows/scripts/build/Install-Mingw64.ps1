################################################################################
##  File:  Install-Mingw64.ps1
##  Desc:  Install GNU tools for Windows
################################################################################

# Install version specified in the toolset
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

Invoke-PesterTests -TestFile "Tools" -TestName "Mingw64"
