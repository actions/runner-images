################################################################################
##  File:  Install-Haskell.ps1
##  Desc:  Install Haskell for Windows
################################################################################


# The latest version will be installed as a default
$GhcVersions = @('8.6.5', '8.8.3', '8.10.1')

ForEach ($version in $GhcVersions)
{
    Write-Host "Installing ghc $version..."
    Choco-Install -PackageName ghc -ArgumentList "--version", $version, "-m"
}

Write-Host "Installing cabal..."
Choco-Install -PackageName cabal
