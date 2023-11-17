################################################################################
##  File:  Install-Mingw64.ps1
##  Desc:  Install GNU tools for Windows
################################################################################

if (Test-IsWin19) {
  # If Windows 2019, install version 8.1.0 form sourceforge
  $baseUrl = "https://sourceforge.net/projects/mingw-w64/files"

  $("mingw32", "mingw64") | ForEach-Object {
    if ($_ -eq "mingw32") {
      $url = "$baseUrl/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/8.1.0/threads-posix/dwarf/i686-8.1.0-release-posix-dwarf-rt_v6-rev0.7z/download"
      $sha256sum = 'adb84b70094c0225dd30187ff995e311d19424b1eb8f60934c60e4903297f946'
    } elseif ($_ -eq "mingw64") {
      $url = "$baseUrl/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z/download"
      $sha256sum = '853970527b5de4a55ec8ca4d3fd732c00ae1c69974cc930c82604396d43e79f8'
    } else {
      throw "Unknown architecture $_"
    }

    $packagePath = Start-DownloadWithRetry -Url $url -Name "$_.7z"
    $hash = Get-FileHash -Path $packagePath -Algorithm SHA256
    if ($hash.Hash -ne $sha256sum) {
      throw "Checksum verification failed for $packagePath"
    }
    Extract-7Zip -Path $packagePath -DestinationPath "C:\"

    # Make a copy of mingw-make.exe to make.exe, which is a more discoverable name
    # and so the same command line can be used on Windows as on macOS and Linux
    $path = "C:\$_\bin\mingw32-make.exe" | Get-Item
    Copy-Item -Path $path -Destination (Join-Path $path.Directory 'make.exe')
  }
  
  Add-MachinePathItem "C:\mingw64\bin"

} else {
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

    $url = Get-GitHubPackageDownloadUrl `
      -RepoOwner "niXman" `
      -RepoName "mingw-builds-binaries" `
      -BinaryName "" `
      -Version $version `
      -UrlFilter "*$arch-{Version}-release-$threads-$exceptions-$runtime-*.7z"

    $packagePath = Start-DownloadWithRetry -Url $url -Name "$_.7z"
    Extract-7Zip -Path $packagePath -DestinationPath "C:\"

    # Make a copy of mingw-make.exe to make.exe, which is a more discoverable name
    # and so the same command line can be used on Windows as on macOS and Linux
    $path = "C:\$_\bin\mingw32-make.exe" | Get-Item
    Copy-Item -Path $path -Destination (Join-Path $path.Directory 'make.exe')
  }

  Add-MachinePathItem "C:\mingw64\bin"
}

Invoke-PesterTests -TestFile "Tools" -TestName "Mingw64"
