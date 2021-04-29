################################################################################
##  File:  Install-Haskell.ps1
##  Desc:  Install Haskell for Windows
################################################################################

# Get 3 latest versions of GHC
[Version[]] $ChocoVersionsOutput = & choco search ghc --allversions | Where-Object { $_.StartsWith('ghc ') -and $_ -match 'Approved' } | ForEach-Object { [regex]::matches($_, '\d+(\.\d+){2,}').value }
$MajorMinorGroups = $ChocoVersionsOutput | Group-Object { $_.ToString(2) } | Sort-Object Name -Descending | Select-Object -First 3
$VersionsList = $MajorMinorGroups | ForEach-Object { $_.Group | Select-Object -First 1 } | Sort-Object

# The latest version will be installed as a default
ForEach ($version in $VersionsList)
{
    Write-Host "Installing ghc $version..."
    Choco-Install -PackageName ghc -ArgumentList '--version', $version, '-m'
}

# Add default version of GHC to path, because choco formula updates path on user level
$DefaultGhcVersion = $VersionsList | Select-Object -Last 1
$DefaultGhcShortVersion = ([version]$DefaultGhcVersion).ToString(3)
$DefaultGhcPath = Join-Path $env:ChocolateyInstall "lib\ghc.$DefaultGhcVersion\tools\ghc-$DefaultGhcShortVersion\bin"
# Starting from version 9 haskell installation directory is $env:ChocolateyToolsLocation instead of $env:ChocolateyInstall\lib
if ($DefaultGhcShortVersion -notmatch '^[0-8]\.\d+.*')
{
    $DefaultGhcPath = Join-Path $env:ChocolateyToolsLocation "ghc-$DefaultGhcShortVersion\bin"
}

Add-MachinePathItem -PathItem $DefaultGhcPath

Write-Host 'Installing cabal...'
Choco-Install -PackageName cabal

Invoke-PesterTests -TestFile 'Haskell'
