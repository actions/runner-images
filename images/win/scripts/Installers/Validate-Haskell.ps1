################################################################################
##  File:  Validate-Haskell.ps1
##  Desc:  Validate Haskell for Windows
################################################################################

# GHC validation
if (Get-Command -Name 'ghc')
{
    Write-Host "ghc is on the path"
}
else
{
    Write-Host "ghc is not on path."
    exit 1
}

$ChocoPackagesPath = Join-Path $env:ChocolateyInstall "lib"
[Array] $GhcVersionList = Get-ChildItem -Path $ChocoPackagesPath -Filter "ghc.*" | ForEach-Object { $_.Name.TrimStart("ghc.") }

# Validation that accurate 3 versions of GHC are installed
if ($GhcVersionList.Count -eq 3)
{
    Write-Host "Versions of GHC are accurate"
}
else
{
    Write-Host "Versions of GHC not accurate"
    exit 1
}

# Validation each of GHC version
foreach ($version in $GhcVersionList) 
{
    $BinGhcPath = Join-Path $env:ChocolateyInstall "lib\ghc.$version\tools\ghc-$version\bin\ghc.exe"
    if ((& $BinGhcPath --version) -match $version)
    {
        Write-Host "ghc $version is valid"
    }
    else
    {
        Write-Host "ghc $version is not valid"
        exit 1
    }
}

# Cabal validation
if (Get-Command -Name 'cabal')
{
    Write-Host "cabal is on the path"
}
else
{
    Write-Host "cabal is not on path."
    exit 1
}
