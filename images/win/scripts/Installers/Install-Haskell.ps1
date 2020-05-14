################################################################################
##  File:  Install-Haskell.ps1
##  Desc:  Install Haskell for Windows
################################################################################

# Get 3 latest versions of GHC
[Version[]] $ChocoVersionsOutput = & choco search ghc --allversions --limit-output | Where-Object { $_.StartsWith("ghc|") } | ForEach-Object { $_.TrimStart("ghc|") }
$MajorMinorGroups = $ChocoVersionsOutput | Sort-Object -Descending | Group-Object { $_.ToString(2) } | Select-Object -First 3
$VersionsList = $MajorMinorGroups | ForEach-Object { $_.Group | Select-Object -First 1 } | Sort-Object

# The latest version will be installed as a default
ForEach ($version in $VersionsList)
{
    Write-Host "Installing ghc $version..."
    Choco-Install -PackageName ghc -ArgumentList "--version", $version, "-m"
}

Write-Host "Installing cabal..."
Choco-Install -PackageName cabal
