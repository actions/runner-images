################################################################################
##  File:  Install-Haskell.ps1
##  Desc:  Install Haskell for Windows
################################################################################

# install minimal ghcup, utilizing pre-installed msys2 at C:\msys64
Write-Host 'Installing ghcup...'
$msysPath = "C:\msys64"
$ghcupPrefix = "C:\"
$cabalDir = "C:\cabal"

$ghcupDownloadURL = "https://downloads.haskell.org/~ghcup/x86_64-mingw64-ghcup.exe"

# If you want to install a specific version of ghcup, uncomment the following lines
# $ghver = "0.1.19.4"
# $ghcupDownloadURL = "https://downloads.haskell.org/~ghcup/${ghver}/x86_64-mingw64-ghcup-${ghver}.exe"

# Other option is to download ghcup from GitHub releases:
# https://github.com/haskell/ghcup-hs/releases/latest

New-Item -Path "$ghcupPrefix\ghcup" -ItemType 'directory' -ErrorAction SilentlyContinue | Out-Null
New-Item -Path "$ghcupPrefix\ghcup\bin" -ItemType 'directory' -ErrorAction SilentlyContinue | Out-Null
Invoke-DownloadWithRetry -Url $ghcupDownloadURL -Path "$ghcupPrefix\ghcup\bin\ghcup.exe"

[Environment]::SetEnvironmentVariable("GHCUP_INSTALL_BASE_PREFIX", $ghcupPrefix, "Machine")
[Environment]::SetEnvironmentVariable("GHCUP_MSYS2", $msysPath, "Machine")
[Environment]::SetEnvironmentVariable("CABAL_DIR", $cabalDir, "Machine")
Add-MachinePathItem "$ghcupPrefix\ghcup\bin"
Add-MachinePathItem "$cabalDir\bin"
Update-Environment

# Get 1 or 3 latest versions of GHC depending on the OS version
If (Test-IsWin25) {
    $numberOfVersions = 1
} else {
    $numberOfVersions = 3
}
$versions = ghcup list -t ghc -r | Where-Object { $_ -notlike "prerelease" }
$versionsOutput = [version[]]($versions | ForEach-Object { $_.Split(' ')[1]; })
$latestMajorMinor = $versionsOutput | Group-Object { $_.ToString(2) } | Sort-Object { [Version] $_.Name } | Select-Object -last $numberOfVersions
$versionsList = $latestMajorMinor | ForEach-Object { $_.Group | Select-Object -Last 1 } | Sort-Object

# The latest version will be installed as a default
foreach ($version in $versionsList) {
    Write-Host "Installing ghc $version..."
    ghcup install ghc $version
    if ($LastExitCode -ne 0) {
        throw "GHC installation failed with exit code $LastExitCode"
    }
    ghcup set ghc $version
    if ($LastExitCode -ne 0) {
        throw "Setting GHC version failed with exit code $LastExitCode"
    }
}

# Add default version of GHC to path
$defaultGhcVersion = $versionsList | Select-Object -Last 1
ghcup set ghc $defaultGhcVersion
if ($LastExitCode -ne 0) {
    throw "Setting default GHC version failed with exit code $LastExitCode"
}

Write-Host 'Installing cabal...'
ghcup install cabal latest
if ($LastExitCode -ne 0) {
    throw "Cabal installation failed with exit code $LastExitCode"
}

Invoke-PesterTests -TestFile 'Haskell'
