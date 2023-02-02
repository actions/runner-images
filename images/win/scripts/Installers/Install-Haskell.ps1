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
$bootstrapHaskell = Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing
Invoke-Command -ScriptBlock ([ScriptBlock]::Create($bootstrapHaskell)) -ArgumentList $false, $true, $true, $false, $true, $false, $false, $ghcupPrefix, "", $msysPath, $cabalDir
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
