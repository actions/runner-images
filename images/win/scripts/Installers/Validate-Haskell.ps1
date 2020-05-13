################################################################################
##  File:  Validate-Haskell.ps1
##  Desc:  Validate Haskell for Windows
################################################################################

# GHC validation
if((Get-Command -Name 'ghc'))
{
    Write-Host "ghc is on the path"
}
else
{
    Write-Host "ghc is not on path."
    exit 1
}

$SoftwareName = "ghc"
[String] $GhcVersion =(ghc --version).TrimStart("The Glorious Glasgow Haskell Compilation System, version")
$GhcVersionList =Get-ChildItem -Path (Join-Path $env:ChocolateyInstall “lib”) | Where { $_.Name -match "ghc.*" } | Select-Object -ExpandProperty Name | ForEach-Object {$_.TrimStart("ghc.")}
$GhcVersions = ""

ForEach($version in $GhcVersionList)
{
    if ($version -match $GhcVersion) {
        $GhcVersions += "ghc version $($version) - (default) `n"
    }
    else {
        $GhcVersions += "ghc version $($version)`n"
    }
}

$Description = @"
_Version:_
$GhcVersions<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description


# Cabal validation
if((Get-Command -Name 'cabal'))
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