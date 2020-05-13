################################################################################
##  File:  Install-Haskell.ps1
##  Desc:  Install Haskell for Windows
################################################################################

# Get last 3 latest versions of GHC
$ChocoVersionsOutput = & choco search ghc --allversions --limit-output
$VersionsList = $ChocoVersionsOutput | Where-Object { $_.StartsWith("ghc|") } | ForEach-Object { $_.TrimStart("ghc|") } `
| ForEach-Object { [Version]::Parse($_) } | Sort-Object -Descending

$MajorMinorVersionsToInstall = $VersionsList | ForEach-Object { [System.Version]::Parse($_.ToString(2)) } `
| Get-Unique | Sort-Object -Descending | Select-Object -First 3

$LatestGhcVersions = $MajorMinorVersionsToInstall | ForEach-Object {
    $version = $_
    return $VersionsList | Where-Object {
        return ($_.Major -eq $version.Major) -and ($_.Minor -eq $version.Minor)
    } | Select-Object -First 1
}

# The latest version will be installed as a default
ForEach ($version in $LatestGhcVersions)
{
    Write-Host "Installing ghc $version..."
    Choco-Install -PackageName ghc -ArgumentList "--version", $version, "-m"
}

Write-Host "Installing cabal..."
Choco-Install -PackageName cabal
