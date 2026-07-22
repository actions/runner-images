################################################################################
##  File:  Install-Haskell.ps1
##  Desc:  Install Haskell for Windows
################################################################################

# Clean up TEMP_DIR to free disk space before installing GHC
# Accumulated downloads from previous installers can consume 1-2 GB
if ($env:TEMP_DIR -and (Test-Path $env:TEMP_DIR)) {
    Write-Host "Cleaning up TEMP_DIR before Haskell/GHC installation..."
    Get-ChildItem -Path $env:TEMP_DIR | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

# Clean up system temp directories on C: to maximize available space
Write-Host "Cleaning up system temp directories..."
@(
    "C:\Windows\Temp",
    "C:\temp",
    "$env:TEMP",
    "$env:LOCALAPPDATA\Temp"
) | ForEach-Object {
    if (Test-Path $_) {
        Remove-Item -Path $_ -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Clean up package manager caches
Write-Host "Cleaning up package manager caches..."
cmd /c "npm cache clean --force 2>&1" | Out-Null
cmd /c "yarn cache clean 2>&1" | Out-Null

# Report free space before installation
$cDriveFreeGB = [math]::Round((Get-PSDrive C).Free / 1GB, 2)
Write-Host "Free space on C: drive: $cDriveFreeGB GB"

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

# Helper function to read and display ghcup logs
function Read-GhcupLogs {
    $logsPath = "C:\ghcup\logs"
    if (Test-Path $logsPath) {
        Write-Host "--- GHCup Logs ---"
        Get-ChildItem -Path $logsPath -File | ForEach-Object {
            Write-Host "Log file: $($_.Name)"
            Write-Host (Get-Content -Path $_.FullName -Raw)
        }
    } else {
        Write-Host "Log directory not found: $logsPath"
    }
}

# Get 1 or 3 latest versions of GHC depending on the OS version
If (Test-IsWin25-X64) {
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
        Read-GhcupLogs
        throw "GHC installation failed with exit code $LastExitCode"
    }
    ghcup set ghc $version
    if ($LastExitCode -ne 0) {
        Read-GhcupLogs
        throw "Setting GHC version failed with exit code $LastExitCode"
    }
    
    # Clean up ghcup temporary files after each installation
    if (Test-Path "C:\ghcup\tmp") {
        Write-Host "Cleaning up ghcup temp files..."
        Remove-Item "C:\ghcup\tmp" -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Add default version of GHC to path
$defaultGhcVersion = $versionsList | Select-Object -Last 1
ghcup set ghc $defaultGhcVersion
if ($LastExitCode -ne 0) {
    Read-GhcupLogs
    throw "Setting default GHC version failed with exit code $LastExitCode"
}

Write-Host 'Installing cabal...'
ghcup install cabal latest
if ($LastExitCode -ne 0) {
    Read-GhcupLogs
    throw "Cabal installation failed with exit code $LastExitCode"
}

Invoke-PesterTests -TestFile 'Haskell'
