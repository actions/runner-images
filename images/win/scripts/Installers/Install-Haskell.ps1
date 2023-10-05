################################################################################
##  File:  Install-Haskell.ps1
##  Desc:  Install Haskell for Windows
################################################################################
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

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
Start-DownloadWithRetry -Url $ghcupDownloadURL -Name "ghcup.exe" -DownloadPath "$ghcupPrefix\ghcup\bin"

Set-SystemVariable "GHCUP_INSTALL_BASE_PREFIX" $ghcupPrefix
Set-SystemVariable "GHCUP_MSYS2" $msysPath
Set-SystemVariable "CABAL_DIR" $cabalDir
Add-MachinePathItem "$ghcupPrefix\ghcup\bin"
Add-MachinePathItem "$cabalDir\bin"

Update-SessionEnvironment

# Get 3 latest versions of GHC
$Versions = ghcup list -t ghc -r | Where-Object {$_ -notlike "prerelease"}
$VersionsOutput = [Version[]]($Versions | ForEach-Object{ $_.Split(' ')[1]; })
$LatestMajorMinor = $VersionsOutput | Group-Object { $_.ToString(2) } | Sort-Object { [Version]$_.Name } | Select-Object -last 3
$VersionsList = $LatestMajorMinor | ForEach-Object { $_.Group | Select-Object -Last 1 } | Sort-Object

# The latest version will be installed as a default
ForEach ($version in $VersionsList)
{
    Write-Host "Installing ghc $version..."
    ghcup install ghc $version
    ghcup set ghc $version
}

# Add default version of GHC to path
$DefaultGhcVersion = $VersionsList | Select-Object -Last 1
ghcup set ghc $DefaultGhcVersion

Write-Host 'Installing cabal...'
ghcup install cabal latest

Invoke-PesterTests -TestFile 'Haskell'
