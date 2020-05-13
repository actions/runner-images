################################################################################
##  File:  Validate-Haskell.ps1
##  Desc:  Validate Haskell for Windows
################################################################################

# GHC validation
if ((Get-Command -Name 'ghc'))
{
    Write-Host "ghc is on the path"
}
else
{
    Write-Host "ghc is not on path."
    exit 1
}

$SoftwareName = "ghc"
[String] $DefaultGhcVersion = & ghc --version
$ChocoPackagesPath = Join-Path $env:ChocolateyInstall "lib"
$GhcVersionList = Get-ChildItem -Path $ChocoPackagesPath -Filter "ghc.*" | ForEach-Object { $_.Name.TrimStart("ghc.") }

$GhcVersionsDescription = $GhcVersionList | ForEach-Object {
    $DefaultPostfix = if ($DefaultGhcVersion -match $_) { " (default)" } else { "" }
    "ghc $($_) $DefaultPostfix `n"
}

$Description = @"
_Version:_
$GhcVersionsDescription<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description


# Cabal validation
if ((Get-Command -Name 'cabal'))
{
    Write-Host "cabal is on the path"
}
else
{
    Write-Host "cabal is not on path."
    exit 1
}

$SoftwareName = "cabal"

$Description = @"
_Version:_ $(cabal --version)<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description